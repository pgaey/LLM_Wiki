---
source_type: conversation
title: "Nginx + Web 서버 역사 전체 (CGI·WAS·Proxy·이벤트루프)"
captured: 2026-04-18
participants: ["user", "claude"]
reason: "회사에서 nginx.conf에 로그 수집 시도 → 피드백(Nginx 역할과 맞지 않음) → 왜 잘못됐는지 직접 검증하고, Nginx·CGI·WAS·Proxy를 면접에서 설명 가능한 수준으로"
ingest_mode: synthesize
status: raw
tags: [study, nginx, web-server, cgi, was, proxy, event-loop, network]
---

# Nginx + Web 서버 역사 — study session 2026-04-18

## 📌 맥락

- **reason**: 회사에서 React 앱의 console.log를 K8s fluentbit으로 수집하기 위해 nginx.conf에 로그 수집 API 역할을 시켰음. 피드백: "Nginx 역할과 맞지 않음, Sentry가 나음". 왜 잘못됐는지 또는 왜 괜찮은지 직접 판단하고 싶어서 공부.
- **목표 수준**: 면접에서 충분히 설명 가능한 수준 (c~d)
- **3 Session 구조**: Session 1(역사) → Session 2(Proxy) → Session 3(Nginx 아키텍처)

---

## 🔁 Session 1 — Web Server의 탄생 + CGI + WAS

### Q&A 요약

**Q: 정적 파일만 서빙하는 서버로 동적 콘텐츠를 어떻게 해결할까?**
- user: 공통적인 건 두고 변환될 것만 바꾸는 방법 (템플릿+치환)
- 정확한 방향. CGI 설계자들과 동일한 결론.

**Q: 외부 프로세스 방식(CGI) vs 서버 코드 확장 방식 중 뭐가 살아남았나?**
- user: OOP를 생각하면 B (외부 프로세스 방식)
- 정확. "서버는 HTTP 처리에 집중, 비즈니스 로직은 서버가 알 바 아니다"

**Q: CGI의 문제점 (동시 접속 1000명이면)?**
- user: 프로세스를 하나 띄워놓고 그 안에서 요청을 처리하려 했을 것 (RabbitMQ 채널 비유)
- 정확. 그게 FastCGI.

### 🧠 도달한 이해

- **1990**: Tim Berners-Lee가 HTTP 서버 최초 개발. 요청 주소에 맞는 파일을 바이트로 전달. 지금의 Web Server.
- **CGI (Common Gateway Interface)**: 동적 콘텐츠를 위해 외부 프로세스를 실행하는 표준 규약. 요청마다 프로세스 생성 → DB 조회 → HTML string 생성 → stdout으로 HTTP 응답 → 프로세스 종료.
- **CGI 단점**: 요청마다 프로세스 생성·종료 오버헤드. 동시 접속 1000명 = 프로세스 1000개 × 30MB = 30GB RAM.
- **FastCGI**: 프로세스 풀을 미리 띄워놓고 재사용. 프로세스 생성·종료 비용 제거.
- **WAS**: FastCGI의 "계속 살아있는 프로세스"가 DB 커넥션 풀·세션 관리·스레드 풀·라우팅까지 품으면서 독립 서버로 진화한 것. Express 앱, Spring Boot가 WAS.
- **Web Server vs WAS**: 병렬 트랙으로 시작. 분리에서 탄생한 게 아니라 협업 패턴이 표준화.

### 💬 면접 답변 (CGI)

> "CGI는 웹 서버가 동적 콘텐츠를 처리하기 위해 외부 프로그램을 실행하는 표준 규약입니다. HTTP 요청이 들어오면 웹 서버가 해당 경로에 매핑된 스크립트를 별도 프로세스로 실행하고, 그 스크립트가 DB 조회나 비즈니스 로직을 처리해 HTML을 생성한 뒤 stdout으로 출력합니다. 웹 서버는 이 출력을 HTTP 응답으로 감싸 브라우저에 반환하고, 프로세스는 종료됩니다. 단점은 요청마다 프로세스를 생성·종료하는 오버헤드가 크다는 점이었고, 이를 해결한 것이 FastCGI입니다."

### 💬 CGI vs FastCGI 한 문장

> "CGI는 요청마다 프로세스를 생성·종료해 오버헤드가 크고, FastCGI는 프로세스 풀을 미리 띄워놓고 재사용해서 그 비용을 없앤 방식입니다."

---

## 🔁 Session 2 — Proxy (Forward / Reverse)

### 🧠 도달한 이해

**Web Server가 WAS 앞에 있는 이유:**
1. 가볍다 — Nginx는 C 기반 이벤트루프, WAS는 무거운 런타임
2. 정적 파일 직접 서빙 — WAS 부하 감소
3. SSL 종료 — HTTPS 처리를 Nginx에서만
4. 로드밸런싱 — WAS 여러 대에 요청 분산
5. 보안 — WAS를 인터넷에 직접 노출 안 함
6. 캐싱 — 동일 요청 재처리 불필요

**Forward Proxy**: 클라이언트 대리인. 브라우저와 인터넷 사이. 클라이언트가 설정. (VPN, 사내 방화벽)

**Reverse Proxy**: 서버 대리인. 인터넷과 WAS 사이 (= Nginx 위치). 클라이언트는 존재 모름. 개발자가 설정.

**CDN (Content Delivery Network)**: 전 세계에 퍼진 Reverse Proxy + 캐시 네트워크.

| | Forward Proxy | Reverse Proxy |
|--|--|--|
| 대리 대상 | 클라이언트 | 서버 |
| 누가 설정 | 클라이언트 | 서버(개발자) |
| 클라이언트 인지 | 설정함 | 모름 |
| 사용 예 | VPN, 방화벽 | Nginx, CDN, LB |

---

## 🔁 Session 3 — C10K + Nginx 이벤트루프

### C10K 문제 (1999)

Apache 방식: 접속마다 스레드 생성. 10,000 × 2MB = 20GB RAM. 대부분 idle 상태로 메모리 점유.

### 이벤트루프 동작

```
이벤트 도착 → 워커가 큐에서 꺼냄
    ↓
I/O 작업? → YES: OS에 위임 → 다음 이벤트로 → OS 완료 → 완료 큐 → 워커 마무리
    ↓
           NO (CPU 작업): 워커가 직접 실행 → 끝날 때까지 블로킹
```

**OS에 위임 가능 (I/O)**: 파일 읽기/쓰기, 네트워크 소켓, DB 쿼리 소켓, DNS

**OS에 위임 불가 (CPU)**: 문자열 파싱, 암호화 계산, 이미지 처리, 로그 포맷팅/집계

Nginx는 epoll(Linux) / kqueue(macOS)로 1만 개 소켓을 동시 감시. 워커는 CPU 코어 수만큼만 존재.

---

## 🎯 핵심 판단 — 네 케이스

**상황**: React 앱 → POST /log → nginx.conf → K8s fluentbit

**왜 Nginx에 로그 수집이 맞지 않는가 (3가지):**

1. **역할 관점**: Nginx는 HTTP 관문 서버 (정적 서빙, 프록시, TLS, LB). 로그 수집은 애플리케이션 레벨 작업. 동작은 하지만 책임 분리 원칙에 어긋남.

2. **이벤트루프 관점**: 로그 파싱·포맷팅·집계는 CPU 작업 → OS에 위임 불가 → 워커 블로킹. 로그를 많이 쏠수록 Nginx에서 정체 발생. 1만 명 동시 처리하던 Nginx가 로그 파싱으로 막히는 구조.

3. **대안 관점**: Sentry = 에러 캡처, stack trace, 사용자 맥락, 대시보드 자동 제공. BE 로그 API = 구조화된 로그, 비즈니스 로직 통합. 둘 다 목적에 맞고 유지보수 비용 낮음.

**결론**: 시도의 의도(비용 최소화, BE 수정 없이)는 옳았으나 도구 선택이 Nginx 특성과 맞지 않았음. 틀린 사고가 아닌 도구 이해의 문제.

## 🆕 식별된 낯선 용어 / 다음 학습 타겟

- [[epoll]] — Linux 커널 I/O 이벤트 감지 메커니즘 (별도 소스 필요)
- [[kqueue]] — macOS/BSD 버전의 epoll
- [[php-fpm]] — PHP FastCGI Process Manager (FastCGI 실제 구현체)
- [[libuv]] — Node.js 이벤트루프 구현 라이브러리
- [[ssl-tls]] — Nginx SSL 종료 메커니즘

## 🔗 관련 wiki 페이지 (생성 예정)

- [[web-server-history]] (network/)
- [[cgi]] (network/)
- [[fastcgi]] (network/)
- [[was]] (network/)
- [[reverse-proxy]] (network/)
- [[forward-proxy]] (network/)
- [[cdn]] (network/)
- [[event-loop]] (javascript/)
- [[nginx-architecture]] (network/)

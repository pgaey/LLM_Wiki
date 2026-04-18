---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[cgi]]", "[[fastcgi]]", "[[was]]", "[[nginx-architecture]]"]
updated: 2026-04-18
status: draft
tags: [network, web-server, history]
---

# Web 서버의 역사

## 한 줄 정의

HTTP 서버의 탄생부터 WAS 분리까지 — 정적 파일 서빙에서 동적 처리로의 진화.

## 타임라인

```
1990  Tim Berners-Lee → CERN httpd
      요청 주소에 맞는 파일을 바이트로 전달. 지금의 Web Server.

1993  동적 콘텐츠 필요 (방명록, 검색)
      → [[cgi]] 탄생. 외부 프로세스로 처리.

1995  Apache HTTP Server 탄생
      CGI 포함. 스레드 per 접속 방식.

1996  [[fastcgi]] 탄생
      프로세스 풀 재사용으로 CGI 오버헤드 해결.

1999  [[was]] 독립 (Tomcat)
      FastCGI 개념이 독립 애플리케이션 서버로 진화.

1999  C10K 문제 제기 (Dan Kegel)
      동시 접속 1만 명을 어떻게?

2004  [[nginx-architecture]] 탄생
      이벤트루프 기반. C10K 해결.
```

## Web Server vs WAS

| | Web Server (Nginx) | WAS (Tomcat, Express) |
|--|--|--|
| 역할 | HTTP 관문. 정적 파일, 프록시, TLS | 동적 처리. 비즈니스 로직 |
| 상태 | Stateless | 세션·DB 커넥션 유지 |
| 언어 | 무관 | 런타임 종속 (JVM, Node, Python) |
| 속도 | 빠름 (C, 이벤트루프) | 상대적으로 무거움 |

## 관계

Web Server와 WAS는 하나에서 분리된 게 아닌 **병렬 트랙으로 발전**. 협업 패턴이 표준화된 것.

```
[브라우저]
    ↓
[Web Server (Nginx)]  ← 정적 파일, SSL, 로드밸런싱
    ↓ 동적 요청만
[WAS (Express/Spring)] ← DB 조회, 비즈니스 로직
    ↓
[DB]
```

## 관련 개념

- [[cgi]] — 동적 처리의 시작
- [[fastcgi]] — CGI 오버헤드 해결
- [[was]] — FastCGI가 독립 서버로 진화
- [[nginx-architecture]] — C10K 해결
- [[reverse-proxy]] — Web Server가 WAS 앞에 서는 패턴

---
type: concept
sources: ["[[2026-04-18-http-https-tcp-tls]]"]
related: ["[[tcp]]", "[[tls-handshake]]", "[[nginx-architecture]]"]
updated: 2026-04-18
status: draft
tags: [network, http, https, tls, certificate, ca]
---

# HTTP / HTTPS / TLS

## 한 줄 정의

HTTP는 TCP 위에서 평문 전송. HTTPS는 TCP 위에 TLS 암호화 레이어를 추가한 것. 도청·위변조 방지 + 서버 신원 확인이 목적.

## 레이어 구조

```
[ HTTP  ] ← 요청/응답 내용
[ TLS   ] ← 암호화 레이어 (HTTPS에만 있음)
[ TCP   ] ← 연결 파이프
```

## 왜 HTTPS로 redirect 하는가

HTTP(80포트)로 오는 요청을 HTTPS(443포트)로 강제 전환. 목적 세 가지:

1. **도청 방지** — 평문 전송 차단
2. **위변조 방지** — 중간에서 내용 못 바꾸게
3. **서버 신원 확인** — 진짜 그 서버임을 인증서로 보장

**HSTS** (HTTP Strict Transport Security): 브라우저가 처음부터 HTTPS로만 요청하게 강제하는 응답 헤더. redirect 단계 자체를 없애는 더 강한 방식.

## 인증서 발급 흐름 (CA)

**CA (Certificate Authority)** — 서버의 신원을 보증하는 공인 인증기관.

```
1. 서버 운영자 → CA : 도메인 소유권 증명 (CSR 제출)
2. CA              : 검증 후 인증서 발급 (CA 개인키로 서명 포함)
3. CA 공개키       : 브라우저/OS에 미리 내장 (설치 시 함께 들어옴)
```

## HTTPS 연결 전체 흐름

### 1. TCP 3-way Handshake
SYN → SYN-ACK → ACK. 파이프 수립.

### 2. TLS Handshake — Client Hello

클라이언트가 아래 세 가지를 한 번에 전송:

```
- TLS 버전 리스트        (지원하는 버전 목록. 서버가 하나 선택)
- 암호화 알고리즘 리스트  (나중에 대칭키 암호화에 쓸 방식. 서버가 하나 선택)
- Client Random         (세션키 재료. 평문 전송)
```

### 3. TLS Handshake — Server Hello

서버가 아래 네 가지를 한 번에 전송:

```
- 선택한 TLS 버전
- 선택한 암호화 알고리즘
- Server Random  (세션키 재료. 평문 전송)
- 인증서         (도메인·서버공개키·유효기간·CA발급정보·서명 포함)
```

**인증서 구조:**
```
본문 = 도메인 + 서버 공개키 + 유효기간 + CA 발급정보
서명 = 본문 전체를 해시 → CA 개인키로 암호화한 값
```
서명만 암호화되어 있고 나머지는 평문.

### 4. 인증서 검증

```
① CA 발급정보를 보고 → 내장된 CA 공개키 특정
② CA 공개키로 서명 복호화 → 해시값 A
③ 인증서 본문을 직접 해시 → 해시값 B
④ A == B + 도메인 일치 + 유효기간 → 신뢰
```

CA가 뭔가를 보내주는 게 아니라 클라이언트가 직접 계산해서 비교한다.  
CA 목록에 없는 CA면 → "이 연결은 안전하지 않습니다" 경고.

**인증서 체인 (Chain of Trust):**  
서버는 Root CA까지 이어지는 인증서 체인 전체를 보냄. 클라이언트가 체인 따라 Root CA까지 검증.

### 5. 세션키 교환

```
① 클라이언트: pre-master secret (랜덤값) 생성
② 클라이언트: 서버 공개키로 암호화해서 전송
③ 서버      : 서버 개인키(private key)로 복호화 → pre-master secret 획득
④ 양쪽 모두 : PRF 알고리즘으로 세션 대칭키 도출

   Client Random + Server Random + pre-master secret → 세션 대칭키
```

- 비대칭키는 이 교환에만 사용. 이후엔 대칭키 (훨씬 빠름)
- 세 랜덤값을 섞는 이유: 매 세션마다 다른 세션키 보장

### 6. Finished

```
클라이언트 → 서버 : Finished (주고받은 핸드셰이크 메시지 전체를 해시 → 대칭키로 암호화)
서버 → 클라이언트 : Finished (동일)
```

상대방이 복호화 성공 = 같은 세션키를 갖고 있고 중간에 아무도 안 건드렸다는 검증.

### 7. HTTP 통신

세션 대칭키로 암호화된 HTTP 요청/응답 교환.

## 왜 HTTPS가 HTTP보다 느린가

TCP handshake + TLS handshake(인증 검증 + 세션키 교환)가 추가되기 때문. 연결 수립 후엔 대칭키라 속도 차이 크지 않음.

## 관련 개념

- [[tcp]] — 연결 파이프 수립
- [[tls-handshake]] — 세션키 계산 디테일
- [[nginx-architecture]] — Nginx의 SSL 종료(TLS 처리) 역할

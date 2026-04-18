---
type: concept
sources: ["[[2026-04-18-http-https-tcp-tls]]"]
related: ["[[http-https-tls]]", "[[tls-handshake]]"]
updated: 2026-04-18
status: draft
tags: [network, tcp, connection]
---

# TCP (Transmission Control Protocol)

## 한 줄 정의

데이터를 주고받기 전에 양쪽이 연결을 맺는 프로토콜. HTTP든 HTTPS든 TCP가 먼저 깔려야 동작한다.

## 3-way Handshake

```
Client → Server : SYN     ("연결할게")
Server → Client : SYN-ACK ("알겠어")
Client → Server : ACK     ("확인")
```

이 3단계가 끝나면 데이터 전송 파이프가 열린다.

## HTTP/HTTPS와의 관계

```
[ HTTP  ] ← 내용
[ TLS   ] ← 암호화 (HTTPS만)
[ TCP   ] ← 연결 (공통)
```

TCP는 파이프를 만드는 역할. HTTP는 그 파이프 위에서 평문 전송, HTTPS는 TLS 암호화 레이어를 추가한 것.

## 관련 개념

- [[http-https-tls]] — TCP 위에서 동작하는 HTTP/HTTPS 전체 흐름
- [[tls-handshake]] — TCP 연결 이후 TLS가 하는 일

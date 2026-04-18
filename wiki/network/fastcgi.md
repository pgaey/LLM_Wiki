---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[cgi]]", "[[was]]", "[[nginx-architecture]]"]
updated: 2026-04-18
status: draft
tags: [network, fastcgi, web-server]
---

# FastCGI

## 한 줄 정의

CGI의 "요청마다 프로세스 생성·종료" 오버헤드를 **프로세스 풀 재사용**으로 해결한 방식.

## CGI와의 차이

| | CGI | FastCGI |
|--|--|--|
| 프로세스 | 요청마다 생성·종료 | 풀로 미리 띄워두고 재사용 |
| 메모리 | 요청 수 × 30MB | 풀 크기 × 30MB (고정) |
| 속도 | 프로세스 생성 비용 있음 | 소켓으로 바로 전달 |

## 흐름

```
[Nginx]                    [FastCGI 프로세스 풀 - 항상 살아있음]
  요청 수신
  → 소켓으로 요청 전달  →  요청 받아서 처리
  → 결과 받아서 응답  ←    HTML string 반환
  → 다음 요청
  → 소켓으로 전달     →   (같은 프로세스가 또 처리)
```

## RabbitMQ 비유

```
RabbitMQ: Connection 한 번 → Channel로 message 계속 전달
FastCGI:  Process 한 번 띄움 → 소켓으로 요청 계속 전달
```

## Nginx 설정에서

```nginx
location /api {
    fastcgi_pass 127.0.0.1:9000;  # FastCGI 프로세스에게 넘김
}
```

## 실제 구현체

- **PHP-FPM** (FastCGI Process Manager) — PHP의 FastCGI 구현
- Express, Spring Boot 앱 자체도 FastCGI 철학의 산물 (프로세스 하나가 계속 떠서 요청 처리)

## 한 줄 면접 답변

> "CGI는 요청마다 프로세스를 생성·종료해 오버헤드가 크고, FastCGI는 프로세스 풀을 미리 띄워놓고 재사용해서 그 비용을 없앤 방식입니다."

## 관련 개념

- [[cgi]] — 선조. 요청마다 프로세스.
- [[was]] — FastCGI 개념이 독립 서버로 진화한 것.

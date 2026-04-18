---
source_type: conversation
title: "HTTP / HTTPS / TCP / TLS 흐름"
captured: 2026-04-18
participants: ["user", "claude"]
reason: "이전에 공부했던 HTTP/HTTPS/TCP + 인증서 내용을 wiki에 기록하고 까먹지 않게 복습"
ingest_mode: synthesize
status: raw
tags: [study, network, http, https, tcp, tls, certificate, ca]
---

# HTTP / HTTPS / TCP / TLS 흐름 — study session 2026-04-18

## 📌 맥락
- **reason**: 이전에 공부했던 HTTP/HTTPS/TCP + 인증서 내용을 wiki에 기록하고 까먹지 않게 복습
- **선행 지식 (user)**: HTTP→HTTPS redirect 알고 있음. 인증서·CA 흐름 대략 알고 있으나 TLS handshake 중간 단계 헷갈림
- **세션 목표 수준**: c (30초 말로 설명 가능)

## 🔁 티키타카 (Q&A 요약)

### Q1. TCP와 TLS의 관계
**user**: "채널 하나 열어놓고 그 안에서 통신하는 거 같다. Transport Security protocol?"  
**claude**: TLS(Transport Layer Security). 레이어 구조: HTTP > TLS > TCP  
→ **이해 포인트**: TCP는 파이프(연결), TLS는 그 파이프 위의 암호화 레이어

### Q2. 왜 HTTPS가 느린가
**user**: "내용을 암호화하고, 서로가 가지게 될 키로 복호화하는 과정과 인증 과정이 추가되기 때문"  
→ **이해 포인트**: TCP handshake + TLS handshake 추가. 이후 대칭키라 빠름

### Q3. 인증서 검증 메커니즘 (막힌 지점)
- user가 "CA가 브라우저에 전달했던 인증서 내용과 비교" 라고 표현 → 수정 필요
- 실제: CA가 뭔가를 보내는 게 아니라 브라우저가 직접 계산·비교
- CA 공개키로 서명 복호화 → 해시A / 인증서 본문 직접 해시 → 해시B / A==B 확인

### Q4. pre-master secret
**user**: "브라우저가 아무거나 만들어?"  
→ 맞음. 완전 랜덤값. 매 세션마다 달라서 한 세션 뚫려도 다른 세션 안전.

## 🧠 도달한 이해 (user 언어로 정리)

서버는 CA에 인증 요청 → CA가 인증서 발급(CA 개인키로 서명 포함).  
CA 공개키는 브라우저/OS에 미리 내장.

클라이언트가 TCP 3-way handshake로 연결 수립 후 TLS Handshake 시작.  
Client Hello(TLS 버전+암호화 방식 리스트) → Server Hello(선택한 방식+서버 공개키+인증서).  
브라우저: CA 공개키로 서명 복호화 → 해시A, 인증서 본문 해시 → 해시B, A==B + 도메인·유효기간 확인.  
브라우저가 랜덤 pre-master secret 생성 → 서버 공개키로 암호화 전송.  
서버가 개인키로 복호화 → 양쪽이 동일한 세션 대칭키 계산.  
이후 HTTP 통신은 대칭키로 암호화.

HTTP→HTTPS redirect: 80포트 요청을 443으로 강제. 목적은 도청·위변조 방지 + 서버 신원 확인.

## 🆕 식별된 낯선 용어 / 다음 학습 타겟
- [[tls-handshake]] — 세션키 계산 공식(pre-master + random 두 개) 디테일
- [[hsts]] — HTTP Strict Transport Security, redirect 없이 강제 HTTPS
- [[asymmetric-key]] — 비대칭키(공개키/개인키) 원리
- [[symmetric-key]] — 대칭키 원리 및 왜 빠른가

## 🔗 관련 wiki 페이지
- [[http-https-tls]] (신규 생성 대상)
- [[tcp]] (신규 생성 대상)
- [[tls-handshake]] (신규 생성 대상)
- [[nginx-architecture]] — SSL 종료 언급 있음

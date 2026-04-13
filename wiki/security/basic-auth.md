---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[http-authentication]]", "[[authorization-header]]", "[[base64]]"]
updated: 2026-04-13
status: stub
tags: [concept, http, auth]
---

# Basic 인증

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — "가장 기본적인 HTTP 인증 방식, ID:PW를 [[base64]] 인코딩해서 헤더에 붙임" 정도로 시작)_

## 헤더 형식

```
Authorization: Basic base64({USERNAME}:{PASSWORD})
```

정의: **RFC 7617**

## 장점

_(읽은 후 — 단순함·간편함 관련)_

## 단점 / 함정

_(읽은 후)_
- [[base64]] 는 **암호화가 아님** — HTTPS 필수.
- 서버에 사용자 목록 저장 → 확장성 문제.
- 세밀한 권한 제어 어려움.

## 실제 사용 예

- 토스페이먼츠 **코어 API** (결제, 결제 취소, 현금영수증): `Authorization: Basic base64(SECRET_KEY:)`

## 관련 개념

- [[authorization-header]] — 부모 문법
- [[base64]] — credentials 인코딩에 씀
- [[bearer-auth]] — 대안적 인증 방식

## 출처

- [[2026-04-13-toss-basic-bearer-auth]]

---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[http-authentication]]", "[[basic-auth]]", "[[bearer-auth]]"]
updated: 2026-04-13
status: stub
tags: [concept, http, auth]
---

# Authorization 헤더

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후)_

## 공통 문법

```
Authorization: <type> <credentials>
```

- `<type>`: 인증 방식 — `Basic`, `Bearer`, `Digest`, `Negotiate` 등
- `<credentials>`: 타입마다 형식이 다름

## 왜 이렇게 설계됐나

_(읽은 후 — 내 이해)_

## 상태 코드 짝

- `200 OK` — 인증 성공
- `401 Unauthorized` — 인증 누락/실패
- `403 Forbidden` — 인증은 됐으나 권한 없음

## 관련 개념

- [[http-authentication]] — 상위 개념
- [[basic-auth]] — `<type> = Basic`
- [[bearer-auth]] — `<type> = Bearer`

## 출처

- [[2026-04-13-toss-basic-bearer-auth]]

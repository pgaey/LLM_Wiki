---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[basic-auth]]", "[[jwt]]"]
updated: 2026-04-13
status: stub
tags: [concept, encoding]
---

# Base64 인코딩

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — "바이너리 데이터를 ASCII 64자로 표현하는 인코딩. 암호화 아님.")_

## ⚠️ 가장 중요한 오해

**Base64 ≠ 암호화.** 쉽게 복호화됨.
- 그래서 [[basic-auth]] 는 **HTTPS 없이는 무의미**.

## 쓰임새

- [[basic-auth]] credentials 인코딩 (`USERNAME:PASSWORD` → base64)
- [[jwt]] 각 파트 인코딩 (Header/Payload/Signature)
- 이메일 첨부·이미지 인라인(data URI) 등

## 왜 64자인가

_(읽은 후 — ASCII 안전 문자 중 64개 선택)_

## 관련 개념

- [[basic-auth]] — 주요 소비처
- [[jwt]] — 토큰 인코딩에 사용

## 출처

- [[2026-04-13-toss-basic-bearer-auth]] (언급)
- MDN: https://developer.mozilla.org/en-US/docs/Glossary/Base64

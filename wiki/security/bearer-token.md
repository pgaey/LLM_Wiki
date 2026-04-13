---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[bearer-auth]]", "[[oauth-2]]", "[[jwt]]"]
updated: 2026-04-13
status: stub
tags: [concept, auth, token]
---

# Bearer 토큰

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — "[[oauth-2]] 에서 Access Token으로 쓰이는 토큰 유형. 소유자(Bearer)에게 권한을 부여한다는 의미")_

## 핵심 속성

- **불투명 (Opaque)**: 클라이언트는 내용을 해석 못 해야 함.
- **사용자 정보 금지**: 토큰 자체에 사용자 정보 넣지 않음.
- **서버 검증용 메타데이터 포함**: 서버가 권한을 확인할 수 있는 정보만.
- **충분히 복잡한 알고리즘**으로 발급.

## 토큰 형태

- 16진수 랜덤 문자열
- **[[jwt]]** (JSON Web Token)
- 기타 인증 서버가 정의한 형태

## 왜 "불투명"해야 하나

_(읽은 후 — 클라이언트가 토큰 내용 파싱해서 사용자 정보 유출/변조 방지)_

## 관련 개념

- [[bearer-auth]] — 토큰을 쓰는 인증 방식
- [[oauth-2]] — 토큰을 발급하는 프레임워크
- [[jwt]] — 가장 흔한 Bearer 토큰 구현체

## 출처

- [[2026-04-13-toss-basic-bearer-auth]]

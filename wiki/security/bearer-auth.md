---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[http-authentication]]", "[[authorization-header]]", "[[oauth-2]]", "[[bearer-token]]"]
updated: 2026-04-13
status: stub
tags: [concept, http, auth]
---

# Bearer 인증

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — "[[oauth-2]] 프레임워크에서 쓰는 토큰 인증 방식. '이 토큰을 든 사람(Bearer)에게 권한을 준다'.")_

## 헤더 형식

```
Authorization: Bearer <token>
```

정의: **RFC 6750**

## 핵심 특성

- 토큰이 **메타데이터**를 품고 있어 서버가 보관할 필요 없음 → 확장성 좋음.
- 토큰은 **불투명**해야 함 (클라이언트가 해석할 수 없어야).
- 만료 시간 설정 가능 / 권한 철회 가능.

## 장점 vs 단점

_(읽은 후)_

## 함정

- 토큰 탈취 시 누구나 리소스 접근 가능 → HTTPS 필수 + 탈취 감지 시 토큰 철회 플로우 필요.

## 실제 사용 예

- 토스페이먼츠 **브랜드페이** (고객 민감 정보 보호): `Authorization: Bearer <access_token>`

## 관련 개념

- [[authorization-header]] — 부모 문법
- [[oauth-2]] — Bearer 인증이 쓰이는 상위 프레임워크
- [[bearer-token]] — 토큰 자체의 형태·구조
- [[basic-auth]] — 대안적 인증 방식

## 출처

- [[2026-04-13-toss-basic-bearer-auth]]

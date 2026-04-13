---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[bearer-token]]", "[[oauth-2]]"]
updated: 2026-04-13
status: stub
tags: [concept, auth, token]
---

# JWT (JSON Web Token)

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — 이번 아티클에서는 이름만 등장. 별도 소스에서 더 정리 예정.)_

## 구조 (TBD — 추가 소스 필요)

```
<Header>.<Payload>.<Signature>
```

- Header: 알고리즘 등 메타
- Payload: Claims (권한·만료 등)
- Signature: 변조 검증용

## 위치

- [[bearer-token]] 의 한 **구현체**. JWT 자체가 인증 방식은 아님.
- [[oauth-2]] 의 Access Token 으로 자주 사용됨.

## 헷갈리기 쉬운 점

- **JWT = 인증 방식이 아님.** JWT는 토큰의 "포맷". 인증은 여전히 [[bearer-auth]].
- JWT는 **암호화가 아니라 서명**. Payload는 누구나 디코딩 가능 (민감 정보 넣지 말 것).

## 관련 개념

- [[bearer-token]] — JWT의 상위 카테고리
- [[oauth-2]] — 주로 쓰이는 맥락
- [[base64]] — JWT 각 부분 인코딩에 쓰임

## 출처

- [[2026-04-13-toss-basic-bearer-auth]] (간단 언급)
- https://jwt.io/ (참조)
- ⚠️ **별도 전용 소스 필요** — 다음 ingest 후보.

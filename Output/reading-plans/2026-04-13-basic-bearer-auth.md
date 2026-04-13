---
type: reading-plan
based_on: ["[[2026-04-13-toss-basic-bearer-auth]]"]
created: 2026-04-13
purpose: "Basic/Bearer 인증을 30초로 설명할 수 있는 수준까지 가져가기"
---

# 📖 읽기 플랜 — Basic/Bearer 인증 (토스페이먼츠)

## 메타

- **원본**: [Basic 인증과 Bearer 인증의 모든 것](https://docs.tosspayments.com/blog/everything-about-basic-bearer-auth)
- **예상 읽기 시간**: 11분 (원본 표기) + 정리 15~20분 = **총 30분 세션 권장**
- **reason**: HTTP 통신·인증/인가(OAuth 포함)는 중요하면서 복잡한 개념이라 정리 필요
- **선행 지식 확인**: 요청/응답 구조, HTTP 헤더 개념, 상태 코드 감각

## 🎯 집중 포인트 3가지

### 1. `Authorization` 헤더의 공통 문법

```
Authorization: <type> <credentials>
```

이게 모든 HTTP 인증의 **공통 분모**. Basic이든 Bearer든 결국 `<type>`과 `<credentials>`만 달라질 뿐. → [[authorization-header]]

### 2. Basic vs Bearer의 "왜" 차이

둘을 암기로 외우지 말고 **"서버가 무엇을 저장하는가"** 관점으로.

- **Basic**: 서버에 사용자 목록 저장 → 확장성 문제 + 권한 세분화 어려움.
- **Bearer**: 토큰이 메타데이터를 품음 → **서버는 토큰을 보관할 필요 없음** → 검증 시간이 사용자 수에 비례하지 않음.

→ [[basic-auth]] vs [[bearer-auth]]

### 3. OAuth 2.0의 4대 역할

리소스 소유자 / 클라이언트 / 인증 서버 / 리소스 서버 — 이 4명이 어떻게 주고받는지의 흐름을 머릿속에 그림으로. 특히 **인증 서버와 리소스 서버가 왜 분리**되었는지. → [[oauth-2]]

## ⚠️ 예상 막힐 부분 (함정 알림)

| 함정 | 주의 |
|------|------|
| "Base64 인코딩 = 암호화" 착각 | 아님. 쉽게 복호화됨. → [[basic-auth]]는 HTTPS 없이 무의미 |
| "Bearer 토큰 = JWT" 착각 | [[jwt]] 는 Bearer 토큰의 한 **구현체**일 뿐 |
| "Bearer 토큰을 클라이언트가 해석" | 금지. 불투명해야 함 (사용자 정보 유출 방지) |
| "JWT Payload는 암호화됨" 착각 | Payload는 [[base64]] 인코딩 — 누구나 디코딩. 민감 정보 금지 |

## 📝 읽은 후 자문 리스트 (설명 가능성 테스트)

각 질문에 **30초로 말로** 답할 수 있으면 통과:

- [ ] `Authorization: Basic aGVsbG86d29ybGQ=` 의 Basic 뒤 문자열은 어떻게 만들어진 거지?
- [ ] Basic 인증을 HTTPS 없이 쓰면 어떤 위험이 있나?
- [ ] Bearer 토큰과 JWT의 관계를 한 문장으로.
- [ ] OAuth 2.0의 4대 역할을 내 말로 설명해보기.
- [ ] 토스페이먼츠는 왜 **코어 API에 Basic**, **브랜드페이에 Bearer**을 썼을까?
- [ ] `401 Unauthorized` 와 `403 Forbidden` 의 차이는?
- [ ] "서버에 상태를 저장하는가" 관점에서 Basic과 Bearer가 어떻게 다른가?

## 🧭 읽은 후 할 일

1. **graph view 확인** — 생성된 스텁 8개가 어떻게 연결됐는지 눈으로 확인 (Obsidian → 좌측 graph 아이콘).
2. `/ingest raw/articles/2026-04-13-Basic 인증...md` **재호출**.
3. 스킬이 "이제 읽었어?" 물으면 → `synthesize` 모드로 승격.
4. 각 스텁을 자문 리스트 답변으로 채움 → `status: stub → draft`.
5. 막힌 질문은 **다음 학습 타겟**으로 별도 캡처.

## 🕸 관련 스텁 (graph 시작점)

- [[http-authentication]] 🎯 허브
- [[authorization-header]]
- [[basic-auth]]
- [[bearer-auth]]
- [[oauth-2]]
- [[bearer-token]]
- [[jwt]] — 이 글에선 이름만. 별도 소스 필요.
- [[base64]]

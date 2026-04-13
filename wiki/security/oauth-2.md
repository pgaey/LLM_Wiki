---
type: concept
sources: ["[[2026-04-13-toss-basic-bearer-auth]]"]
related: ["[[bearer-auth]]", "[[bearer-token]]"]
updated: 2026-04-13
status: stub
tags: [concept, auth, oauth]
---

# OAuth 2.0

> 🟡 **Status: stub** — 읽고 나서 채움.

## 한 줄 정의

_(읽은 후 — "제 3자 클라이언트에게 보호된 리소스를 **제한적으로** 접근하게 해주는 인가(Authorization) 프레임워크")_

## 왜 생겼나

_(읽은 후 — "구글 소셜 로그인처럼 비밀번호를 공유하지 않고도 권한을 위임할 방법이 필요해서")_

## 4대 역할 (핵심)

| 역할 | 뭐야 |
|------|------|
| 리소스 소유자 (Resource Owner) | 사용자 |
| 클라이언트 (Client) | 사용자 데이터에 접근하려는 제 3자 서비스 |
| 인증 서버 (Authorization Server) | 클라이언트 접근 관리 — 토큰 발급 |
| 리소스 서버 (Resource Server) | 실제 데이터 보관 |

## 흐름

_(읽은 후 단계별로)_
```
1) 사용자가 클라이언트에 접근 동의
2) 인증 서버가 Access Token 발급
3) 클라이언트가 토큰으로 리소스 서버에 요청
4) 리소스 서버가 토큰 유효성 검증 후 데이터 반환
```

## 왜 인증 서버와 리소스 서버를 분리하나

_(읽은 후 — 책임 분리 관점)_

## 관련 개념

- [[bearer-auth]] — OAuth가 Bearer 인증을 씀
- [[bearer-token]] — Access Token의 표현 형태
- [[jwt]] — 흔한 토큰 포맷

## 출처

- [[2026-04-13-toss-basic-bearer-auth]]
- https://oauth.net/2/ (참조)

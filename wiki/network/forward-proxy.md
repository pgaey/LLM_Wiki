---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[reverse-proxy]]", "[[cdn]]"]
updated: 2026-04-18
status: draft
tags: [network, proxy]
---

# Forward Proxy

## 한 줄 정의

**클라이언트 대리인**. 클라이언트가 직접 설정하고, 나가는 요청을 앞에서 가로채는 서버.

## 위치

```
[브라우저] → [Forward Proxy] → [인터넷] → [목적 서버]
               ↑
         클라이언트가 직접 설정
         목적 서버는 클라이언트 IP 모름 (Proxy IP만 앎)
```

## 역할

- **접근 제어**: 특정 사이트 차단 (회사 방화벽, 학교 네트워크)
- **익명 우회**: 목적 서버에 클라이언트 IP 숨김
- **공통 캐시**: 100명이 같은 파일 요청 → 첫 번째만 외부 요청, 나머지는 캐시

## Reverse Proxy와 차이

| | Forward Proxy | Reverse Proxy |
|--|--|--|
| 대리 대상 | **클라이언트** | **서버** |
| 위치 | 클라이언트 ↔ 인터넷 사이 | 인터넷 ↔ WAS 사이 |
| 개발자 설정 여부 | ❌ (클라이언트가 설정) | ✅ (서버 개발자가 설정) |
| 서버가 아는 IP | Proxy IP (클라이언트 IP 모름) | 클라이언트 IP (WAS 주소 모름) |

## 관련 개념

- [[reverse-proxy]] — 반대 방향의 Proxy
- [[cdn]] — Forward Proxy처럼 캐시하지만 서버 측에 위치

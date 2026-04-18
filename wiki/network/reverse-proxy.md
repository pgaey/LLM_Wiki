---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[forward-proxy]]", "[[cdn]]", "[[nginx-architecture]]", "[[was]]"]
updated: 2026-04-18
status: draft
tags: [network, proxy, nginx]
---

# Reverse Proxy

## 한 줄 정의

**서버 대리인**. 클라이언트는 존재를 모르고, 서버 앞에서 요청을 대신 받는 서버.

## 위치

```
[브라우저] → [인터넷] → [Reverse Proxy (Nginx)] → [WAS]
                                ↑
                        클라이언트는 여기까지만 앎
                        WAS 주소는 모름
```

## Forward Proxy와 차이

| | Forward Proxy | Reverse Proxy |
|--|--|--|
| 대리 대상 | **클라이언트** | **서버** |
| 위치 | 클라이언트 측 | 서버 측 |
| 클라이언트 인지 | 설정함 | 모름 |
| 개발자 설정 | ❌ | ✅ |
| 사용 예 | VPN, 사내 방화벽 | Nginx, CDN, LB |

## Nginx가 WAS 앞에 있는 이유 (= Reverse Proxy 하는 이유)

```
1. 정적 파일 직접 서빙  → WAS 부하 감소
2. SSL 종료            → HTTPS 처리를 Nginx만. WAS는 HTTP로 통신.
3. 로드밸런싱           → WAS 여러 대에 요청 분산
4. 보안                → WAS를 인터넷에 직접 노출 안 함
5. 캐싱                → 동일 요청 재처리 불필요
6. 가볍다              → C 기반 이벤트루프, WAS보다 훨씬 빠름
```

## Nginx conf 예시

```nginx
server {
    listen 443 ssl;

    # 정적 파일: Nginx가 직접 (WAS 안 거침)
    location /static/ {
        root /app/build;
    }

    # 동적 요청: WAS로 전달 (Reverse Proxy)
    location /api/ {
        proxy_pass http://was-server:8080;
    }
}
```

## 내 K8s 환경

```
브라우저 → Nginx (Reverse Proxy)
            ├─ /static/* → React 빌드 파일 (직접)
            └─ /api/*    → Spring Boot WAS (전달)
```

## 관련 개념

- [[forward-proxy]] — 방향이 반대인 Proxy
- [[cdn]] — 전 세계에 분산된 Reverse Proxy + 캐시
- [[nginx-architecture]] — Reverse Proxy를 수행하는 Nginx 내부 구조

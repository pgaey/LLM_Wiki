---
type: index
updated: 2026-04-13
---

# Wiki Index

> 전체 위키 페이지 카탈로그. AI는 질문 시 **이 파일을 먼저 읽고** 관련 페이지로 드릴다운한다.
> 새 페이지 생성·주요 갱신 시 **반드시 이 index를 갱신**한다.

## 상태 아이콘

- 🟢 `stable` — 30초 설명 통과, 안정
- 🟡 `draft` — 채워졌지만 다듬는 중
- 🔵 `stub` — 빈 스켈레톤 (다음 `/ingest synthesize` 때 채울 것)
- 🗄 `archived` — 더 유효하지 않음, 참고용

---

## 📌 현황 (2026-04-13)

- 총 concepts: 8개 (모두 🔵 stub)
- 총 summaries: 1개 (🔵 stub)
- 대기 중 학습: Basic/Bearer 인증 읽기 → synthesize 재호출

---

## 🧱 foundations

### 🔐 security (인증/인가·보안)
> `wiki/security/`

- 🔵 [[http-authentication]] — HTTP 인증 프레임워크 (허브) (2026-04-13)
- 🔵 [[authorization-header]] — `Authorization: <type> <credentials>` 문법 (2026-04-13)
- 🔵 [[basic-auth]] — Basic 인증 방식 (RFC 7617) (2026-04-13)
- 🔵 [[bearer-auth]] — Bearer 인증 방식 (RFC 6750) (2026-04-13)
- 🔵 [[oauth-2]] — OAuth 2.0 프레임워크 (2026-04-13)
- 🔵 [[bearer-token]] — Access Token의 형태·특성 (2026-04-13)
- 🔵 [[jwt]] — JSON Web Token (2026-04-13)

### 🌐 network (HTTP·TCP·DNS·프록시·서버 역사)
> `wiki/network/`

- 🟡 [[web-server-history]] — 정적→CGI→FastCGI→WAS→Nginx 역사 흐름 (2026-04-18)
- 🟡 [[cgi]] — 동적 처리 최초 규약. 요청마다 프로세스 생성·종료. (2026-04-18)
- 🟡 [[fastcgi]] — 프로세스 풀 재사용으로 CGI 오버헤드 해결 (2026-04-18)
- 🟡 [[was]] — FastCGI가 독립 앱 서버로 진화. Express·Tomcat. (2026-04-18)
- 🟡 [[reverse-proxy]] — 서버 대리인. Nginx가 WAS 앞에 서는 이유. (2026-04-18)
- 🟡 [[forward-proxy]] — 클라이언트 대리인. VPN·방화벽. (2026-04-18)
- 🟡 [[nginx-architecture]] — 이벤트루프+epoll. C10K 해결. (2026-04-18)

### 🖥 browser (DOM·렌더링·Web API)
> `wiki/browser/`

_(비어 있음)_

### 🧮 cs (알고리즘·DS·인코딩·OS)
> `wiki/cs/`

- 🔵 [[base64]] — Base64 인코딩 (암호화 아님) (2026-04-13)

---

## ⚙️ platforms

### 📜 javascript
> `wiki/javascript/`

- 🟡 [[event-loop]] — I/O는 OS 위임·CPU는 직접 실행. Call Stack·Queue·libuv. (2026-04-18)

### 🏷 typescript
> `wiki/typescript/`

_(비어 있음)_

### ⚡ runtime (Node · Bun · Edge)
> `wiki/runtime/`

_(비어 있음)_

---

## 🎨 frameworks

### ⚛️ react
> `wiki/react/`

_(비어 있음)_

### ▲ nextjs
> `wiki/nextjs/`

_(비어 있음)_

---

## 🤖 ai-native ⭐

> `wiki/ai-native/`

- `llm-foundations/` — 토큰·컨텍스트·프롬프트 캐싱 _(비어 있음)_
- `ai-sdk/` — AI SDK, streaming UI _(비어 있음)_
- `agents/` — 에이전트·MCP·워크플로우 _(비어 있음)_
- `rag/` — 임베딩·재랭킹 _(비어 있음)_

---

## 🚀 delivery

> `wiki/delivery/`

- `deploy/` — Vercel·Docker·K8s _(비어 있음)_
- `observability/` — 로깅·Web Vitals _(비어 있음)_
- `performance/` — 번들·캐싱·이미지 _(비어 있음)_

---

## 🧭 workflow ⭐

> `wiki/workflow/`

- `ai-augmented/` — Claude Code 패턴 _(비어 있음)_
- `prompts/` — 프롬프트 자산 _(비어 있음)_
- `process/` — SDD·브랜치 전략 _(비어 있음)_

---

## 📐 architecture (FE 구조·시스템·패턴)
> `wiki/architecture/`

_(비어 있음)_

## 🛠 tooling (Vite·Webpack·TS·ESLint)
> `wiki/tooling/`

_(비어 있음)_

---

## 📄 summaries (원본 요약)

> `wiki/summaries/` — 소스별 1 페이지

- 🔵 [[2026-04-13-toss-basic-bearer-auth]] — 토스페이먼츠: Basic/Bearer 인증 (learn+stub) (2026-04-13)

---

## 🏛 meta

> `wiki/meta/`

- [[WIKI_RULES]] — 위키 운영 규칙 (확정 4개, 2026-04-13)

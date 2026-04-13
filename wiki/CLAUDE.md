# wiki/ — AI 컴파일 지식 레이어

> 이 폴더는 **AI의 영역**이다. AI가 `raw/` 원본을 읽어 구조화·교차참조·유지보수한다. 사용자는 주로 브라우징·질문·방향 지시.

## 역할

`raw/`에 쌓인 원본을 **재사용 가능한 지식 단위**로 컴파일. 같은 개념을 다시 공부하지 않도록, 내가 말로 설명 가능한 수준으로 끌어올리는 게 목표.

## 구조 (v2 · 2026-04-13)

**도메인 기반 폴더 + 프론트매터 `kind` 필드**. 상세는 [[WIKI_RULES]] 참조.

| 영역 | 폴더 | 용도 |
|------|------|------|
| 메타 | `index.md` | 전체 페이지 카탈로그. 매 ingest 시 갱신. |
| 메타 | `log.md` | 시간순 활동 로그 (append-only). |
| 메타 | `meta/` | WIKI_RULES, 용어집, 약어 |
| foundations | `network/` | HTTP/HTTPS/HTTP2, TCP, DNS, WebSocket |
| foundations | `security/` | 인증·인가·암호화·OWASP·CSP |
| foundations | `browser/` | DOM, 렌더링, 이벤트루프, Storage |
| foundations | `cs/` | 알고리즘·자료구조·인코딩·OS |
| platforms | `javascript/` | JS 엔진, async, 메모리 |
| platforms | `typescript/` | 타입 시스템 |
| platforms | `runtime/` | Node · Bun · Deno · Edge |
| frameworks | `react/` | Hooks, RSC, 상태관리 |
| frameworks | `nextjs/` | App Router, Cache Components |
| ai-native ⭐ | `ai-native/{llm-foundations,ai-sdk,agents,rag}/` | LLM 통합·에이전트·MCP·RAG |
| delivery | `delivery/{deploy,observability,performance}/` | 배포·관찰성·성능 |
| workflow ⭐ | `workflow/{ai-augmented,prompts,process}/` | AI 협업·프롬프트·개발 프로세스 |
| 공통 | `architecture/` | FE 디렉토리·시스템·패턴 |
| 공통 | `tooling/` | Vite, Webpack, Turbopack, ESLint |
| 공통 | `summaries/` | `raw/` 소스별 요약 (1:1) |

## 페이지 작성 규칙

### 프론트매터 (모든 위키 페이지 필수)

```yaml
---
type: concept | lib | architecture | runtime | summary
sources: ["[[2026-04-12-example-summary]]"]
updated: 2026-04-12
status: draft | stable
tags: [react, async]
---
```

### 본문 원칙

- **내 언어로 설명 가능한 수준**까지 다듬는다. 영문 용어 직역·복붙 금지.
- **메커니즘과 흐름 중심**. "이 API는 X를 한다"가 아니라 "왜·어떻게 동작하는가".
- 낯선 용어는 **짧은 정의**를 첫 등장 시 곁들인다.
- **위키링크** `[[개념명]]`으로 다른 페이지와 최대한 연결. 고아 페이지 방지.
- 섹션 제목은 **질문 형태**도 좋다 — "왜 X인가?", "언제 쓰는가?" — 설명 가능성 기준에 맞음.

### 충돌 처리

새 소스가 기존 페이지와 모순되면 **양쪽 다 남기고** 해당 위치에 다음을 표기:

```markdown
> ⚠️ 충돌: `[[summary-A]]`는 X라고 하지만 `[[summary-B]]`는 Y라고 한다. 확인 필요.
```

삭제·덮어쓰기 금지. 사용자 판단 대기.

## AI 오퍼레이션 구현 가이드

### Ingest 절차

1. 사용자가 `raw/.../파일.md`를 지목하며 ingest 요청.
2. 원본을 읽고 **3~5줄 핵심 포인트를 사용자에게 먼저 제시**해 방향 확인.
3. `wiki/summaries/YYYY-MM-DD-slug.md` 생성 (프론트매터 필수, `sources:`는 raw 파일 경로).
4. 관련된 `concepts/` `libs/` 등을 업데이트(없으면 신규). 교차참조 추가.
5. `wiki/index.md` 갱신.
6. `wiki/log.md`에 `## [YYYY-MM-DD] ingest | 제목` 한 줄 추가.

### Query 절차

1. `wiki/index.md`에서 관련 페이지 특정.
2. 페이지를 읽고 답변. 모든 주장은 출처 위키링크로.
3. 답이 유의미하다면 사용자에게 `Output/` 저장 여부 묻기.

### Lint 절차

- 직접 수정 금지. **제안 리포트**부터 작성:
  - 모순 페이지 목록
  - 고아 페이지(링크 0개)
  - 언급만 되고 실체 페이지 없는 개념
  - 오래된 `updated` 필드
  - 누락된 교차참조
- 승인 후 반영.

## 사용자 규칙

- 사용자는 원칙적으로 `wiki/`를 직접 편집하지 않는다. 수정이 필요하면 AI에게 말한다.
- 예외: 오타·불편한 링크 등 즉시 고치고 싶은 사소한 건 직접 수정 가능.

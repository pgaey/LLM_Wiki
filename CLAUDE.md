# CLAUDE.md

> 이 Vault(옵시디언 세컨드 브레인)에서 AI가 항상 먼저 읽어야 할 맥락.
> 상세 원본: `나의 맥락 요약.md`

## 1. 사용자

- **3년차 FE 개발자** (2023.08~, 예체능 전공 출신). 현 React로 SaaS 개발. BE 지식은 휘발됨.
- 업무 흐름: **Figma → Claude Figma MCP → 퍼블리싱 → React 구현**.
- 인프라: AWS / Docker / K8s / Bitbucket Pipelines(태그 기반 버전관리).
- 성향: "메커니즘과 흐름을 정확한 논리로 이해하는 순간"을 가장 큰 기쁨으로 느낌. **말로 설명 가능해야 진짜 아는 것**.
- 포지션보다 **문제해결 능력**을 지향. AI 시대엔 풀스택이 기본이라 봄.

## 2. 왜 기록하는가

- 까먹고 다시 공부하는 비용 제거 / 용어 습득으로 소통 효율화 / 설명 가능한 이해 축적.
- 과거 블로그 실패 원인: **접근 비용 + 표현 비용 + 구조화 실패**. 이번엔 이 3가지를 뒤집어야 함.
- AI에 기대하는 역할: (1) 검색·요약, (2) 상황별 기술 추천, (3) 내 수준 기반 다음 단계 코칭.

## 3. 원하는 아웃풋

- **1차 사용자는 오직 본인**. 서비스화·외부 공개 고려 안 함.
- **지식 자체 > 활용**. Garbage 아닌 **Gold**만 쌓는 게 우선.
- 가장 원하는 AI 결과물: **내 수준 기반 학습 로드맵**.
- 1년 후(2027.04) 목표: 아래 지식을 **말로 설명할 수 있는 수준**으로 흡수.
  - 개념: block/non-block, sync/async, HTTP/HTTPS/HTTP2, 브라우저·React 렌더링, function envy
  - 아키텍처: FE 디렉토리 구조, 시스템 아키텍처
  - 런타임: JS·Node 동작 원리
  - 라이브러리: React Hook Form + Zod, Zustand vs Jotai 등

## 4. 시스템 형태

- **옵시디언 Vault + Git 버전관리**. **회사 PC ↔ Mac mini** 동기화.
- 현 경로: `/Users/leeyeachan/Desktop/옵시디언/Wiki` (Mac mini 기준).
- 흐름: 옵시디언에서 작성 → commit/push → 다른 기기에서 pull.
- AI(Claude Code)가 이 Vault를 직접 읽고 쓰는 세컨드 브레인 역할.

---

## 🔑 3대 원칙 (매 작업 시 준수)

1. **Gold over Garbage** — 양보다 질. 쌓는 것이 gold가 아니면 쌓지 않는다.
2. **설명 가능성이 곧 이해** — 노트의 목표는 "말로 설명 가능한 상태".
3. **접근·표현·구조화 비용 최소화** — 진입 장벽, 표현 에너지, 구조 혼란을 줄이는 방향으로.

## 🤖 AI가 이 Vault에서 일할 때 지켜야 할 것

- **메커니즘·흐름 중심**으로 설명. API·결과 나열만 하지 말 것.
- **용어는 정확히**, 낯선 용어엔 짧은 정의를 곁들일 것 (용어 습득이 핵심 목표).
- 정리·요약은 **내 언어로 재표현 가능한 형태**로. 정제된 긴 글보다 **구조화된 짧은 정리**가 지속 가능성↑.
- 사용자는 글 정제·DIR 구분이 약하다고 스스로 평가함 → **분류·구조화는 AI가 적극적으로 제안**할 것.
- 새 노트 생성 시 "이 내용이 *설명 가능한 이해*에 기여하는가"를 기준으로 판단.
- 모든 변경은 Git 친화적(텍스트·마크다운)으로, 두 기기 간 충돌이 적게 설계.

---

## 5. LLM Wiki 운영 규칙 (Karpathy 패턴 적용)

이 Vault는 **3-레이어 구조**로 운영된다. 사용자는 소싱·질문·판단을, AI는 읽기·정리·교차참조·유지보수를 담당한다.

### 📁 3-레이어 구조

```
raw/        # 불변 원본. AI는 읽기만, 절대 수정 금지.
  ├── articles/       웹 아티클·블로그·공식 문서 클리핑
  ├── videos/         영상 노트(유튜브 강의 등)
  ├── books/          책 챕터 노트
  ├── work-notes/     업무 중 마주친 이슈·디버깅 1차 기록
  ├── conversations/  AI 대화에서 건진 raw 지식
  └── assets/         이미지 등 첨부

wiki/       # AI가 컴파일·유지하는 지식 풀. 사용자는 브라우징. (v2 구조 · 도메인 기반)
  ├── index.md, log.md, meta/WIKI_RULES.md   ← 메타
  │
  ├── network/, security/, browser/, cs/     ← foundations
  ├── javascript/, typescript/, runtime/     ← platforms (runtime = Node/Bun/Edge)
  ├── react/, nextjs/                        ← frameworks
  │
  ├── ai-native/{llm-foundations, ai-sdk, agents, rag}/      ⭐ 2026 신규
  ├── delivery/{deploy, observability, performance}/         ⭐ 2026 확장
  ├── workflow/{ai-augmented, prompts, process}/             ⭐ 2026 신규
  │
  ├── architecture/                          FE 구조·시스템·패턴
  ├── tooling/                               Vite, Webpack, TS, ESLint
  └── summaries/                             raw 소스별 1 요약

Output/     # 최종 산출물. 로드맵·비교·설명자료·슬라이드 등.
```

### 🔁 3대 오퍼레이션

**Ingest (원본 투입)**
1. 사용자가 `raw/`에 소스를 떨굼 → 어떤 타입인지 말해줌.
2. AI는 원본을 읽고 **핵심 포인트를 사용자와 먼저 대화**로 확인.
3. `wiki/summaries/`에 요약 페이지 작성.
4. 관련된 `concepts/` `libs/` 등 기존 페이지를 **업데이트**(신규 생성 포함).
5. `wiki/index.md` 갱신 + `wiki/log.md`에 한 줄 추가.
6. 새 데이터가 기존 내용과 **충돌하면 양쪽 다 남기고 flag**(삭제 금지).

**Query (질문)**
- 먼저 `wiki/index.md`를 훑어 관련 페이지를 특정 → 드릴다운.
- 답변은 항상 **출처 페이지 인용**(위키링크 `[[페이지명]]`).
- 탐색·분석 결과가 유의미하면 **`Output/` 혹은 `wiki/`에 역으로 파일링**해 휘발 방지.

**Lint (건강 검진)**
- 정기적으로 요청 시: 모순·중복·고아 페이지·누락된 교차참조·개념만 언급되고 페이지 없는 것 찾아 리포트.
- 직접 수정하지 말고 **수정 제안 목록부터** 제시 → 승인 후 반영.

### ✍️ 위키 페이지 작성 규칙

- **위키링크** `[[페이지명]]` 우선. Obsidian 그래프 뷰가 살아 있어야 함.
- 모든 위키 페이지 상단에 YAML 프론트매터:
  ```yaml
  ---
  type: concept | lib | architecture | runtime | summary
  sources: [[summary-page-1]], [[summary-page-2]]
  updated: 2026-04-12
  status: draft | stable
  ---
  ```
- 페이지는 **"내가 말로 설명 가능한 수준"** 기준으로 작성. 단순 번역·복붙 금지.
- `wiki/log.md` 엔트리 형식: `## [YYYY-MM-DD] ingest|query|lint | 제목` (grep 파싱 가능하게).

### 🚫 경계선 (절대 규칙)

- `raw/` 파일은 **AI가 절대 수정·삭제하지 않는다**. 원본은 영원.
- `wiki/`는 AI의 영역. 사용자는 주로 읽고 질문·방향 지시.
- `Output/`은 **완성된 산출물 전용**. 작업 중 중간 메모는 `wiki/` 또는 채팅.

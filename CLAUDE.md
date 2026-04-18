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

---

## 6. 슬래시 커맨드 (.claude/commands/)

### 커맨드 일람

| 커맨드 | 방향 | 한 줄 목적 |
|--------|------|-----------|
| `/ingest` | 외부 → wiki | 클리핑·대화 소스를 wiki로 소화 |
| `/study <주제>` | 대화 → wiki | 즉석 학습 세션 → 자동 저장 |
| `/query <질문>` | wiki → 답변 | wiki 기반 탐색·답변 (pull) |
| `/review [대상]` | wiki → 테스트 | 30초 설명 테스트 · status 전이 (push) |
| `/lint` | wiki → 리포트 | 고아·모순·stub 만료 등 정비 |

집 컴퓨터(Mac mini) 전용:

| 커맨드 | 목적 |
|--------|------|
| `/graphify wiki/` | wiki 전체를 그래프로 분석 |
| `/graphify --update wiki/` | 변경된 파일만 증분 재분석 |

---

### 각 커맨드 행동 순서

---

#### `/ingest [파일경로]`

> 웹 클리핑·작업 노트 등 `raw/` 소스를 wiki로 소화.
> 상세: `.claude/commands/ingest.md`

```
1. 대상 식별
   - 경로 없으면 raw/ 스캔 → 후보 테이블 제시 → 번호 선택
   - 인자 있으면 그 파일 바로 사용

2. 🚪 Intent Gate (reason 확인)
   - reason 있으면 "이 이유 맞아?" 확인
   - reason 없으면 "왜 들였어?" 질문
   - "모르겠다" → Parking 강등 (wiki 본체 건드리지 않음)

3. 모드 결정
   - learn      → 읽기 가이드 생성 → Output/reading-plans/
   - synthesize → 요약·용어·30초 설명 테스트 → wiki 반영
   - parking    → log.md 한 줄만 기록

4. [synthesize] wiki 반영
   a. wiki/summaries/ 에 요약 페이지 생성
   b. 관련 도메인 폴더 페이지 업데이트 (없으면 신규 제안)
   c. wiki/index.md 갱신
   d. wiki/log.md append

5. raw/ 프론트매터 status 업데이트 제안 (승인 후)
   raw → ingested | parking
```

**ingest 후 자연스러운 다음 행동:**
- 집이면 → `/graphify --update wiki/` (변경 반영)
- 학습 확인하려면 → `/review <주제>`

---

#### `/study <주제> [--source URL] [--quick] [--deep]`

> 대화 기반 학습 세션. 끝나면 raw/conversations/ 저장 → /ingest 체인.
> 상세: `.claude/commands/study.md`

```
1. 🚪 Reason 질문 (Gold gate)
   - "왜 공부해? 한 줄로" → 모르겠다면 세션 거부

2. 선행 지식 스캐닝
   - 이미 아는 것 / 약한 것 확인
   - wiki/ 에 관련 페이지 있으면 먼저 확인

3. 목표 수준 확인
   a) 용어 정의  b) 메커니즘  c) 30초 설명  d) 실전 적용

4. 티키타카 학습
   - AI가 정답 직불 금지 → 질문으로 유도
   - 단계마다 30초 설명 테스트
   - 막힌 지점 = 다음 학습 타겟으로 기록

5. 종료 신호 ("끝" / "정리하자" / "저장해줘")

6. 자동 저장
   a. raw/conversations/YYYY-MM-DD-슬러그.md 생성
      (Q&A 요약 + 도달 이해 + 낯선 용어)
   b. 즉시 /ingest synthesize 체인 실행
   c. wiki/<domain>/ 스텁·페이지 생성·업데이트
   d. wiki/log.md: [study | 주제]

7. 마무리 보고
   - 업데이트된 wiki 목록
   - 식별된 다음 학습 타겟
```

**study 후 자연스러운 다음 행동:**
- 바로 검증 → `/review <주제>`
- 관련 아티클 있으면 → `/ingest` 로 보강
- 집이면 → `/graphify --update wiki/`

---

#### `/query <질문>`

> wiki 기반으로 답변. 벡터 DB 아님 — index-first 검색 + 위키링크 인용.
> 상세: `.claude/commands/query.md`

```
1. wiki/index.md 먼저 읽고 관련 페이지 후보 특정

2. Grep으로 핵심 용어 검색 → 최대 5개 페이지 Read

3. 답변 합성
   - 모든 주장에 [[위키링크]] 인용 (근거 없는 문장 금지)
   - wiki에 없으면 솔직하게 "갭" 고지 → 소스 후보 제안

4. 답변이 gold 가치면 저장 제안
   - Output/comparisons/ : 비교·대조
   - Output/explanations/: 설명자료
   - Output/roadmaps/    : 학습 로드맵
   - wiki/<domain>/      : 새 개념 페이지로 승격

5. wiki/log.md 기록 (의미 있는 쿼리 or 파일링된 경우만)
```

**query 후 자연스러운 다음 행동:**
- 갭 발견 → `/study <빈 개념>` or `/ingest` 로 소스 투입
- 답변이 좋으면 → Output/ 저장 제안 수락

---

#### `/review [대상] [--stubs] [--drafts] [--stable] [--count N]`

> wiki 페이지 기반으로 AI가 출제 → 사용자가 답 → 채점 → status 전이 제안.
> 상세: `.claude/commands/review.md`

```
1. 대상 선택
   - 인자 없으면 우선순위 자동 선정:
     stub 14일+ > draft 30일+ > stable 60일+ > 최신 추가
   - 후보 테이블 제시 → 번호 or all 선택

2. 출제 (status에 따라 강도 조절)
   - stub:   개념 정의 + 왜 중요한지 30초로
   - draft:  메커니즘 + 함정 + 1년 목표 연결
   - stable: 대비·응용·edge case

3. 사용자 답변
   - "패스" → 정답 보여주고 status 유지
   - "힌트" → 한 단계 힌트 (2회 한도)
   - "설명해줘" → /study <주제> 제안

4. 채점
   - ✅ Pass:    30초 이내, 핵심 맞음
   - 🟡 Partial: 핵심은 있으나 빈 자리
   - ❌ Miss:    핵심 놓침

5. status 전이 제안 (자동 적용 금지, 승인 후)
   stub  + Pass    → draft 승급?
   draft + Pass×2  → stable 승급?
   stable + Miss   → draft 강등?

6. 이력 기록
   - wiki/meta/review-history.md (append)
   - wiki/log.md 짧은 엔트리

7. 다음 review 간격 제안
   Pass → 간격 × 2 / Partial → 유지 / Miss → 1일 후
```

**review 후 자연스러운 다음 행동:**
- Miss 난 주제 → `/study <주제>` 로 재학습
- stub → draft 승급되면 → `/graphify --update wiki/` 로 그래프 갱신

---

#### `/lint`

> 위키 전체 건강 검진. 9개 축 스캔 → 리포트 → 승인 후 반영.
> 상세: `.claude/commands/lint.md`

```
스캔 항목:
  A. Orphan Pages      - inbound 링크 0인 페이지
  B. 충돌 플래그       - ⚠️ 충돌: 표기된 곳
  C. 누락 교차참조     - 본문에 있는데 [[링크]] 안 된 개념
  D. Ghost Concepts    - 링크는 있는데 실제 파일 없는 것
  E. Staleness         - updated 60일+ + 새 소스 미반영
  F. Parking Rot       - parking 30일+ 경과
  G. Raw 체증          - status:raw 14일+ 방치
  H. reason 누락       - raw/ 중 reason 비어있는 것
  I. 1년 목표 커버리지 - 목표 리스트 대비 wiki 페이지 현황

결과: Output/reports/YYYY-MM-DD-lint.md 저장
수정: 건별 승인 후 반영 (자동 적용 없음)
```

**lint 후 자연스러운 다음 행동:**
- Ghost Concepts → `/study` or `/ingest` 로 채우기
- Parking Rot → `/ingest` 재시도 or 버리기
- 커버리지 갭 → 학습 우선순위 재조정

---

#### `/graphify wiki/` (집 전용)

> wiki 전체를 그래프로 변환. 커뮤니티·허브·갭을 시각화.
> 별도 skill 파일 참조.

```
전체 파이프라인:
  1. wiki/ 파일 탐지
  2. 의미적 추출 (엔티티·관계·위키링크)
  3. 그래프 빌드 + 커뮤니티 감지
  4. 분석 (God Nodes, Surprising Connections)
  5. 출력: graphify-out/graph.html (브라우저로 열기)
           graphify-out/GRAPH_REPORT.md
           graphify-out/graph.json

/graphify --update wiki/ = 변경 파일만 증분 재추출 (빠름, 권장)
```

**graphify 후 가능한 것:**
- `graph.html` 브라우저로 열어 Obsidian 그래프 뷰와 비교
- `GRAPH_REPORT.md` 에서 갭 확인 → `/lint` or `/study` 타겟 도출
- `/graphify query "질문"` 으로 그래프 탐색

---

### 📐 권장 워크플로 순서도

```
[지식 수집]
  Web Clipper → raw/articles/ or raw/videos/
  업무 이슈   → raw/work-notes/
  대화        → /study (자동 저장)

        ↓

[소화 · 컴파일]
  /ingest          외부 소스 → wiki
  /study <주제>    대화 → wiki (자동 ingest 체인)

        ↓

[탐색 · 활용]
  /query <질문>    wiki 기반 답변 (pull)

        ↓

[검증 · 승급]
  /review          30초 설명 테스트 → status 전이

        ↓

[정비 · 분석]  (집에서, 주기적)
  /lint                     wiki 건강 검진
  /graphify --update wiki/   그래프 갱신
  ./sync.sh                  GitHub 동기화

        ↓

[반복]
  새 갭 발견 → /study or /ingest → ...
```

### ⚡ 상황별 추천

| 상황 | 추천 커맨드 |
|------|------------|
| 블로그 클리핑 후 | `/ingest` |
| 개념 모를 때 | `/study <개념>` |
| wiki에서 뭔가 찾을 때 | `/query <질문>` |
| 배운 거 검증할 때 | `/review <주제>` |
| stub이 쌓였을 때 | `/review --stubs` |
| 정기 정비 (격주) | `/lint` |
| 지식이 쌓인 뒤 (집) | `/graphify --update wiki/` |
| 기기 동기화 | `./sync.sh` |

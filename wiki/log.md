---
type: log
---

# Wiki Activity Log

> 시간순 append-only 활동 로그. 엔트리 포맷: `## [YYYY-MM-DD] type | 제목`
> 유닉스 도구로 파싱 가능하게 일관된 프리픽스 유지 — `grep "^## \[" log.md | tail -10`.
> `type` 값: `ingest` | `query` | `lint` | `output` | `meta`.

---

## [2026-04-12] meta | Vault 초기 셋업

- 3-레이어 구조(`raw/` / `wiki/` / `Output/`) 생성.
- `CLAUDE.md`에 LLM Wiki 패턴(Karpathy) 운영 규칙 추가.
- 각 주요 폴더에 하위 `CLAUDE.md` 생성 (raw/ wiki/ Output/).
- `wiki/index.md`, `wiki/log.md` 초기화.
- 다음: 첫 소스를 `raw/`에 투입하고 ingest 흐름 테스트.

## [2026-04-13] meta | 클리퍼 템플릿 + 슬래시 커맨드 3종

- `_clipper/` 에 Obsidian Web Clipper 템플릿 5종 + README 추가.
- 클리퍼 프론트매터에 `reason`, `ingest_mode` 필드 도입 (Gold 게이트).
- `.claude/commands/` 에 `/ingest`, `/query`, `/lint` 슬래시 커맨드 생성.
- `/ingest` 인자 없을 때 raw/ 후보 자동 탐지 로직 추가.

## [2026-04-13] ingest | Basic/Bearer 인증 (learn+stub)

- **모드**: learn + stub (graph-first 학습 전략)
- **소스**: `raw/articles/2026-04-13-Basic 인증과 Bearer 인증의 모든 것 토스페이먼츠.md`
- **reason**: HTTP 통신·인증/인가(OAuth 포함)는 중요하면서 복잡한 개념이라 정리 필요
- **생성된 스텁** (8개, 모두 🔵 stub):
  - [[http-authentication]] · [[authorization-header]] · [[basic-auth]] · [[bearer-auth]]
  - [[oauth-2]] · [[bearer-token]] · [[jwt]] · [[base64]]
- **summary**: [[2026-04-13-toss-basic-bearer-auth]]
- **reading plan**: `Output/reading-plans/2026-04-13-basic-bearer-auth.md`
- **후속**: 읽고 `/ingest` 재호출 → synthesize 모드에서 stub → draft 승격.
- **추가 ingest 후보**: JWT 전용 소스, OAuth 2.0 플로우 유형 (Authorization Code / Implicit / Client Credentials 등).

## [2026-04-13] meta | 폴더 v2 재편 + WIKI_RULES.md 생성

- **폴더 구조 v2 적용** (2020→2026 업그레이드):
  - 추가: `security/`, `network/`, `browser/`, `cs/`, `javascript/`, `typescript/`, `react/`, `nextjs/`, `tooling/`, `meta/`
  - 추가: `ai-native/{llm-foundations,ai-sdk,agents,rag}`
  - 추가: `delivery/{deploy,observability,performance}`
  - 추가: `workflow/{ai-augmented,prompts,process}`
  - 제거: `concepts/`, `libs/` (도메인 기반으로 대체)
  - 유지: `architecture/`, `runtime/` (의미 재정의 — runtime은 Node/Bun/Edge)
- **스텁 8개 이동**:
  - `concepts/{http-authentication, authorization-header, basic-auth, bearer-auth, oauth-2, bearer-token, jwt}` → `security/`
  - `concepts/base64` → `cs/`
- **`wiki/meta/WIKI_RULES.md` 생성** — 4개 규칙 확정:
  1. 위키링크는 `[[파일명]]` 만 (경로·표시명 미사용)
  2. Status 자동 전이 금지 — 사용자 승인 필수
  3. Stub 시한 (14일 경고 / 30일 아카이브 제안, 삭제 아님)
  4. 파일명 규약 (raw/summary=날짜prefix, wiki본체=영문 kebab-case)
- **후속**: CLAUDE.md(root, wiki), 슬래시 커맨드 3개 폴더 참조 업데이트.

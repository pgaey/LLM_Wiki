---
type: rules
updated: 2026-04-13
status: draft
---

# 📜 WIKI RULES

> 이 위키의 운영 규칙 모음. **실전 이슈마다 한 줄씩 누적**한다.
> Gold over Garbage 원칙의 메타 적용 — 추상 규칙 미리 다 만들지 않음.

## 🔗 1. 위키링크 표기 (확정 2026-04-13)

- **기본형**: `[[파일명]]` — 파일명만 사용.
- **경로 포함 금지**: `[[security/basic-auth]]` ❌ → `[[basic-auth]]` ✅
- **표시명 syntax 미사용**: `[[basic-auth|Basic 인증]]` ❌ (필요해지면 그때 검토)
- **전제**: **파일명은 전역 고유**해야 함 (같은 이름 두 개 금지).
- **이유**: 파일 이동 시 안 깨짐. Obsidian 전역 해상.

## 🚦 2. Status 정의 (자동 전이 없음) (확정 2026-04-13)

**정의만 둠. AI는 날짜로 자동 전이시키지 않는다. 항상 사용자 명시적 승인.**

| 상태 | 정의 |
|------|------|
| `stub` | 뼈대만 있음. `/ingest learn+stub` 직후. |
| `draft` | 내 언어로 최소 한 번 채워짐. `/ingest synthesize` 통과 후. |
| `stable` | 30초 말로 설명 테스트 통과. 모순·갱신 없는 안정 상태. |
| `archived` | 더 유효하지 않음. 참고용으로만 남김. |

- `/ingest` 재호출 시 사용자가 직접 승격.
- `/lint` 는 "이 페이지 stable 로 올릴래?" 제안만 — 자동 변경 금지.

## 🗂 3. Stub 시한 — 아카이브 ≠ 삭제 (확정 2026-04-13)

- **14일** 경과 → `/lint` 가 경고.
- **30일** 경과 → **아카이브 제안** (⚠️ **삭제 아님**):
  - 옵션 A: 프론트매터 `status: archived` 로 필드 변경, 그대로 남김.
  - 옵션 B: `wiki/_archive/<원래도메인>/` 로 파일 이동.
- 사용자 승인 후에만 실행.

## 📁 4. 파일명 규약 (확정 2026-04-13)

| 폴더 | 패턴 | 예시 |
|------|------|------|
| `raw/*/` | `YYYY-MM-DD-원제목.md` | `2026-04-13-Basic 인증과 Bearer 인증의 모든 것.md` |
| `wiki/<domain>/` | `영문-kebab-case.md` | `basic-auth.md`, `event-loop.md` |
| `wiki/summaries/` | `YYYY-MM-DD-영문-슬러그.md` | `2026-04-13-toss-basic-bearer-auth.md` |
| `Output/<카테고리>/` | `YYYY-MM-DD-슬러그.md` | `2026-04-13-basic-bearer-auth.md` |

**원칙**:
1. **위키 본체 = 영문 kebab-case** — 링크 자산·grep 편의·오탈자 방지.
2. **시간축 있는 것 = 날짜 prefix** (raw, summary, reading-plan, report) — 정렬 자연스러움.
3. **한국어 제목은 본문 `H1` 담당** — 파일명은 영문이어도 표시에 문제 없음.

## 📂 5. 폴더 구조 (v2 · 확정 2026-04-13)

```
wiki/
├── foundations
│   ├── network/           HTTP/HTTPS/HTTP2, TCP, DNS, WebSocket
│   ├── security/          인증·인가·암호화·OWASP·CSP
│   ├── browser/           DOM, 렌더링 파이프라인, 이벤트루프, Storage
│   └── cs/                알고리즘·자료구조·인코딩·OS 기초
├── platforms
│   ├── javascript/        JS 엔진, async, 메모리, function envy
│   ├── typescript/        타입 시스템
│   └── runtime/           Node · Bun · Deno · Edge Runtime
├── frameworks
│   ├── react/             Hooks, RSC, Suspense, 상태관리
│   └── nextjs/            App Router, Cache Components, Server Actions
├── ai-native/             ⭐ 2026 신규
│   ├── llm-foundations/   토큰, 컨텍스트, 프롬프트 캐싱
│   ├── ai-sdk/            AI SDK, streaming UI, tool use
│   ├── agents/            에이전트, MCP, 워크플로우
│   └── rag/               임베딩, 재랭킹
├── delivery/              ⭐ 2026 확장
│   ├── deploy/            Vercel, Docker, K8s
│   ├── observability/     로깅·트레이싱·OTel·Web Vitals
│   └── performance/       번들, 캐싱, 이미지·폰트 최적화
├── workflow/              ⭐ 2026 신규
│   ├── ai-augmented/      Claude Code 패턴, 리뷰, 테스트
│   ├── prompts/           잘 쓴 프롬프트 자산
│   └── process/           SDD, 기능 플래닝, 브랜치 전략
├── architecture/          FE 디렉토리·시스템·패턴
├── tooling/               Vite, Webpack, Turbopack, ESLint
├── summaries/             소스별 1요약
└── meta/                  용어집, 약어, WIKI_RULES.md
```

## 나머지 (표준 — 필요할 때 확장)

- **태그**: 프론트매터 `tags:` 배열에 평면 문자열. 통제 어휘는 30+ 쌓이면 재정비.
- **프론트매터**: 각 type별 필수 필드는 스텁/summary 예시 참고.
- **Multi-source 병합**: 기존 섹션 덮어쓰기 금지 → 새 섹션 append. 모순 시 `⚠️ 충돌:` 플래그.
- **Obsidian**: attachment folder = `raw/assets/`. 플러그인은 core 시작, Dataview 등은 필요 시 검토.

---

**규칙 추가 방침**: 실전 이슈가 결정을 요구할 때 한 줄씩 추가. 추상 규칙 먼저 만들지 않음.

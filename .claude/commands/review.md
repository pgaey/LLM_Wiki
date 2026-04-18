---
description: "wiki 페이지를 대상으로 AI가 출제 → 사용자가 30초 설명 → 채점 → status 전이(stub/draft/stable) 제안. 복습·승급·약점 추적."
---

# /review

대상: `$ARGUMENTS` (없으면 AI 가 자동 선택)

## 🛡 0. 대전제

1. `/review` 는 **push 모드** — AI가 묻고, 사용자가 답한다.
2. **status 전이 자동 엔진** — 통과하면 `stub → draft → stable` 승급 *제안*.
3. **자동 적용 금지** — 모든 status 변경은 사용자 명시 승인 후에만 (WIKI_RULES 규칙 2).
4. 채점 기준은 **"30초 말로 설명 가능"** — 사용자가 직접 정한 앎의 기준.
5. 결과는 `wiki/meta/review-history.md` 에 누적 (spaced repetition 기초 데이터).

## 🎯 1. 대상 선택

### 1A. 인자가 주어진 경우
- `/review basic-auth` — 특정 페이지
- `/review --domain security` — 도메인 전체
- `/review --stubs` — status=stub 만
- `/review --drafts` — status=draft 만
- `/review --stable` — stable 재검증 (regression 체크)
- `/review --count 5` — 세션 크기 (기본 3)

### 1B. 인자 없으면 AI가 자동 선정

우선순위:
1. **stub 14일 이상** (WIKI_RULES 규칙 3 경고 라인 직전 구제)
2. **draft 30일 이상** (stable 승급 후보)
3. **stable 60일 이상** (regression 재검증)
4. 위 셋 없으면 최근 추가된 페이지

후보 목록 테이블로 제시 → 사용자 선택 or "all":
```
# | 페이지                    | 상태 | updated | 나이 | 우선도
1 | [[basic-auth]]            | stub | 2026-04-13 | 1일 | 낮음
2 | [[oauth-2]]               | stub | 2026-04-13 | 1일 | 낮음
3 | [[jwt]]                   | stub | 2026-04-13 | 1일 | 낮음
```

## ❓ 2. 출제

선택된 페이지에 대해 AI 는:
1. 해당 wiki 페이지 + 참조하는 summary + (있으면) reading plan 을 읽는다.
2. 페이지의 `status` 에 맞춰 질문 강도 조절:

| 현재 status | 질문 강도 |
|-------------|-----------|
| `stub` | "개념 정의 + 왜 중요한지 30초로" (낮음) |
| `draft` | "메커니즘 흐름 + 함정 + 1년 목표와의 연결" (중간) |
| `stable` | "다른 개념과 대비·응용·edge case" (높음) |

3. 질문 예시:
   - `basic-auth` stub: *"Basic 인증이 뭐고 왜 HTTPS 없인 쓸 수 없어?"*
   - `oauth-2` draft: *"OAuth 4대 역할 + 인증 서버와 리소스 서버를 왜 분리하는지 설명해봐."*
   - `jwt` stable: *"JWT ≠ 인증 방식인 이유 + Payload 에 민감정보 넣으면 안 되는 이유."*

### 🆘 사용자 옵션
- **답한다** (기본)
- **"패스"** → 정답 보여주고 status 그대로
- **"힌트"** → 한 단계 힌트 제공 (2회 한도)
- **"설명해줘"** → 이 주제 바로 학습 세션으로 전환 (`/study <주제>` 제안)

## 🎯 3. 채점

AI가 사용자 답변을 읽고 3단계로 평가:

| 점수 | 기준 |
|------|------|
| ✅ **Pass** | 메커니즘·흐름을 본인 언어로 30초 안에. wiki 본문과 정합. 작은 누락은 허용. |
| 🟡 **Partial** | 핵심은 잡았으나 **중요한 빈 자리** 존재 or 부분적 오해. |
| ❌ **Miss** | 핵심 놓침, 잘못 설명, 답 못 함. |

### 채점 리포트 형식
```
📊 채점: Partial

✅ 맞춘 부분:
  - Basic 인증이 ID:PW를 base64 인코딩해서 보낸다는 것
  - HTTPS 같이 써야 한다는 것

🟡 아쉬운 부분:
  - **왜 HTTPS 필수인지** 구체적 이유가 빠짐: [[base64]] 가 암호화가 아니라 쉽게 복호화된다는 점
  - 서버에 사용자 목록 저장 → 확장성 문제까지 언급하면 완벽

💡 wiki 원본 (요약):
  "Basic 인증은 <사용자ID:비밀번호>를 base64 인코딩한 문자열을 
   Authorization 헤더에 실어 보낸다. base64는 암호화가 아니라
   쉽게 복호화 가능 — 따라서 HTTPS 필수."
```

## 🚦 4. status 전이 제안

점수 + 현 status 기반:

| 현재 | 점수 | 제안 |
|------|------|------|
| `stub` | Pass | **`stub → draft` 승급?** (본문도 이번 답변 기반으로 채울지 제안) |
| `stub` | Partial | 그대로. 채점 리포트 본문에 note 추가 제안. |
| `stub` | Miss | 그대로 + "학습 세션(`/study`) 필요?" 제안. |
| `draft` | Pass (최소 2회 연속 + 7일+ 경과) | **`draft → stable` 승급?** |
| `draft` | Partial | 그대로. 빈 자리 메꾸기 작업 제안. |
| `draft` | Miss | **`draft → stub` 강등?** (이해 후퇴 표시) |
| `stable` | Pass | 그대로 + next review 일정. |
| `stable` | Miss | **`stable → draft` 강등?** (regression). |

**모든 전이는 사용자 승인 후 반영.** 적용 방법:
- 해당 wiki 페이지 프론트매터 `status:` 한 필드 수정
- `updated:` 갱신

## 📝 5. 이력 기록

### 5A. `wiki/meta/review-history.md` (append-only)

없으면 첫 `/review` 때 생성. 구조:

```markdown
---
type: review-log
updated: YYYY-MM-DD
---

# Review History

## 📊 페이지별 통계 (updated by /review)

| Page | 시도 | Pass | Partial | Miss | 마지막 | 현재 status |
|------|------|------|---------|------|--------|-------------|
| [[basic-auth]] | 3 | 2 | 1 | 0 | 2026-04-14 | draft |

## 📜 세션 로그

### [YYYY-MM-DD] review | [[basic-auth]]
- 점수: Partial
- 물은 것: "Basic 인증 30초 설명"
- 사용자 답 요약: ID:PW를 base64로 넣는다고 답함
- 빈 자리: HTTPS 필수 이유(base64는 암호화 아님)
- 전이: stub → 유지 (partial)

### [YYYY-MM-DD] review | [[oauth-2]]
- 점수: Pass
- ...
```

### 5B. `wiki/log.md` 짧은 엔트리
```
## [YYYY-MM-DD] review | N개 페이지 (P개 pass, R개 partial, M개 miss)
- 전이 반영: [[basic-auth]] stub→draft, [[oauth-2]] stub→draft
- 상세: [[review-history]]
```

## 🔁 6. 다음 review 일정 (간이 spaced repetition)

각 페이지의 다음 review 제안 간격:
- **Pass 직후**: 기존 간격 × 2 (초기 3일 → 7일 → 14일 → 30일)
- **Partial 직후**: 기존 간격 유지
- **Miss 직후**: 1일 뒤 재시도

간격은 `review-history.md` 통계 기반 계산. 지금은 **제안만** — 실제 알림 체계는 추후.

## 📣 7. 세션 마무리

한 블록:
- ✅ 이번 세션 점수 요약 (Pass N / Partial N / Miss N)
- 🏅 전이 반영된 페이지 목록
- 🎯 **다음에 또 돌 페이지** (간격 기반 추천)
- 🚨 **연속 Miss 주제** — `/study` 권장
- 🔗 리포트 링크: `[[review-history]]`

## 🚫 금지

- status 자동 변경 금지 — 항상 사용자 "go" 필요.
- wiki 페이지 본문 무단 수정 금지 (승급 시 프론트매터만).
- 연속 출제에서 **같은 페이지 3회 이상 반복** 금지 (피로 방지).
- "정답 먼저 알려주기" 금지 — 사용자 답변 전 wiki 본문 공개 X.

---

## 🧾 관련 커맨드

- `/study <주제>` — review에서 Miss 난 주제 깊이 학습.
- `/ingest` — 새 소스로 페이지 보강.
- `/lint` — stub 14일 경과·고아 페이지 등 구조적 문제 찾기.
- `/query` — pull 모드 (반대 방향).

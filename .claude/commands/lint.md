---
description: "위키 도서관 정리. 고아/모순/고스트/staleness/parking-rot/raw 체증/커버리지 갭을 감지해 리포트. 자동 수정 금지 — 승인 후 반영."
---

# /lint

## 🛡 0. 대전제

1. **먼저 리포트, 나중에 수정.** 자동 삭제·재작성 금지.
2. 모든 변경은 사용자 **건별 승인**.
3. 결과는 `Output/reports/YYYY-MM-DD-lint.md` 로 저장.
4. 종료 시 `wiki/log.md` append: `## [YYYY-MM-DD] lint | N건 중 M건 반영`.

## 🔍 1. 스캔 대상

- `wiki/**/*.md` (단 `index.md`·`log.md` 는 메타 파일이라 본체 검사 제외)
- `raw/**/*.md` 의 **프론트매터**(status / ingest_mode / reason)
- `wiki/log.md` (parking / ingest 엔트리)

## 🧪 2. 검사 항목 (9개 축)

### 🔗 A. Orphan Pages
- inbound 위키링크가 0인 페이지.
- `Grep` 으로 wiki 전역에서 `[[페이지명]]` 검색 → hit 없으면 orphan.
- 제안: "어디에 연결할까? / 아카이브?"

### ⚠️ B. 명시적 충돌 플래그
- 페이지 본문에 `⚠️ 충돌:` 또는 `> ⚠️` 라인.
- 각 충돌: "둘 중 맞는 쪽 / 양쪽 유효 / 추가 소스 필요?"

### 🕸 C. 누락된 교차참조
- 페이지 본문에 **다른 위키 페이지 제목이 일반 텍스트로** 등장하지만 위키링크되지 않은 경우.
- 예: `libs/zustand.md` 에 "jotai" 라는 단어가 있는데 `[[jotai]]` 로 링크 안 됨.
- 제안: 위키링크화 여부.

### 👻 D. Ghost Concepts
- 페이지들이 `[[X]]` 로 참조하지만 **실제 파일이 없는** X.
- Grep `[[...]]` 로 모든 링크 수집 → 파일 존재 매칭.
- 제안: "X 페이지 신규 / 언급 제거?"

### 🕐 E. Staleness
- 프론트매터 `updated:` 기준 **60일 이상** + 그 사이 관련 raw 소스가 새로 들어왔는지 체크.
- 제안: 재검토·최신화.

### 🅿️ F. Parking Rot
- `wiki/log.md` 의 `parking` 엔트리 중 **30일 이상** 경과.
- 해당 `raw/` 파일이 아직 `status: parking` 이면 리뷰.
- 제안: "지금 보니 의미 있어? / 삭제? / 지금 ingest?"

### 📥 G. Raw 체증
- `raw/` 에 `status: raw` 로 **14일 이상** 방치된 파일.
- 제안: "/ingest / parking / 삭제?"

### 🧩 H. reason 누락 (raw)
- `raw/` 중 `reason:` 비어있거나 필드 자체가 없는 파일.
- 제안: 채우거나 parking.

### 📊 I. 1년 목표 커버리지
- 도메인 폴더별 페이지 수:
  - `wiki/{network, security, browser, cs}` (foundations)
  - `wiki/{javascript, typescript, runtime}` (platforms)
  - `wiki/{react, nextjs}` (frameworks)
  - `wiki/{ai-native, delivery, workflow}` ⭐
  - `wiki/{architecture, tooling, summaries}`
- 1년 목표 리스트 대비 체크:
  - **network**: HTTP/HTTPS/HTTP2, 상태 코드
  - **security**: Basic/Bearer, OAuth, JWT, CSP
  - **browser**: 렌더링 파이프라인, 이벤트루프, Storage
  - **javascript**: block/non-block, sync/async, function envy, Promise
  - **react**: 렌더링 메커니즘, Hook, 상태관리(Zustand/Jotai), RHF+Zod
  - **architecture**: FE 디렉토리, 시스템 아키텍처
- 미커버 항목 = 다음 `/ingest` 타겟 추천.

## 📋 3. 리포트 형식

`Output/reports/YYYY-MM-DD-lint.md`:

```markdown
---
type: report
report_type: lint
created: YYYY-MM-DD
---

# Lint Report — YYYY-MM-DD

## 요약
- 총 wiki 페이지: N
- 총 raw 파일: M (raw:x / ingested:y / parking:z)
- 발견된 이슈: Ntot건

## 🔗 A. Orphan Pages (N)
- [ ] [[페이지X]] — 제안: Y에 연결 or 아카이브

## ⚠️ B. Conflicts (N)
- [ ] [[페이지A]] ↔ [[페이지B]] — X vs Y

## 🕸 C. 누락된 교차참조 (N)
- [ ] `libs/zustand.md` 의 "jotai" → `[[jotai]]`

## 👻 D. Ghost Concepts (N)
- [ ] `[[function-envy]]` — 참조되나 파일 없음

## 🕐 E. Stale (N)
- [ ] `concepts/http.md` — 75일 경과, 새 소스 2건 미반영

## 🅿️ F. Parking Rot (N)
- [ ] raw/articles/YYYY-MM-DD-xxx.md — 32일 parking

## 📥 G. Raw 체증 (N)
- [ ] raw/videos/YYYY-MM-DD-yy.md — status: raw 18일

## 🧩 H. reason 누락 (N)
- [ ] raw/articles/zzz.md

## 📊 I. Coverage
| 카테고리 | 현재 | 목표 | 갭 |
|---------|-----|------|-----|
| concepts | 3개 | 6개 | HTTP2, 브라우저 렌더링, function envy |
| libs | 1개 | 4개 | Jotai, RHF, Zod |

### 추천 소스 (미커버 용)
- ...
```

## ✅ 4. 수정 실행 (건별 승인)

리포트 제시 후:

1. 카테고리별 or 개별 항목별로 **"수정할까?"** 확인.
2. 승인된 것만 반영:
   - 위키링크화 (C)
   - Ghost 페이지 신규 생성 (D)
   - Orphan 연결 or 이동 (A)
   - raw status 변경 (F/G) — 프론트매터 한 줄만, 본문 건드림 금지.
3. 반영 완료 항목은 리포트에 `✅` 마킹.
4. **일괄 승인**도 허용 ("C 섹션 전부 적용").

## 🧱 5. 금기

- `raw/` 본문·첨부 **절대 수정·삭제 금지**. 프론트매터 `status:` 한 줄만 가능.
- 충돌(B) 자동 해소 금지 — 둘 중 하나를 AI가 고르지 않는다.
- Orphan을 임의로 삭제하지 않는다. 사용자 판단 우선.

## 📣 6. 마무리

- 리포트 파일 경로 안내.
- 반영된 변경 수 / 미반영 수.
- `wiki/log.md` append:
  ```
  ## [YYYY-MM-DD] lint | N건 중 M건 반영 · 리포트: [[Output/reports/YYYY-MM-DD-lint]]
  ```
- 다음 `/lint` 추천 주기 제안 (초반엔 주 1회, 안정화되면 격주~월 1회).

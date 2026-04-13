---
description: "raw/의 캡처 소스를 위키로 컴파일. reason 게이트 → 3-모드(learn/synthesize/parking) → 타입별 대화 → wiki 반영. raw는 불변."
---

# /ingest

사용자가 `$ARGUMENTS` 로 경로를 지정했다면 그 파일이 대상. 없으면 1단계로 식별한다.

## ⛩ 0. 대전제 (매번, 예외 없이)

1. **목적성 없는 인제스트 금지.** 프론트매터 `reason:` 이 비어 있으면 먼저 채우거나 **Parking**으로 강등한다. wiki 본체를 건드리지 않는다.
2. **raw/는 불변.** 본문·첨부 수정/삭제 금지. 프론트매터의 `status:` 한 줄 만, 사용자 명시 승인 후에만 변경.
3. **3-모드**: `learn` / `synthesize` / `parking` — 각각 파이프가 다르다.
4. 모든 wiki 업데이트는 **범위 확정 후**에만 실행. 먼저 "뭘 할 거야" 를 제시하고 사용자 OK 받는다.

## 🎯 1. 대상 식별

`$ARGUMENTS` 값에 따라 4-갈래로 분기:

### 1A. 파일 경로가 주어진 경우
예: `/ingest raw/articles/xxx.md`
→ 그 파일을 대상으로 2단계(Intent Gate)로 진행.

### 1B. 인자가 비어 있거나 **파일 경로가 아닌 경우** (메타 질문·키워드 아닌 아무 문장)
→ **후보 자동 탐지 모드**로 진입 (1E 참고). `명령어 치면 어떻게 돼?` 같은 문장은 경로가 아니므로 이쪽.

### 1C. 키워드 `latest`
→ `raw/` 전체에서 **수정일 기준 가장 최근** 파일 1개. Bash `ls -t` 또는 `find ... -printf '%T@ %p\n' | sort -n | tail` 사용.

### 1D. 키워드 `pending`
→ `status: raw` 또는 status 필드 없음인 파일 **전부 순차 처리**. 하나 끝날 때마다 "다음 거 할까?" 확인.

### 1E. 후보 탐지 & 선택 테이블

`raw/` 하위 `*.md` 파일을 전부 스캔 (단 `.gitkeep`, `CLAUDE.md` 제외). 각 파일의 YAML 프론트매터를 읽어 다음 표를 **마크다운 테이블**로 제시한다:

```
# | 경로                          | 상태   | reason         | 나이
1 | raw/articles/xxx.md           | 🆕❌   | (비어있음)      | 1일
2 | raw/videos/yyy.md             | 🆕✅   | "웹훅 개념..."  | 3일
3 | raw/articles/zzz.md           | 🅿️     | "..."          | 12일
4 | raw/articles/aaa.md           | ✅     | "..."          | 20일
```

**상태 아이콘 규칙**:
- `🆕` = `status: raw` 또는 status 필드 누락 (인제스트 대기)
- `🅿️` = `status: parking`
- `✅` = `status: ingested` (이미 처리됨, 기본 숨김 — 사용자가 `--all` 요청하면 표시)
- `❌` = `reason:` 비어있음 (게이트에 걸릴 예정)
- `🕐` = `captured` 기준 X일 경과 (없으면 파일 mtime)

**정렬**: 🆕 먼저, 그 안에서 나이 오름차순(최근 순). 🅿️ → ✅ 순.

**표시 상한**: 기본 10개. 넘으면 "더 보기" 제안.

### 1F. 선택 인터페이스

표 아래에 묻는다:
- "번호 골라 (1~N), `all` 이면 🆕 전부 순차 처리, `cancel` 종료."
- 🆕 항목이 **딱 하나**면 번호 입력 생략하고 "1번 바로 진행할까?" 확인.
- 🆕 항목이 **없으면** "인제스트할 거 없음. `/ingest latest` 로 강제 실행 or 새 소스 캡처부터." 안내하고 종료.

## 🚪 2. Intent Gate — `reason:` 확정

대상 파일의 YAML 프론트매터에서 `reason:` 읽는다:

- **비어 있지 않음** → 한 줄 인용 후 "이 이유 맞지? 수정할래?" 확인만.
- **비어 있거나 누락** → 질문: *"이거 왜 들였어? 한 줄로."*
  - 답변이 구체적(기술 개념 학습, 업무 이슈 대비, 용어 정리 등) → `reason:` 업데이트 제안 → 승인 후 **프론트매터 한 줄만** 수정.
  - 답변이 *"모르겠다 / 그냥 / 나중에"* → **Parking으로 강등** (6단계로 점프).

⛔ 이유 없으면 `wiki/` 본체는 절대 건드리지 않는다.

## 🧭 3. Mode 결정

프론트매터 `ingest_mode:` 확인:

| 값 | 의미 | 진입 |
|----|------|------|
| `learn` | 아직 안 읽음, 배우려 넣음 | **4A** |
| `synthesize` | 이미 읽었고 정리하려 넣음 | **4B** |
| `parking` | 일단 쟁여놓고 싶음 | **6** |

누락 시 묻는다. 불확실하면 `learn` 디폴트.

---

## 🌱 4A. Learn 모드

**원본을 빠르게 훑은 뒤** 사용자에게 먼저 제시한다:

- 📏 예상 읽기 시간
- 🎯 핵심 주제 3~5개
- ⚙️ 선행 지식(이 글을 이해하려면 알아야 할 개념)

그리고 질문 (타입별 강조는 **4C** 참고):

- "이 글에서 구체적으로 뭘 얻고 싶어?"
- "이미 아는 부분 / 약한 부분은?"
- "읽을 때 어디에 집중할까?"

답변을 받으면 **읽기 가이드**를 제안:
- 저장 위치: `Output/reading-plans/YYYY-MM-DD-슬러그.md`
- 내용: 집중 포인트 / 예상 막힐 부분 / 읽은 후 자문 리스트

**사용자가 실제로 읽고 난 뒤** `/ingest` 재호출하라고 안내. 그때 `ingest_mode:` 를 `synthesize` 로 바꾸거나, 스킬이 "이제 읽었어?" 물어보고 승격한다.

## 🧪 4B. Synthesize 모드

**원본을 읽고** 초안을 구조화해서 제시:

- 🔑 **핵심 주장(Key Claims)** 3~5개
- 🧑‍🤝‍🧑 **엔티티**: 사람·도구·조직·라이브러리
- 💡 **다루는 개념(Concepts)**
- 🆕 **낯선 용어 후보 리스트** (정의가 애매하거나 처음 본 것)

그리고 질문 (타입별 강조는 **4C** 참고):

1. "핵심 주장 중 **의외**였던 건?"
2. "낯선 용어 중 **정의 확정**하고 싶은 거? (위키에 개념 페이지 만들까?)"
3. "**30초로 설명**해볼래? 막히는 지점이 **다음 학습 타겟**이야."
4. "이거 **1년 목표 리스트** 중 어디에 붙어? (sync/async, HTTP, 렌더링, React, Zustand, JS/Node 런타임, FE 아키텍처 ...)"

답변 취합 후 **Gold 재판정**:

- "이 소스, **wiki 본체까지 반영** vs **summary만 남김** 중 뭐로 갈까?"
- garbage 같으면 부드럽게 제안: "이건 summary만 남기고 본체는 패스하자."

반영 범위 확정 → **5단계**.

## 🔀 4C. 타입별 질문 강조 (4A/4B 공통으로 적용)

프론트매터의 `source_type` / `doc_type` 에 따라 질문 축을 살짝 튼다:

| 조건 | 강조 포인트 |
|------|-------------|
| `source_type: article` (일반 블로그) | 저자 관점·편향 체크, 내 기존 지식과의 **차이** |
| `doc_type: official` (공식 문서) | 용어 정의 중심, 공식 권장 패턴 → **내 워딩으로 재표현** |
| `source_type: video` (YouTube) | 영상 길이 기반 **시간 예산**, 타임스탬프 전략, 시각 이해 포인트 |
| `doc_type: github` | issue/PR/README 구분, **내 프로젝트 코드**로 어떻게 연결? |
| `doc_type: qa` (Stack Overflow 등) | 증상·원인·해결책 **3분해**, 내가 겪은 **유사 이슈** 연결 |

---

## 📝 5. Wiki 반영 (Synthesize 전용)

범위 확정 후에만 실행:

1. `wiki/summaries/YYYY-MM-DD-슬러그.md` 생성 — 필수 프론트매터:
   ```yaml
   ---
   type: summary
   sources: ["raw/articles/YYYY-MM-DD-슬러그.md"]
   reason: <raw의 reason 인용>
   updated: YYYY-MM-DD
   status: draft | stable
   tags: [...]
   ---
   ```
2. 관련 도메인 폴더의 페이지 업데이트 (`wiki/security/`·`network/`·`browser/`·`cs/`·`javascript/`·`typescript/`·`runtime/`·`react/`·`nextjs/`·`ai-native/`·`delivery/`·`workflow/`·`architecture/`·`tooling/`). 없으면 신규 제안 → 승인 후 생성. 위키링크 `[[파일명]]` 으로 교차참조. 위키링크 표기 규약은 [[WIKI_RULES]] 섹션 1 준수.
3. **충돌 시 삭제 금지**, 해당 위치에 다음 형식으로 플래그:
   ```markdown
   > ⚠️ 충돌: [[summary-A]] 는 X라고 하지만 [[summary-B]] 는 Y. 확인 필요.
   ```
4. `wiki/index.md` 갱신 — 해당 카테고리에 새 항목 추가, 변경된 페이지의 `updated` 반영.
5. `wiki/log.md` append:
   ```
   ## [YYYY-MM-DD] ingest | <제목>
   - 모드: synthesize
   - 소스: raw/.../파일.md
   - 업데이트된 페이지: [[...]], [[...]]
   - 추가된 용어: X, Y
   ```

## 🅿️ 6. Parking 처리

- `wiki/` 건드리지 않음.
- `wiki/log.md` 에 한 줄:
  ```
  ## [YYYY-MM-DD] parking | <제목> — reason: <사용자 답 or "불명">
  ```
- 종료. 다음 **Lint 주기**에 이 parking 항목들 리뷰 예정.

## 🧹 7. Raw status 업데이트 제안

**사용자 승인을 받은 뒤에만** 프론트매터 한 줄 수정:

- Synthesize 완료: `status: raw` → `status: ingested`
- Parking: `status: raw` → `status: parking`
- Learn 완료(읽기 가이드 생성까지만): `status: raw` 유지 (아직 미완)

⛔ 본문·첨부는 절대 손대지 않는다.

## 📣 8. 마무리 보고

한 번에 한 블록:

- ✅ 처리한 파일 · 사용한 모드
- 📄 생성/업데이트된 wiki 페이지 목록 (위키링크)
- 🎯 감지된 다음 학습 타겟 (있다면)
- 🔁 후속 액션 제안 ("이걸 읽고 다시 `/ingest` 해줘" / "관련해서 이런 소스 추천" 등)

---

## 🧾 참고 — 프론트매터 표준 필드 (raw/*)

```yaml
source_type: article | video
doc_type: official | github | qa   # (있으면) 세부 분류
source_url, title, author, published, captured, description
tags: [clippings, ...]
reason: ""                 # ← 인제스트 게이트 핵심
ingest_mode: learn|synthesize|parking
status: raw|ingested|parking
```

누락된 필드는 작업 중 대화로 확정하되, **`reason:` 만은 게이트**다.

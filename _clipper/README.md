# _clipper/ — Obsidian Web Clipper 템플릿

> 이 Vault의 `raw/` 스키마에 맞춰 제작된 클리퍼 템플릿 모음. Git으로 두 기기(회사 PC / Mac mini)에 동기화되어 동일하게 사용 가능.

## 📦 템플릿 목록

| 파일 | 이름 | 목적 | 저장 위치 | 자동 트리거 |
|-----|------|------|----------|-------------|
| `01-article.json` | 아티클 (기본) | 일반 블로그·뉴스레터·아티클. **폴백 역할** | `raw/articles/` | — (기본 템플릿) |
| `02-tech-docs.json` | 공식 문서 / 기술 문서 | MDN, React.dev, Next.js, Vercel, Node 등 공식 문서 | `raw/articles/` | MDN, react.dev, nextjs.org/docs, vercel.com/docs, nodejs.org, typescriptlang.org, vitejs.dev, webpack.js.org, tanstack.com, docs.github.com |
| `03-youtube.json` | YouTube 영상 | 유튜브 강의·컨퍼런스·설명 영상 | `raw/videos/` | youtube.com/watch, youtu.be, m.youtube.com/watch |
| `04-github.json` | GitHub (issue/PR/README) | 깃허브 페이지 | `raw/articles/` | github.com |
| `05-stackoverflow.json` | Stack Overflow / Q&A | 디버깅 Q&A | `raw/articles/` | stackoverflow.com, stackexchange.com |

## 🔧 설치 방법

1. 브라우저에 **Obsidian Web Clipper** 확장 설치.
2. 확장 메뉴 → **Templates** → **Import**.
3. 이 폴더의 JSON 파일을 하나씩 import.
4. 트리거가 지정된 템플릿은 해당 사이트 방문 시 자동 선택됨. 지정 없는 템플릿(`01 아티클`)을 **Default**로 설정 권장.

## 🎯 공통 스키마 (우리 raw/ 규약)

모든 템플릿은 다음 프론트매터를 출력해 LLM 인제스트가 용이하다:

```yaml
---
source_type: article | video         # raw/CLAUDE.md의 분류
doc_type: official | github | qa     # (있으면) 세부 분류
source_url: https://...
title: ...
author: [...]
published: YYYY-MM-DD
captured: YYYY-MM-DD
description: ...
tags: [clippings, article, ...]
reason: ""                           # ⚠️ 인제스트 게이트. 비어 있으면 /ingest가 먼저 이유부터 묻는다.
ingest_mode: learn                   # learn | synthesize | parking (기본 learn)
status: raw                          # raw | ingested | parking
---
```

### ⚠️ `reason` 는 **게이트**다

- 클리핑 직후 옵시디언에서 **한 줄로 이유를 적는 걸 원칙**으로. (10초 투자.)
- 안 적으면 `/ingest` 가 먼저 이유를 묻고, 답을 못 하면 **Parking 모드로 강등**돼 `wiki/` 본체에 반영되지 않음.
- 이것이 블로그 시절의 "무차별 축적 → 뒤죽박죽" 실패를 막는 핵심 장치.

### 🧭 `ingest_mode` 3-모드

| 값 | 의미 | 파이프라인 |
|----|------|----------|
| `learn` (기본) | 아직 안 읽음, 배우려 넣음 | 읽기 가이드 생성 → 사용자 읽은 뒤 재호출 |
| `synthesize` | 이미 읽었고 정리하려 넣음 | 즉시 요약 + 용어 추출 + Gold 판정 → wiki 반영 |
| `parking` | 일단 쟁여놓기 | wiki 건드리지 않고 log.md에만 한 줄 |

**파일명 규약**: `YYYY-MM-DD-[type-]제목슬러그.md`
- `01`: `2026-04-12-react-hooks-deep-dive`
- `02`: `2026-04-12-doc-usestate`
- `03`: `2026-04-12-yt-event-loop-explained`
- `04`: `2026-04-12-gh-nextjs-15-rfc`
- `05`: `2026-04-12-qa-why-does-useeffect-fire-twice`

## 🧠 LLM 인제스트 흐름

1. 사용자가 위 템플릿 중 하나로 페이지를 클립 → `raw/` 하위에 저장됨.
2. Claude에게 **"이거 ingest해줘"** 라고 해당 파일 지목.
3. AI는 `wiki/CLAUDE.md`의 Ingest 절차를 따라:
   - `wiki/summaries/`에 요약 페이지 생성 (프론트매터의 `status: raw` → wiki에서는 `status: stable|draft`).
   - 관련 `concepts/` `libs/` 등 업데이트.
   - `wiki/index.md` + `wiki/log.md` 갱신.
4. ingest 완료 후 사용자가 원하면 `raw/` 파일의 `status`를 `ingested` 로 바꾸자고 제안 가능 (선택 규약).

## 🛠 커스터마이징 포인트

- **트리거 추가/수정**: 자주 가는 사이트(Smashing Magazine, Kent C. Dodds, CSS-Tricks 등)를 `02` 트리거에 추가하면 자동 인식.
- **추가 템플릿**: 책 챕터 전용(`raw/books/`), 뉴스레터 전용 등 필요에 따라 이 폴더에 `06-*.json` 형태로 추가.
- **YouTube 스크립트**: YouTube 페이지에서 *Show transcript* 를 켠 뒤 클립하면 `{{content}}`에 스크립트가 들어감.
- **이미지 로컬 저장**: Obsidian 설정 → Files and links → Attachment folder path를 `raw/assets/`로 고정 + "Download attachments for current file" 핫키 바인딩.

## ⚠️ 주의

- 트리거 URL 패턴은 Web Clipper 버전에 따라 동작이 다를 수 있음. 설치 후 한 번씩 테스트 권장.
- `{{author|split:", "|wikilink|join}}` 필터 체인은 여러 저자를 `[[이름]]` 형태의 위키링크 리스트로 변환. 개별 author 페이지를 자동으로 만들게 해 그래프 뷰에 반영됨.
- `status: raw` 는 "아직 컴파일되지 않음"의 의미. 인제스트 후 AI가 이 값을 업데이트하지는 않으니 필요 시 수동 변경.

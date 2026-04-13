# Graph Report - wiki/  (2026-04-14)

## Corpus Check
- 12 files · ~3,500 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 51 nodes · 88 edges · 9 communities detected
- Extraction: 84% EXTRACTED · 16% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Vault 운영 로그 & 메타|Vault 운영 로그 & 메타]]
- [[_COMMUNITY_OAuth 2.0 · JWT · Bearer 토큰|OAuth 2.0 · JWT · Bearer 토큰]]
- [[_COMMUNITY_Wiki 운영 절차 (Karpathy 패턴)|Wiki 운영 절차 (Karpathy 패턴)]]
- [[_COMMUNITY_Wiki Rules (확정 규칙 4종)|Wiki Rules (확정 규칙 4종)]]
- [[_COMMUNITY_HTTP 인증 기초 · Basic · Toss|HTTP 인증 기초 · Basic · Toss]]
- [[_COMMUNITY_BasicBearer Ingest 트레이스|Basic/Bearer Ingest 트레이스]]
- [[_COMMUNITY_Base64 인코딩|Base64 인코딩]]
- [[_COMMUNITY_툴링 (ClipperSlash)|툴링 (Clipper/Slash)]]
- [[_COMMUNITY_메타 · Status Icons|메타 · Status Icons]]

## God Nodes (most connected - your core abstractions)
1. `Summary: 2026-04-13 Toss Basic/Bearer Auth` - 13 edges
2. `Wiki Index` - 12 edges
3. `Log: 2026-04-13 Basic/Bearer 인증 ingest (learn+stub)` - 11 edges
4. `Bearer 인증 (RFC 6750)` - 11 edges
5. `Basic 인증 (RFC 7617)` - 9 edges
6. `wiki/CLAUDE.md — AI 컴파일 지식 레이어` - 8 edges
7. `JWT (JSON Web Token)` - 8 edges
8. `WIKI RULES` - 8 edges
9. `LLM Wiki Pattern (Karpathy)` - 7 edges
10. `HTTP 인증 (Authentication)` - 7 edges

## Surprising Connections (you probably didn't know these)
- `폴더 구조 v2 (2026-04-13)` --semantically_similar_to--> `규칙: 폴더 구조 v2`  [INFERRED] [semantically similar]
  wiki/CLAUDE.md → wiki/meta/WIKI_RULES.md
- `Basic 인증 (RFC 7617)` --semantically_similar_to--> `Bearer 인증 (RFC 6750)`  [INFERRED] [semantically similar]
  wiki/security/basic-auth.md → wiki/security/bearer-auth.md
- `Ingest 절차` --conceptually_related_to--> `Summary: 2026-04-13 Toss Basic/Bearer Auth`  [INFERRED]
  wiki/CLAUDE.md → wiki/summaries/2026-04-13-toss-basic-bearer-auth.md
- `Ingest 절차` --conceptually_related_to--> `Log: 2026-04-13 Basic/Bearer 인증 ingest (learn+stub)`  [INFERRED]
  wiki/CLAUDE.md → wiki/log.md
- `JWT (JSON Web Token)` --semantically_similar_to--> `Bearer 토큰`  [INFERRED] [semantically similar]
  wiki/security/jwt.md → wiki/security/bearer-token.md

## Hyperedges (group relationships)
- **OAuth 2.0 Bearer 인증 플로우 (인증 프레임워크 · 인증 방식 · 토큰 형태)** — security_oauth_2, security_bearer_auth, security_bearer_token, security_jwt [EXTRACTED 0.90]
- **Basic 인증 헤더 스택 (HTTP 인증 · Authorization 헤더 · Base64 · Basic)** — security_http_authentication, security_authorization_header, security_basic_auth, cs_base64 [EXTRACTED 0.90]
- **위키 운영 3-루프 (Ingest / Query / Lint + 규칙 참조)** — claude_ingest_procedure, claude_query_procedure, claude_lint_procedure, meta_wiki_rules [EXTRACTED 0.85]

## Communities

### Community 0 - "Vault 운영 로그 & 메타"
Cohesion: 0.2
Nodes (12): 충돌 처리 규칙 (양쪽 다 남기기), 폴더 구조 v2 (2026-04-13), Ingest 절차, Lint 절차, LLM Wiki Pattern (Karpathy), Query 절차, 3-Layer Structure (raw / wiki / Output), wiki/CLAUDE.md — AI 컴파일 지식 레이어 (+4 more)

### Community 1 - "OAuth 2.0 · JWT · Bearer 토큰"
Cohesion: 0.39
Nodes (9): jwt.io (참조), oauth.net/2 (참조), Log: 2026-04-13 Basic/Bearer 인증 ingest (learn+stub), RFC 6750 (Bearer Token Usage), Bearer 인증 (RFC 6750), Bearer 토큰, JWT (JSON Web Token), OAuth 2.0 (+1 more)

### Community 2 - "Wiki 운영 절차 (Karpathy 패턴)"
Cohesion: 0.29
Nodes (8): Conflict Handling (keep both, no overwrite), Ingest Procedure, Lint Procedure, LLM Wiki Pattern (Karpathy), Query Procedure, 3-Layer Structure (raw/wiki/Output), Wikilink Cross-Reference Policy, Vault Initial Setup (2026-04-12)

### Community 3 - "Wiki Rules (확정 규칙 4종)"
Cohesion: 0.25
Nodes (8): WIKI RULES, 근거: 링크 자산·grep 편의·오탈자 방지 + 정렬 자연스러움, 근거: 파일 이동 시 링크 안 깨짐 + Obsidian 전역 해상, 규칙: 파일명 규약 (kebab-case / 날짜 prefix), 규칙: 폴더 구조 v2, 규칙: Status 자동 전이 금지, 규칙: Stub 14일 경고 / 30일 아카이브, 규칙: 위키링크 표기 규약 ([[파일명]] 만)

### Community 4 - "HTTP 인증 기초 · Basic · Toss"
Cohesion: 0.43
Nodes (7): Wiki Index, RFC 7235 (HTTP Authentication Framework), RFC 7617 (Basic Authentication), Authorization 헤더, Basic 인증 (RFC 7617), HTTP 인증 (Authentication), 토스페이먼츠 코어 API (Basic 인증 예)

### Community 5 - "Basic/Bearer Ingest 트레이스"
Cohesion: 1.0
Nodes (3): Ingest Basic/Bearer Auth (2026-04-13), Bearer Token Concept (stub), Summary: 2026-04-13 Toss Basic/Bearer Auth

### Community 6 - "Base64 인코딩"
Cohesion: 1.0
Nodes (2): Base64 인코딩, MDN: Base64 Glossary

### Community 7 - "툴링 (Clipper/Slash)"
Cohesion: 1.0
Nodes (1): Clipper Template + Slash Commands (2026-04-13)

### Community 8 - "메타 · Status Icons"
Cohesion: 1.0
Nodes (1): Status Icons (stable/draft/stub)

## Knowledge Gaps
- **23 isolated node(s):** `Clipper Template + Slash Commands (2026-04-13)`, `Status Icons (stable/draft/stub)`, `Ingest Procedure`, `Query Procedure`, `Lint Procedure` (+18 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Base64 인코딩`** (2 nodes): `Base64 인코딩`, `MDN: Base64 Glossary`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `툴링 (Clipper/Slash)`** (1 nodes): `Clipper Template + Slash Commands (2026-04-13)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `메타 · Status Icons`** (1 nodes): `Status Icons (stable/draft/stub)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `WIKI RULES` connect `Wiki Rules (확정 규칙 4종)` to `Vault 운영 로그 & 메타`, `HTTP 인증 기초 · Basic · Toss`?**
  _High betweenness centrality (0.242) - this node is a cross-community bridge._
- **Why does `Wiki Index` connect `HTTP 인증 기초 · Basic · Toss` to `Vault 운영 로그 & 메타`, `OAuth 2.0 · JWT · Bearer 토큰`, `Wiki Rules (확정 규칙 4종)`, `Basic/Bearer Ingest 트레이스`, `Base64 인코딩`?**
  _High betweenness centrality (0.232) - this node is a cross-community bridge._
- **Why does `wiki/CLAUDE.md — AI 컴파일 지식 레이어` connect `Vault 운영 로그 & 메타` to `Wiki Rules (확정 규칙 4종)`?**
  _High betweenness centrality (0.134) - this node is a cross-community bridge._
- **What connects `Clipper Template + Slash Commands (2026-04-13)`, `Status Icons (stable/draft/stub)`, `Ingest Procedure` to the rest of the system?**
  _23 weakly-connected nodes found - possible documentation gaps or missing edges._
---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[fastcgi]]", "[[was]]", "[[web-server-history]]"]
updated: 2026-04-18
status: draft
tags: [network, cgi, web-server]
---

# CGI (Common Gateway Interface)

## 한 줄 정의

웹 서버가 동적 콘텐츠를 처리하기 위해 외부 프로그램을 실행하는 표준 규약.

## 탄생 배경

1990년 정적 파일만 서빙하던 HTTP 서버로는 동적 콘텐츠(방명록, 검색) 처리 불가. 템플릿+치환 개념이 필요해짐. 해결책: 서버 코드를 수정하지 않고 **외부 프로세스에게 위임**.

## 흐름

```
브라우저: GET /search?q=cat

웹서버 판단:
  "/search" → 파일 없음 → CGI 프로세스 실행

CGI 프로세스 (Perl, Shell, C ...):
  환경변수로 요청 정보 받음 (QUERY_STRING=q=cat)
  → DB 조회
  → HTML string 생성
  → stdout으로 출력

웹서버: stdout 잡아서 HTTP 응답으로 감쌈 → 브라우저에 전달
프로세스 종료
```

## 핵심 규약

- 요청 정보: **환경변수**로 전달 (QUERY_STRING, REQUEST_METHOD, HTTP_HOST)
- 응답: **stdout**으로 출력 (Content-Type 헤더 포함)
- 결국 **string을 반환하는 것** (HTML이든 JSON이든)

## 단점

요청마다 프로세스를 생성·종료. 프로세스 하나당 ~30MB.
동시 접속 1,000명 = 1,000개 프로세스 = 30GB RAM.

## 면접 답변

> "CGI는 웹 서버가 동적 콘텐츠를 처리하기 위해 외부 프로그램을 실행하는 표준 규약입니다. HTTP 요청이 들어오면 웹 서버가 해당 경로에 매핑된 스크립트를 별도 프로세스로 실행하고, 그 스크립트가 DB 조회나 비즈니스 로직을 처리해 HTML을 생성한 뒤 stdout으로 출력합니다. 웹 서버는 이 출력을 HTTP 응답으로 감싸 브라우저에 반환하고, 프로세스는 종료됩니다. 단점은 요청마다 프로세스를 생성·종료하는 오버헤드가 크다는 점이었고, 이를 해결한 것이 FastCGI입니다."

## 관련 개념

- [[fastcgi]] — CGI의 프로세스 오버헤드 해결
- [[was]] — CGI 개념이 독립 서버로 진화
- [[web-server-history]] — 역사적 맥락

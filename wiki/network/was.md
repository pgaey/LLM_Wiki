---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[fastcgi]]", "[[reverse-proxy]]", "[[web-server-history]]"]
updated: 2026-04-18
status: draft
tags: [network, was, web-server]
---

# WAS (Web Application Server)

## 한 줄 정의

FastCGI의 "계속 살아있는 프로세스"가 DB 커넥션 풀·세션 관리·라우팅까지 품으면서 독립 서버로 진화한 것.

## FastCGI에서 WAS로

```
FastCGI 프로세스가 기능을 계속 흡수:
  + DB 커넥션 풀 (요청마다 DB 연결 안 하고 미리 열어둠)
  + 세션 관리 (로그인 유지, 사용자 상태 추적)
  + 스레드 풀 (동시 요청 처리)
  + 라우팅 (/users, /products → 핸들러 매핑)
  + 보안 필터, 미들웨어
  = WAS (독립 서버로 분리)
```

## "Application"이 들어간 이유

```
Web Server      : 파일을 찾아서 줌 (파일 시스템과 대화)
Web Application : 코드를 실행해서 줌 (애플리케이션과 대화)
Server
```

서버가 파일이 아닌 **코드(Application)를 실행**하기 때문에 Application이 들어감.

## JS로 치면

```javascript
const app = express();

app.use(session({ ... }));          // 세션 관리
const pool = mysql.createPool();   // DB 커넥션 풀

app.get('/users', async (req, res) => {
  const users = await pool.query('SELECT * FROM users');
  res.json(users);                  // string 반환
});

app.listen(3000);  // HTTP 직접 받음
```

**이 Express 앱 전체가 WAS.** Tomcat = Java 세계의 WAS.

## Web Server vs WAS

| | Web Server | WAS |
|--|--|--|
| 역할 | HTTP 관문, 정적 파일 | 동적 처리, 비즈니스 로직 |
| 상태 | Stateless | 세션·DB 커넥션 유지 |
| 직접 접속 | 가능 (권장 X) | 가능 (보통 Web Server 뒤에 숨김) |

## ⚠️ 흔한 오해

WAS가 Web Server에서 분리된 게 아님. **병렬 트랙으로 발전**, 협업 패턴이 정착된 것.

## 관련 개념

- [[fastcgi]] — WAS의 선조
- [[reverse-proxy]] — Web Server가 WAS 앞에 서는 패턴
- [[web-server-history]] — 역사적 맥락

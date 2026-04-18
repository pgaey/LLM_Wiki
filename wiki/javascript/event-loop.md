---
type: concept
kind: concept
sources: ["[[2026-04-18-nginx-web-server-study]]"]
related: ["[[nginx-architecture]]"]
updated: 2026-04-18
status: draft
tags: [javascript, event-loop, async, node]
---

# 이벤트루프 (Event Loop)

## 한 줄 정의

I/O 작업은 OS에 위임하고 완료 신호만 기다리며, CPU 작업만 직접 실행하는 비동기 처리 메커니즘.

## 구성 요소

```
┌──────────────┐
│  Call Stack  │ ← JS 코드 실행. 싱글 스레드.
└──────┬───────┘
       │ I/O 만나면
       ↓
┌──────────────┐    ┌──────────────────────┐
│   libuv      │───→│    Thread Pool / OS   │
│ (이벤트루프)  │    │  실제 I/O 처리         │
└──────┬───────┘    └──────────┬───────────┘
       │                       │ 완료
       ↓ ←──────────────────── ┘
┌──────────────┐
│ Event Queue  │ ← 완료된 콜백 대기
└──────┬───────┘
       │ Call Stack 비면
       ↓
  Call Stack으로 올려서 실행
```

## 실행 순서

```javascript
console.log("1");          // Call Stack → 즉시

setTimeout(() => {
  console.log("2");        // 0ms 후 Event Queue
}, 0);

fetch('/api')              // OS에 위임
  .then(() => {
    console.log("3");      // 네트워크 완료 후 Event Queue
  });

console.log("4");          // Call Stack → 즉시

// 출력: 1 → 4 → 2 → 3
```

`setTimeout 0ms` 인데 `4` 보다 늦게 실행 — Call Stack이 비어야 Queue에서 꺼내기 때문.

## I/O vs CPU 구분

```
이벤트루프가 잘하는 것 (I/O):
  파일 읽기, 네트워크, DB 쿼리
  → OS에 위임하고 다음 이벤트 처리

이벤트루프가 못하는 것 (CPU):
  암호화, 이미지 처리, 대규모 계산
  → Call Stack에서 직접 실행 → 블로킹
```

## ❌ 블로킹 예시

```javascript
app.get('/heavy', (req, res) => {
  // CPU 집약 작업 — 이 동안 다른 요청 전부 대기
  for (let i = 0; i < 10_000_000_000; i++) { ... }
  res.json(result);
});
```

## ✅ 비블로킹 예시

```javascript
app.get('/data', async (req, res) => {
  const data = await db.query('...');  // OS에 위임, Call Stack 안 막힘
  res.json(data);
});
```

## Nginx와의 관계

Nginx의 epoll 기반 이벤트루프와 설계 철학 동일.
Ryan Dahl (Node.js 창시자) 이 Nginx에서 영감받아 libuv 설계.

- [[nginx-architecture]] — 같은 철학의 HTTP 서버 버전

## 다음 학습 타겟

- [[libuv]] — Node.js 이벤트루프 구현 라이브러리 (별도 소스 필요)
- async/await 내부 동작 (Promise, microtask queue)

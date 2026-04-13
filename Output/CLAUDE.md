# Output/ — 최종 산출물 레이어

> `wiki/`에 누적된 지식을 바탕으로 **완성된 결과물**을 저장하는 곳. 작업 중 중간 메모는 여기 두지 않는다.

## 무엇이 들어가는가

- **로드맵**: 현재 수준에서 다음 단계로 가는 학습 순서. (예: `roadmaps/2026-04-react-fundamentals.md`)
- **비교 분석**: 기술·라이브러리 대조표. (예: `comparisons/zustand-vs-jotai.md`)
- **설명자료**: 누군가에게 말로 설명할 때 쓸 정제본. (예: `explanations/sync-async-1pager.md`)
- **슬라이드**: Marp 형식 프레젠테이션 (선택).
- **리포트**: Lint 결과 등 위키 상태 보고서.

## 작성 규칙

- **항상 `wiki/`의 페이지를 출처로 인용**. Raw 소스만 보고 만들지 않는다.
- 프론트매터:
  ```yaml
  ---
  type: roadmap | comparison | explanation | slide | report
  based_on: ["[[wiki/concepts/...]]"]
  created: 2026-04-12
  purpose: 한 줄 목적
  ---
  ```
- 완성본 기준. 임시 초안은 채팅에서 합의 후 확정본만 저장.

## AI 행동 규칙

1. Query 답변이 유의미하면 사용자에게 "`Output/`에 저장할까요?" 묻기.
2. 저장 시 적절한 하위 폴더를 **제안**(없으면 생성).
3. Output은 **시점 스냅샷**임을 의식. 기반이 된 wiki 페이지가 크게 바뀌면 `updated`를 갱신하거나 새 버전으로 파일링.

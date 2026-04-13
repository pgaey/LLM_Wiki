#!/usr/bin/env bash
# sync.sh — 일상 동기화: pull → (변경사항 있으면) commit + push
# 어디서든 작업 시작 시 / 작업 끝에 한 번씩 실행.
set -e
cd "$(dirname "$0")"

echo "🔄 동기화 시작..."

# ─── 1) 원격에서 최신 당기기 (로컬 수정 있으면 자동 stash 후 복원) ───
echo "  ← git pull --rebase --autostash"
git pull --rebase --autostash

# ─── 2) 로컬 변경사항이 있으면 commit + push ───
git add -A
if git diff --cached --quiet; then
  echo "  ✓ 변경사항 없음"
else
  MSG="sync: $(date +%F) $(date +%H:%M) on $(hostname -s)"
  git commit -m "$MSG"
  echo "  → git push"
  git push
fi

echo "✅ 동기화 완료"

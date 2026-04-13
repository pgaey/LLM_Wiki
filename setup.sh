#!/usr/bin/env bash
# setup.sh — 새 기기에서 clone 직후 한 번 실행
# 의도: 여기서 쓰는 모든 커맨드가 바로 동작하게 만든다.
set -e
cd "$(dirname "$0")"

echo "🎯 Wiki Vault 세팅"
echo "📂 위치: $(pwd)"
echo ""

# ─── [1/4] 필수 도구 체크 ───
echo "[1/4] 필수 도구 체크..."
command -v git >/dev/null || { echo "  ❌ git 필요 (brew install git)"; exit 1; }
echo "  ✅ git: $(git --version)"
if command -v python3 >/dev/null; then
  echo "  ✅ python3: $(python3 --version 2>&1)"
else
  echo "  ⚠️  python3 없음 — graphify 쓰려면 필요 (brew install python)"
fi
echo ""

# ─── [2/4] Git identity 확인 ───
echo "[2/4] Git identity..."
if [ -z "$(git config user.name)" ]; then
  read -rp "  user.name: " gn
  git config user.name "$gn"
fi
if [ -z "$(git config user.email)" ]; then
  read -rp "  user.email: " ge
  git config user.email "$ge"
fi
echo "  ✅ $(git config user.name) <$(git config user.email)>"
echo ""

# ─── [3/4] Graphify 설치 (선택) ───
echo "[3/4] Graphify (그래프 분석)"
echo "  → 집 컴퓨터(Mac mini): Y 권장 — /graphify 풀 실행"
echo "  → 회사/외부: N 권장 — graph.html · GRAPH_REPORT.md 만 읽기"
read -rp "  설치할까? [y/N] " install_gfy
if [[ "$install_gfy" =~ ^[Yy]$ ]]; then
  if ! command -v python3 >/dev/null; then
    echo "  ❌ python3 필요. 설치 후 다시 실행."
    exit 1
  fi
  if ! command -v pipx >/dev/null; then
    echo "  pipx 설치 중..."
    python3 -m pip install --user pipx 2>/dev/null || python3 -m pip install --user --break-system-packages pipx
    python3 -m pipx ensurepath >/dev/null 2>&1 || true
    # 현 세션에 PATH 반영
    export PATH="$HOME/.local/bin:$PATH"
  fi
  echo "  graphifyy 설치 중..."
  pipx install graphifyy 2>/dev/null || pipx upgrade graphifyy
  # 현 기기의 Python interpreter 경로 기록 (skill 이 재사용)
  mkdir -p graphify-out
  GRAPHIFY_BIN=$(which graphify 2>/dev/null || echo "")
  if [ -n "$GRAPHIFY_BIN" ]; then
    PY=$(head -1 "$GRAPHIFY_BIN" | tr -d '#!' | awk '{print $1}')
    case "$PY" in *[!a-zA-Z0-9/_.-]*) PY="python3" ;; esac
    echo "$PY" > graphify-out/.graphify_python
    echo "  ✅ graphify 준비 완료"
  fi
else
  echo "  건너뜀. 그래프는 graphify-out/graph.html 을 브라우저로 열면 됨."
fi
echo ""

# ─── [4/4] 완료 안내 ───
echo "[4/4] ✅ 셋업 완료"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "다음 할 것:"
echo ""
echo "  1. Obsidian 실행 → 이 폴더를 Vault 로 추가"
echo "     → $(pwd)"
echo ""
echo "  2. Chrome 에 Obsidian Web Clipper 확장 설치"
echo "     설정 → Templates → Import 로 _clipper/*.json 5개 로드"
echo "     → '01 아티클 (기본)' 을 Default 로 지정"
echo ""
echo "  3. Claude Code 를 이 폴더에서 실행"
echo "     사용 가능한 슬래시 커맨드:"
echo "       /ingest  — raw/ 소스 → wiki/ 컴파일"
echo "       /query   — wiki 기반 질의"
echo "       /lint    — 도서관 정리"
if [[ "$install_gfy" =~ ^[Yy]$ ]]; then
echo "       /graphify · /graphify --update · /graphify query"
fi
echo ""
echo "  4. 일상 동기화: ./sync.sh (pull + commit + push)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

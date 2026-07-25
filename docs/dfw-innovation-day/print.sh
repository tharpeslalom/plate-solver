#!/usr/bin/env bash
#
# print.sh — render tokenomics-deck.html to a 15-page PDF, one slide per page.
#
# WHY A SCRIPT AND NOT JUST Cmd-P:
#   Two things have to be true or the output is silently wrong.
#   1. It must be served over http, not opened as file://. The deck is fine
#      either way, but keeping one path avoids surprises with the inlined
#      images.
#   2. Chrome must use the deck's own @page size (1600x900 px). Every dimension
#      in the deck is a clamp() between px bounds around a cqw middle, so
#      rendering the page any smaller lets the px minimums win: type gets
#      proportionally larger and the layout overflows its own slide. Print at
#      the design size and let the PDF scale to paper at print time.
#
# USAGE:  ./print.sh [output.pdf]
#
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${1:-$HERE/tokenomics-deck.pdf}"
PORT="${PORT:-8811}"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"

[ -x "$CHROME" ] || { echo "FATAL: no Chrome at $CHROME (override with CHROME=...)"; exit 1; }

python3 -m http.server "$PORT" --directory "$HERE" >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER 2>/dev/null || true' EXIT
sleep 1

"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$OUT" "http://localhost:$PORT/tokenomics-deck.html" 2>/dev/null

PAGES=$(python3 -c "
d=open('$OUT','rb').read()
print(d.count(b'/Type /Page') - d.count(b'/Type /Pages'))")

echo "✅ $OUT — $PAGES pages"
[ "$PAGES" = "15" ] || echo "⚠️  expected 15 pages; check for a layout regression"

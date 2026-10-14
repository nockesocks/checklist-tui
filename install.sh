#!/bin/sh
# checklist installer. One line:
#
#   curl -fsSL https://raw.githubusercontent.com/nockesocks/checklist-tui/main/install.sh | sh
#
# Puts the app in ~/.local/share/checklist/ and a `checklist` command in
# ~/.local/bin. Run it again to update. Your lists are never touched (they
# live beside the app in checklist.md, or wherever settings point).
#
#   sh install.sh --local      install from this checkout instead of GitHub
#   sh install.sh --uninstall  remove the app and the command (keeps your lists)
set -eu

REPO="${CHECKLIST_REPO:-nockesocks/checklist-tui}"
REF="${CHECKLIST_REF:-main}"
APP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/checklist"
BIN_DIR="$HOME/.local/bin"
CMD="$BIN_DIR/checklist"

say() { printf 'checklist: %s\n' "$*"; }

if [ "${1:-}" = "--uninstall" ]; then
    rm -f "$CMD" "$APP_DIR/checklist.py"
    rmdir "$APP_DIR" 2>/dev/null || true   # only if no lists are left in it
    say "removed $CMD and $APP_DIR/checklist.py (your lists and settings were left alone)"
    exit 0
fi

command -v python3 >/dev/null 2>&1 || { say "python3 is required" >&2; exit 1; }

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

if [ "${1:-}" = "--local" ]; then
    src="$(cd "$(dirname "$0")" && pwd)/checklist.py"
    [ -f "$src" ] || { say "no checklist.py next to install.sh" >&2; exit 1; }
    cp "$src" "$tmp"
else
    command -v curl >/dev/null 2>&1 || { say "curl is required" >&2; exit 1; }
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$REF/checklist.py" -o "$tmp"
fi

# Never install a broken download.
python3 -c 'import ast, sys; ast.parse(open(sys.argv[1]).read())' "$tmp" \
    || { say "downloaded file is not valid Python; nothing installed" >&2; exit 1; }

mkdir -p "$APP_DIR" "$BIN_DIR"
install -m 755 "$tmp" "$APP_DIR/checklist.py"
ln -sfn "$APP_DIR/checklist.py" "$CMD"
say "installed $APP_DIR/checklist.py"
say "command:  $CMD"

if ! python3 -c 'import textual' >/dev/null 2>&1; then
    say "one more step: it needs the Textual library"
    if command -v pacman >/dev/null 2>&1; then
        say "  sudo pacman -S python-textual"
    else
        say "  python3 -m pip install --user textual   (or your distribution's python-textual package)"
    fi
fi

case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *) say "note: $BIN_DIR is not on your PATH; add it to run 'checklist' anywhere" ;;
esac

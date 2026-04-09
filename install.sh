#!/usr/bin/env bash
# copilot-setup installer
# Zero dependencies — pure file copy. Works air-gapped.
# Usage: ./install.sh [--target /path/to/repo]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"
if [[ "$1" == "--target" && -n "${2:-}" ]]; then TARGET="$2"; fi

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'
info()    { printf "${CYAN}[INFO]${NC}  %s\n" "$1"; }
success() { printf "${GREEN}[OK]${NC}    %s\n" "$1"; }
error()   { printf "${RED}[ERR]${NC}   %s\n" "$1"; exit 1; }

echo ""
printf "${BOLD}${CYAN}"
echo "╔════════════════════════════════════════════╗"
echo "║     copilot-setup  —  zero-dep installer   ║"
echo "╚════════════════════════════════════════════╝"
printf "${NC}\n"

# Validate target is a git repo (recommended, not required)
if [[ ! -d "$TARGET/.git" ]]; then
  info "Note: $TARGET is not a git repository. Files will still be copied."
fi

info "Installing into: $TARGET"

# .github/copilot-instructions.md
mkdir -p "$TARGET/.github"
if [[ -f "$TARGET/.github/copilot-instructions.md" ]]; then
  info "copilot-instructions.md already exists — backing up to .bak"
  cp "$TARGET/.github/copilot-instructions.md" \
     "$TARGET/.github/copilot-instructions.md.bak"
fi
cp "$SCRIPT_DIR/.github/copilot-instructions.md" \
   "$TARGET/.github/copilot-instructions.md"
success "copilot-instructions.md installed"

# Path-scoped instructions
mkdir -p "$TARGET/.github/instructions"
count=0
for f in "$SCRIPT_DIR/.github/instructions/"*; do
  [[ -f "$f" ]] || continue
  cp "$f" "$TARGET/.github/instructions/"
  count=$((count + 1))
done
success "Installed $count path-scoped instruction file(s)"

# Prompt library
mkdir -p "$TARGET/.github/prompts"
count=0
for f in "$SCRIPT_DIR/.github/prompts/"*; do
  [[ -f "$f" ]] || continue
  cp "$f" "$TARGET/.github/prompts/"
  count=$((count + 1))
done
success "Installed $count prompt file(s) (invoke with /promptname in Copilot Chat)"

# VS Code workspace settings
mkdir -p "$TARGET/.vscode"
if [[ -f "$TARGET/.vscode/settings.json" ]]; then
  info ".vscode/settings.json already exists — skipping (merge manually if needed)"
  info "Reference: $SCRIPT_DIR/.vscode/settings.json"
else
  cp "$SCRIPT_DIR/.vscode/settings.json" "$TARGET/.vscode/settings.json"
  success ".vscode/settings.json installed"
fi

echo ""
printf "${BOLD}${GREEN}"
echo "╔════════════════════════════════════════════╗"
echo "║         Installation complete!             ║"
echo "╚════════════════════════════════════════════╝"
printf "${NC}\n"
echo "Files installed in: $TARGET"
echo ""
echo "Available prompts (type /name in Copilot Chat):"
for f in "$TARGET/.github/prompts/"*.prompt.md; do
  name="$(basename "$f" .prompt.md)"
  printf "  %-20s →  /%s\n" "$name" "$name"
done
echo ""
echo "Commit these files into your repository to share with your team."

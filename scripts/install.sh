#!/usr/bin/env bash
#
# Install or update DopaVim on Linux/macOS.
#
# Usage:
#   curl -fsSL <raw url>/scripts/install.sh | bash     # or
#   ./scripts/install.sh [--force] [--skip-backup]
#
set -euo pipefail

REPO="${REPO:-https://github.com/musaeed178-uio/nvim-config.git}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
STAMP="$(date +%Y%m%d-%H%M%S)"

FORCE=0
SKIP_BACKUP=0

usage() {
  cat <<'EOF'
Install or update DopaVim.

Options:
  --force         Re-clone even if the target directory is already this repo
  --skip-backup   Do not move an existing config aside; fail instead
  -h, --help      Show this help

Environment:
  REPO            Git URL to install from
  XDG_CONFIG_HOME Overrides ~/.config (Neovim must agree with this value)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --force) FORCE=1 ;;
    --skip-backup) SKIP_BACKUP=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
  shift
done

step() { printf '==> %s\n' "$1"; }
have() { command -v "$1" >/dev/null 2>&1; }

step "Checking prerequisites"
if ! have git; then
  echo "git was not found on PATH. Install it first (e.g. apt install git)." >&2
  exit 1
fi
if ! have nvim; then
  echo "WARNING: nvim was not found on PATH. Install Neovim 0.12+ before launching." >&2
fi

missing=""
for tool in rg fd tar curl tree-sitter cc; do
  have "$tool" || missing="$missing $tool"
done
if [ -n "$missing" ]; then
  echo "WARNING: missing recommended tools:$missing" >&2
  echo "         Run ':checkhealth dopavim' inside Neovim for install hints." >&2
fi

step "Preparing $CONFIG_DIR"
if [ -d "$CONFIG_DIR" ]; then
  if [ -d "$CONFIG_DIR/.git" ]; then
    if [ "$FORCE" -eq 1 ]; then
      tmp="$(mktemp -d "${TMPDIR:-/tmp}/dopavim-XXXXXX")/nvim"
      step "Re-cloning into a temporary directory, then replacing $CONFIG_DIR"
      git clone --depth 1 "$REPO" "$tmp"
      rm -rf "$CONFIG_DIR"
      mv "$tmp" "$CONFIG_DIR"
    fi
  else
    if [ "$SKIP_BACKUP" -eq 1 ]; then
      echo "$CONFIG_DIR already exists and is not a git repository." >&2
      echo "Move it aside, or re-run without --skip-backup." >&2
      exit 1
    fi
    backup="$CONFIG_DIR.bak-$STAMP"
    echo "WARNING: existing config found. Moving it to $backup" >&2
    mv "$CONFIG_DIR" "$backup"
  fi
fi

if [ ! -d "$CONFIG_DIR/.git" ]; then
  step "Cloning DopaVim into $CONFIG_DIR"
  mkdir -p "$(dirname "$CONFIG_DIR")"
  git clone "$REPO" "$CONFIG_DIR"
else
  step "Updating existing clone"
  git -C "$CONFIG_DIR" pull --ff-only
fi

if have nvim; then
  step "Restoring pinned plugins from lazy-lock.json"
  if ! nvim --headless "+Lazy! restore" +qa; then
    echo "WARNING: plugin restore did not complete cleanly." >&2
    echo "         Start 'nvim' once and run ':Lazy restore'." >&2
  fi
fi

printf '\nDopaVim installed.\n'
printf '  1. Run:  nvim\n'
printf '  2. Inside Neovim run:  :checkhealth dopavim\n'
printf '  3. Any WARNING/ERROR there tells you exactly what is still missing.\n'

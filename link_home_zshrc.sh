#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ZSHRC="$SCRIPT_DIR/.zshrc"
TARGET_ZSHRC="$HOME/.zshrc"

if [[ ! -f "$SOURCE_ZSHRC" && ! -L "$SOURCE_ZSHRC" ]]; then
  echo "Error: $SOURCE_ZSHRC not found." >&2
  exit 1
fi

echo "WARNING: This script will delete the existing $TARGET_ZSHRC before linking." >&2
read -rp "Continue? [y/N]: " reply
if [[ ! $reply =~ ^[Yy]$ ]]; then
  echo "Aborted." >&2
  exit 1
fi

if [[ -e "$TARGET_ZSHRC" || -L "$TARGET_ZSHRC" ]]; then
  rm -f "$TARGET_ZSHRC"
fi

ln -s "$SOURCE_ZSHRC" "$TARGET_ZSHRC"
echo "Created symlink: $TARGET_ZSHRC -> $SOURCE_ZSHRC"

#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/.venv"

case "${1:-run}" in
  init)
    python3 -m venv "$VENV_DIR"
    ;;
  run)
    [ -d "$VENV_DIR" ] || python3 -m venv "$VENV_DIR"
    source "$VENV_DIR/bin/activate"
    [ -f "$SCRIPT_DIR/requirements.txt" ] && pip install -r "$SCRIPT_DIR/requirements.txt"
    Rscript "$SCRIPT_DIR/main.r"
    ;;
  *)
    echo "Usage: $0 [init|run]"
    exit 1
    ;;
esac

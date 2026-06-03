#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
SKILLS=(sp-brainstorm sp-plan sp-develop sp-review)

if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  COLOR_BLUE=$'\033[1;34m'
  COLOR_CYAN=$'\033[1;36m'
  COLOR_GREEN=$'\033[1;32m'
  COLOR_YELLOW=$'\033[1;33m'
  COLOR_RED=$'\033[1;31m'
  COLOR_RESET=$'\033[0m'
else
  COLOR_BLUE=''
  COLOR_CYAN=''
  COLOR_GREEN=''
  COLOR_YELLOW=''
  COLOR_RED=''
  COLOR_RESET=''
fi

info() {
  printf '%s[INFO]%s %s\n' "$COLOR_BLUE" "$COLOR_RESET" "$1"
}

step() {
  printf '%s[STEP]%s %s\n' "$COLOR_CYAN" "$COLOR_RESET" "$1"
}

success() {
  printf '%s[ OK ]%s %s\n' "$COLOR_GREEN" "$COLOR_RESET" "$1"
}

warn() {
  printf '%s[SKIP]%s %s\n' "$COLOR_YELLOW" "$COLOR_RESET" "$1"
}

error() {
  printf '%s[FAIL]%s %s\n' "$COLOR_RED" "$COLOR_RESET" "$1" >&2
}

copy_skill() {
  local skill_dir="$1"
  local skill_name="$2"
  local target_dir="$skill_dir/$skill_name"

  rm -rf -- "$target_dir"
  mkdir -p -- "$target_dir"
  cp -R -- "$SCRIPT_DIR/$skill_name/." "$target_dir/"
  success "Installed $skill_name -> $target_dir"
}

install_bundle() {
  local agent_name="$1"
  local root_dir="$2"
  local skill_dir="$3"

  if [[ ! -d "$root_dir" ]]; then
    warn "$agent_name not found at $root_dir"
    return 1
  fi

  step "Installing for $agent_name"
  mkdir -p -- "$skill_dir"

  local skill_name
  for skill_name in "${SKILLS[@]}"; do
    copy_skill "$skill_dir" "$skill_name"
  done

  success "$agent_name installation complete"
  return 0
}

main() {
  local skill_name
  for skill_name in "${SKILLS[@]}"; do
    if [[ ! -d "$SCRIPT_DIR/$skill_name" ]]; then
      error "Missing skill source directory: $SCRIPT_DIR/$skill_name"
      exit 1
    fi
  done

  info "Installing SP Manual Workflow skills from $SCRIPT_DIR"
  printf '\n'

  local installed_targets=0

  if install_bundle "Claude Code" "$HOME/.claude" "$HOME/.claude/skills"; then
    ((installed_targets += 1))
  fi

  printf '\n'

  if install_bundle "GitHub Copilot CLI" "$HOME/.copilot" "$HOME/.copilot/skills"; then
    ((installed_targets += 1))
  fi

  printf '\n'

  if install_bundle "Codex" "$HOME/.agents" "$HOME/.agents/skills"; then
    ((installed_targets += 1))
  fi

  printf '\n'

  if (( installed_targets == 0 )); then
    warn "No supported agent folders were found. Nothing was installed."
    exit 0
  fi

  success "Finished installing skills for $installed_targets agent(s)"
  info "Restart Claude Code, GitHub Copilot CLI, and Codex to load the updated skills."
}

main "$@"

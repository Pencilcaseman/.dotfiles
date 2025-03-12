#!/bin/bash

# Required for fish and tmux to exist in PATH
export PATH=$HOME/.nix-profile/bin:$PATH

# Try fish with tmux
if command -v fish >/dev/null 2>&1; then
  export SHELL=$(which fish)
  fish -c "tmux a -t base || tmux new -s base" && exit
fi

# Try bash with tmux
if command -v tmux >/dev/null 2>&1; then
  tmux a -t base || tmux new -s base && exit
fi

# Fall back to bash
exec bash

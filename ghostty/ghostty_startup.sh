#!/bin/bash

# Required for fish and tmux to exist in PATH
export PATH=$HOME/.nix-profile/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# If fish exists, set the shell to that
if which fish >/dev/null 2>&1; then
	export SHELL=fish
fi

if [ -z "${NO_ZELLIJ_PLZ}" ]; then
	zellij && exit
else
	$SHELL && exit
fi

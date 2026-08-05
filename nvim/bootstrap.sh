#!/bin/sh
# One-time setup: the language tools mason used to manage, now system-level.
set -ex

paru -S --needed lua-language-server rust-analyzer stylua tree-sitter-cli
# typescript pinned to 5.x: ts_ls needs tsserver.js, which the native TS 7 dropped
bun install -g typescript-language-server typescript@5.9 @fsouza/prettierd eslint_d prettier

# gopls lives in ~/go/bin already; refresh with:
#   go install golang.org/x/tools/gopls@latest

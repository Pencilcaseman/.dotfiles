{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # -- A --
    # awk-language-server

    # # -- B --
    # nodePackages.bash-language-server
    # bicep

    # # -- C --
    # clang-tools # C/C++ (clangd)
    # ccls # Alternative C/C++
    # omnisharp-roslyn # C#
    # clojure-lsp
    # cmake-language-server
    # neocmakelsp # CMake alternative
    # codeql
    # crystalline # Crystal
    # vscode-langservers-extracted # CSS, HTML, JSON, ESLint
    # cue # CUE

    # # -- D --
    # serve-d # D
    # # dart # Dart SDK includes LSP
    # dhall-lsp-server
    # dockerfile-language-server-nodejs
    # dot-language-server

    # # -- E --
    # elixir-ls
    # elmPackages.elm-language-server
    # erlang-language-platform

    # # -- F --
    # fennel-ls
    # fish-lsp # Often unpackaged or managed by fish plugins
    # fortls # Fortran
    # fsautocomplete # F#

    # # -- G --
    # asm-lsp # GAS/NASM
    # gleam
    # glsl_analyzer # GLSL
    # gopls # Go
    # graphql-language-service-cli

    # # -- H --
    # haskell-language-server
    # terraform-ls # HCL
    # helm-ls
    # superhtml # HTML (SuperHTML)

    # # -- I --

    # -- J --
    jdt-language-server # Java
    nodePackages.typescript-language-server # Javascript/Typescript
    jsonnet-language-server
    just-lsp # Just

    # -- K --
    kotlin-language-server

    # -- L --
    texlab # LaTeX
    lean4
    lua-language-server

    # -- M --
    marksman # Markdown
    markdown-oxide # Markdown
    mesonlsp

    # -- N --
    nls # Nickel
    nimlangserver # Nim
    nil # Nix
    nixd # Nix

    # -- O --
    ocamlPackages.ocaml-lsp
    ols # Odin
    openscad-lsp

    # -- P --
    perlnavigator # Perl
    phpactor # PHP alternative
    swi-prolog # Prolog
    buf # Protobuf
    protols # Protobuf
    basedpyright # Python
    python3Packages.python-lsp-server # Python (pylsp)

    # -- Q --

    # -- R --
    ruby-lsp
    solargraph # Ruby

    # -- S --
    metals # Scala
    slint-lsp
    nodePackages.svelte-language-server
    sourcekit-lsp # Swift

    # -- T --
    templ
    taplo # TOML
    tinymist # Typst

    # -- V --

    # -- W --
    wgsl-analyzer

    # -- Y --
    yaml-language-server

    # -- Z --
    zls # Zig
  ];
}

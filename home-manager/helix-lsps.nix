{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -- A --
    # ada-language-server # Not strictly in nixpkgs under this name, often part of GNAT or distinct
    nodePackages.astro-language-server
    awk-language-server
    
    # -- B --
    nodePackages.bash-language-server
    # beancount-language-server # Not in nixpkgs
    bicep # Provides bicep-langserver
    # bitbake-language-server # Not in nixpkgs
    # blueprint-compiler # Check if provides LSP
    
    # -- C --
    clang-tools # C/C++ (clangd)
    ccls # Alternative C/C++
    omnisharp-roslyn # C#
    # caddy # Often has built-in formatting/adapting
    # cairo-lang # Cairo
    clojure-lsp
    cmake-language-server
    neocmakelsp # CMake alternative
    codeql
    # common-lisp (cl-lsp) # Often setup via lisp package manager
    crystalline # Crystal
    vscode-langservers-extracted # CSS, HTML, JSON, ESLint
    cue # CUE
    
    # -- D --
    serve-d # D
    dart # Dart SDK includes LSP
    # dts-lsp # DeviceTree
    dhall-lsp-server
    # docker-compose-language-service # Not standalone in nixpkgs often
    dockerfile-language-server-nodejs
    dot-language-server
    
    # -- E --
    # earthlyls # Earthly
    elixir-ls
    elmPackages.elm-language-server
    erlang-ls
    
    # -- F --
    fennel-ls
    # fish-lsp # Often unpackaged or managed by fish plugins
    fortls # Fortran
    fsautocomplete # F#
    
    # -- G --
    asm-lsp # GAS/NASM
    # gdtoolkit # Godot (gdscript)
    gleam
    # glsl_analyzer # GLSL
    gopls # Go
    graphql-language-service-cli
    
    # -- H --
    haskell-language-server
    terraform-ls # HCL
    helm-ls
    superhtml # HTML (SuperHTML)
    # hyprls # Hyprlang
    
    # -- I --
    # idris2-lsp # Idris2
    # inko
    
    # -- J --
    jdt-language-server # Java
    nodePackages.typescript-language-server # Javascript/Typescript
    jsonnet-language-server
    # julia # Julia LSP is usually managed inside Julia
    # just-lsp # Just
    
    # -- K --
    # koka
    kotlin-language-server
    # koto-ls
    
    # -- L --
    texlab # LaTeX
    # lean4
    lua-language-server
    
    # -- M --
    marksman # Markdown
    markdown-oxide # Markdown
    mesonlsp
    # mint
    # mojo-lsp-server
    
    # -- N --
    nls # Nickel
    nimlangserver # Nim
    nil # Nix
    nixd # Nix
    # nu-lsp # Nushell
    
    # -- O --
    ocamlPackages.ocaml-lsp
    ols # Odin
    openscad-lsp
    
    # -- P --
    # pasls # Pascal
    # perlnavigator # Perl
    # pest-language-server
    # intelephense # PHP (often unfree/proprietary)
    phpactor # PHP alternative
    # termux-language-server # Pkgbuild
    # pkl-lsp
    nodePackages.prisma-language-server
    swi-prolog # Prolog
    # buf # Protobuf
    protols # Protobuf
    nodePackages.purescript-language-server
    # pyright # Python (User has basedpyright)
    python3Packages.python-lsp-server # Python (pylsp)
    # jedi-language-server # Python (jedi)
    
    # -- Q --
    # qmlls
    # quint-language-server
    
    # -- R --
    rPackages.languageserver # R
    racket # Racket
    # regols
    # rescript-language-server
    # robotframework-lsp
    ruby-lsp
    solargraph # Ruby
    rust-analyzer
    
    # -- S --
    metals # Scala
    # slangd
    slint-lsp
    # smithy-language-server
    # solc # Solidity
    # sourcepawn-studio
    # spade-language-server
    # starpls # Starlark
    nodePackages.svelte-language-server
    forc # Sway
    sourcekit-lsp # Swift
    
    # -- T --
    # teal-language-server
    templ
    taplo # TOML
    tinymist # Typst
    
    # -- V --
    vala-language-server
    # vlang-language-server # V
    svlangserver # Verilog/SystemVerilog
    # vhdl-ls
    nodePackages.vls # Vue
    
    # -- W --
    # wasm-language-server
    wgsl-analyzer
    
    # -- Y --
    yaml-language-server
    yls # Yara
    
    # -- Z --
    zls # Zig
  ];
}

{ config, pkgs, ... }:

{
  imports = [
    ./helix-lsps.nix
  ];

  home.username = "tobydavis";
  home.homeDirectory = "/Users/tobydavis";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "dotnet-sdk-6.0.428"
      "dotnet-runtime-6.0.36"
    ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Output formatting
    nix-output-monitor
    nh

    # Terminals, shells and multiplexers
    alacritty
    atuin
    fish
    starship
    zellij

    # VM
    qemu

    # Terminal tools
    # john # Brew installed
    # topgrade # Update all the tools
    # wireshark # Installed as MacOS package
    (uutils-coreutils.override { prefix = ""; }) # Rust rewrite of GNU core utilities
    ast-grep
    bat
    binsider
    bottom
    btop
    copilot-cli
    difftastic
    fd
    fzf
    gh
    git
    gitoxide
    gping
    harper # Grammar checker (ish)
    hashcat
    hexyl # Command line hex viewer
    htop
    hunspell # Spellchecker
    hyperfine
    iperf3 # Local internet speedtest over TCP/UDP
    jellyfin-ffmpeg
    jq
    jujutsu # Version control system built on Git
    just
    lazygit
    mermaid-cli
    ripgrep
    ripgrep-all
    scc # Funnier cloc alternative
    speedtest-cli
    texinfoInteractive
    tldr
    tokei # cloc alternative
    tree
    wrkflw # GitHub Actions workflow runner
    zoxide

    # # Build tools -- installed with brew
    # automake
    # libtool
    # pkg-config
    # autoconf
    # autogen

    cmakeCurses
    doxygen
    glew
    gnumake

    # Terminal fun
    asciiquarium
    cbonsai
    # oneko
    # nyancat

    # Editors
    emacs
    helix
    neovide
    neovim
    tree-sitter

    # Languages
    #  - Rust
    bacon
    rustup

    #  - Zig
    zig

    # #  - Python
    pipx
    python313
    pypy310
    uv

    #  - Typst
    typst
    typstyle

    #  - C/C++
    bear
    cppcheck
    cpplint
    lld
    lldb

    #  - Ruby
    ruby

    #  - C#
    (lib.hiPrio dotnet-sdk_9)
    (lib.lowPrio mono) # Installed via brew (breaks with msbuild)

    #  - Haskell
    ghc
    haskell-language-server

    #  - Java
    jdk21

    #  - LaTeX
    pandoc
    tectonic
    texliveFull

    # #  - Lua
    # (hiPrio lua)
    # (lowPrio luajit)

    #  - Julia
    julia-bin

    #  - JavaScript, Typescript, CSS, etc.
    bun
    corepack_20
    deno
    eslint_d
    nodejs_22
    prettierd
    typescript

    #  - Go
    go

    # Apps
    # czkawka
    sniffnet

    # Libraries and Utilities
    # rustdesk
    # rustdesk-server
    # zbar # Installed via brew
    dirbuster
    dust
    exiftool
    eza
    foremost
    graphviz # Graph visualization tool
    imagemagick
    libfabric
    libiconv
    m4
    mpv
    navi
    ncdu
    ncurses
    p7zip
    protobuf
    rustscan
    television
    wget
    yazi
    zlib
    zpaq
    zsteg

    # LSPs
    basedpyright
    ruff
  ];

  # Configure fonts for macOS
  fonts.fontconfig.enable = true;

  home.file = {
    # Example:
    # ".config/fish/config.fish".source = ./fish/config.fish;
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

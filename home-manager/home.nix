{ config, pkgs, ... }:

{
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

    # # Nerd Fonts
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.fira-code
    # nerd-fonts.monaspace

    # Terminals, shells and multiplexers
    fish
    atuin
    starship
    # zellij # Installed via cargo
    alacritty
    # lsd
    # lapce

    # VM
    qemu

    # Terminal tools
    hunspell # Spellchecker
    tldr
    hexyl # Command line hex viewer
    texinfoInteractive
    hashcat
    # john # Brew installed
    # wireshark # Installed as MacOS package
    git
    bottom
    gitoxide
    ripgrep
    ripgrep-all
    gping
    bat
    (uutils-coreutils.override { prefix = ""; }) # Rust rewrite of GNU core utilities
    btop
    htop
    difftastic
    cloc
    gh
    lazygit
    jellyfin-ffmpeg
    fzf
    fd
    copilot-cli
    tree
    speedtest-cli
    mermaid-cli
    jq
    zoxide
    hyperfine
    binsider
    just

    # # Build tools -- installed with brew
    # automake
    # libtool
    # pkg-config
    # autoconf
    # autogen

    # Terminal fun
    asciiquarium
    cbonsai
    # oneko
    # nyancat

    # Editors
    neovim
    neovide
    tree-sitter

    # Languages
    #  - Rust
    rustup
    bacon

    #  - Zig
    zig

    #  - Python
    python313
    uv
    pipx

    #  - Typst
    typst
    typstyle

    #  - C/C++
    cppcheck
    cpplint
    lld
    lldb
    bear

    #  - C#
    (hiPrio dotnet-sdk_9)
    (lowPrio mono) # Installed via brew (breaks with msbuild)

    #  - Haskell
    ghc
    haskell-language-server

    gnumake
    cmakeCurses
    doxygen
    glew

    #  - Java
    jdk21

    #  - LaTeX
    texliveFull # Consider texlive.scheme-small or medium if full is too large
    tectonic
    pandoc

    # #  - Lua
    # (hiPrio lua)
    # (lowPrio luajit)

    #  - Julia
    julia_19-bin

    #  - JavaScript, Typescript, CSS, etc.
    nodejs_22
    typescript
    eslint_d
    prettierd
    corepack_20
    bun
    deno

    #  - Go
    go

    # Apps
    # sniffnet
    # czkawka

    # Libraries and Utilities
    zpaq
    p7zip
    mpv
    yazi
    dust
    television
    eza
    navi
    rustscan
    wget
    exiftool
    foremost
    zsteg
    imagemagick
    # zbar # Installed via brew
    dirbuster
    libfabric
    m4
    protobuf
    # pkg-config # Duplicate, already under build tools
    libiconv
    zlib
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

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tobydavis";
  home.homeDirectory = "/Users/tobydavis";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # pkgs.htop

    # Makes the output pretty :)
    nix-output-monitor
    nh

    # nerdfonts
    # (pkgs.nerdfonts.override {
    #   fonts = [ "JetBrainsMono" ];
    # })

    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace

    # Terminals, shells and multiplexers
    fish
    starship
    # zellij
    tmux
    # alacritty
    # lsd
    # alacritty
    starship
    # lapce

    # Czkawka (doesn't work)
    # glib
    # gtk4
    # librsvg 
    # libheif 
    # libraw
    # czkawka

    # GNUPlot
    # gnuplot

    # VMs
    # ovftool
    qemu

    # Terminal tools
    tldr
    texinfoInteractive
    git
    gnused
    bottom
    gitoxide
    ripgrep
    ripgrep-all
    gping
    bat
    btop
    htop
    difftastic
    cloc
    glow
    gh
    lazygit
    jellyfin-ffmpeg
    fzf
    fd
    copilot-cli
    tree
    speedtest-cli
    jq
    rewrk
    zoxide
    hyperfine
    rename
    just
    watch

    autoconf269
    libtool
    automake

    # Terminal things (kinda useless but fun)
    # cmatrix
    # cowsay
    # lolcat
    # neofetch

    # Editors
    # emacs
    neovim
    # helix
    neovide

    tree-sitter

    # Languages
    #  - Rust 
    rustup
    bacon

    #  - Zig
    zig

    #  - Python 
    # python313
    # pypy310

    #  - Typst
    typst

    #  - Perl 
    # perl
    # perlPackages

    #  - C/C++
    cppcheck
    cpplint
    lld
    # mold
    lldb
    bear
    # libgccjit
 
    # WARNING: The following may cause issues when compiling with 
    # Apple-related things.
    # NOTE: Currently replaced with custom installations
    #
    # (hiPrio gcc13)
    # (lowPrio llvmPackages_18.libllvm)
    # (lowPrio llvmPackages_18.libcxxClang)
    # (lowPrio llvmPackages_18.libcxx)
    # (lowPrio llvmPackages_18.clang-tools)
    #
    # llvmPackages_18.clang-tools
    # compdb

    # Haskell
    ghc

    # cmake
    # gnumake
    cmakeCurses
    doxygen
    glew
    # cudaPackages.cuda_nvcc

    # Fortran 
    # (gfortran13.overrideAttrs (oldAttrs: {
    #   postInstall = (oldAttrs.postInstall or "") + ''
    #     rm -f $out/bin/g++
    #   '';
    # }))

    #  - Java
    jdk21

    #  - LaTeX 
    # texliveFull
    tectonic
    pandoc

    #  - Lua
    (hiPrio lua)
    (lowPrio luajit)

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
    czkawka

    # Libraries
    mpv # CLI video player
    yazi # CLI file explorer
    television # CLI fuzzy finder
    eza # An alternative to the unix `ls` command
    rustscan
    wget
    exiftool
    foremost # This thing is awesome
    zsteg # Steganography
    imagemagick
    # zbar # Installed via brew
    dirbuster
    libfabric
    m4
    protobuf
    pkg-config
    libiconv
    zlib
    # mpi
    darwin.Security
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tobydavis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # pkgs.mkShell { buildInputs = [ darwin.apple_sdk.frameworks.Security pkgconfig openssl ]; }
}

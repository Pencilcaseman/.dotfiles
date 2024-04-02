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

    nerdfonts

    # Terminals, shells and multiplexers
    fish
    starship
    zellij
    alacritty
    lsd
    alacritty
    starship
    lapce

    # VMs
    # ovftool
    qemu

    # Terminal tools
    bottom
    gitoxide
    ripgrep
    gping
    bat
    btop
    htop
    difftastic
    cloc
    glow
    git
    gh
    # lazygit # Using master -- can use this after next release
    jellyfin-ffmpeg
    fzf
    fd
    copilot-cli
    thefuck
    tree
    speedtest-cli
    jq
    rewrk
    zoxide
    hyperfine
    rename
    just

    autoconf269
    libtool
    automake

    # Terminal things (kinda useless but fun)
    cmatrix
    cowsay
    lolcat
    neofetch

    # Editors
    neovim
    helix
    neovide

    # Languages
    #  - Rust 
    rustup

    #  - Python 
    # python313
    pypy310

    #  - Typst
    typst

    #  - C/C++
    cppcheck
    # libgccjit

    # The following may cause issues when compiling with 
    # Apple-related things.
    # (hiPrio gcc13)
    # (lowPrio llvmPackages_17.libllvm)
    # (lowPrio llvmPackages_17.libcxxClang)
    # (lowPrio llvmPackages_17.libcxx)
    # (lowPrio llvmPackages_17.libcxxabi)

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
    tectonic

    #  - Lua 
    luajit

    #  - JavaScript, Typescript, CSS, etc. 
    nodejs_21
    typescript
    eslint_d
    prettierd
    corepack_21

    #  - Go 
    go

    # Apps
    sniffnet

    # Libraries
    libiconv
    mpi
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

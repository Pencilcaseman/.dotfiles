# .dotfiles
My tool configuration and dotfiles

## Installation and Configuration 

Clone the repository into your home directory in a folder called `.config`. If you already have a `.config` folder, clone the repository somewhere else and copy whatever files you need.

```
cd ~/
git clone https://github.com/Pencilcaseman/.dotfiles .config
```

### Prerequisites
#### [NixOS](https://nixos.org)

Install NixOS with the following commands. The default settings should work fine, but feel free to change things if necessary.

1. Linux: `sh <(curl -L https://nixos.org/nix/install) --daemon`
2. MacOS: `sh <(curl -L https://nixos.org/nix/install)`
3. Windows (WSL2): `sh <(curl -L https://nixos.org/nix/install) --daemon`

> [!CAUTION]
> Ensure NixOS is allowed to use `sudo`. This is required for `home-manager`

#### [Home-Manager](https://github.com/nix-community/home-manager)

Install Home-Manager to deal with the configuration. Make sure you installed NixOS with `sudo` privileges.

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

#### Adjust the Home-Manager Configuration 
After cloning the repository, `cd` into `home-manager/` and change the following to match your username and setup:

1. `home.nix`
    - `home.username`: Replace with your system username
    - `home.homeDirectory`: Replace with your home directory (this can often be found with `echo $HOME`)
2. `flake.nix`
    - `defaultPackage.aarch64-darwin = ...`: Replace references to `aarch64-darwin` with your target architecture
    - `"tobydavis" = home-manager.lib.homeManagerConfiguration`: Use your system username (the same as `home.username` from earlier)
    - `pkgs = import nixpkgs { system = "aarch64-darwin"; };`: Again, replace `aarch64-darwin` with your target architecture

Note that you may need to add or remove some of the packages listed in `home.nix`. If you make a change, just run `home-manager switch` to use the new configuration.

### Build and Use the Configuration 

Finally, run the following command to start using the configuration 

```
home-manager switch
```

You can update the packages in the configuration by running 

```
cd ~/.config/home-manager 
nix flake update 
home-manager switch
```

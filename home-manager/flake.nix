{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nightly neovim
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  nixConfig =  {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;


    homeConfigurations = {
      "tobydavis" = home-manager.lib.homeManagerConfiguration
      {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };

        extraSpecialArgs = { inherit inputs; };

        modules = [ ./home.nix ];
      };
    };
  };
}

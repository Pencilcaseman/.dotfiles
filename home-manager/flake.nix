{
  description = "Home Manager Configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

    homeConfigurations = {
      "tobydavis" = home-manager.lib.homeManagerConfiguration
        {
          pkgs = import nixpkgs { system = "aarch64-darwin"; };

          modules = [ ./home.nix ];
        };
    };
  };
}

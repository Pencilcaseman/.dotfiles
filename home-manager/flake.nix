{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    defaultPackage.aarch64-linux = home-manager.defaultPackage.aarch64-linux;

    homeConfigurations = {
      "tobydavis" = home-manager.lib.homeManagerConfiguration
        {
          pkgs = import nixpkgs { system = "aarch64-linux"; };

          modules = [ ./home.nix ];
        };
    };
  };
}

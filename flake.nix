{
  description = "Nydragon's configuration'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        xps9510 = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/xps9510/configuration.nix ];
          specialArgs = {
            inherit
              inputs
              outputs
              system
              pkgs
              ;
          };
        };
      };

      templates = import ./templates { self = self.templates; };
    };
}

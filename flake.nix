{
  description = "Nydragon's configuration'";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      inherit (self) outputs;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        xps9510 = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/xps9510/configuration.nix ];
          specialArgs = { inherit inputs outputs system unstable; };
        };
      };
    };
}

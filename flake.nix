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
        marr = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/marr/configuration.nix ];
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

      devShell."${system}" = pkgs.mkShell {
        buildInputs = with pkgs; [
          pre-commit
          nixfmt-rfc-style
          nodePackages.prettier
          typos
        ];
        shellHook = ''
          ${pkgs.pre-commit}/bin/pre-commit install -f
        '';
      };
      templates = import ./templates;
    };
}

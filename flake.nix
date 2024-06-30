{
  description = "Nydragon's configuration'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
      overlays = import ./overlays;

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlays.calibre ];
        config = {
          allowUnfree = true;
          packageOverrides = pkgs: {
            custom = {
              scripts = import ./home/scripts { inherit pkgs; };
            };
          };
        };

      };

      lib = nixpkgs.lib;

      mkSystem =
        {
          hostname,
          extraModules ? [ ],
        }:
        lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/${hostname}/configuration.nix ] ++ extraModules;
          specialArgs = {
            inherit
              inputs
              outputs
              system
              lib
              pkgs
              hostname
              ;

            username = "nico";
          };
        };
    in
    {
      nixosConfigurations = {
        marr = mkSystem {
          hostname = "marr";
          extraModules = [
            #inputs.nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
          ];
        };

        brontes = mkSystem { hostname = "brontes"; };
      };

      devShells."${system}".default = pkgs.mkShell {
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

{
  description = "Nydragon's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    rofi-obsidian = {
      url = "github:nydragon/rofi-obsidian";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nysh = {
      url = "github:nydragon/nysh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?rev=0f594732b063a90d44df8c5d402d658f27471dfe&submodules=1";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hosts
        ./parts
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
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
        };
    };
}

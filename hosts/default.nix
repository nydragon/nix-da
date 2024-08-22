{ inputs, ... }:
let
  inherit (inputs.self) lib;
in
{
  flake.nixosConfigurations = {
    marr = lib.my.mkSystem {
      hostname = "marr";
      system = "x86_64-linux";
      extraModules = [ inputs.agenix.nixosModules.default ];
    };

    brontes = lib.my.mkSystem {
      hostname = "brontes";
      system = "x86_64-linux";
      extraModules = [ inputs.agenix.nixosModules.default ];
    };

    styrak = lib.my.mkSystem {
      hostname = "styrak";
      system = "x86_64-linux";
      extraModules = [ inputs.disko.nixosModules.disko ];
    };

    raptus = lib.my.mkSystem {
      hostname = "raptus";
      system = "x86_64-linux";
      extraModules = [
        inputs.disko.nixosModules.disko
        inputs.agenix.nixosModules.default
      ];
    };
  };
}

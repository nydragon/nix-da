{ inputs, ... }:
let
  inherit (inputs.self) lib;
in
{
  flake.nixosConfigurations = {
    marr = lib.my.mkSystem {
      hostname = "marr";
      system = "x86_64-linux";
    };

    brontes = lib.my.mkSystem {
      hostname = "brontes";
      system = "x86_64-linux";
    };

    styrak = lib.my.mkSystem {
      hostname = "styrak";
      system = "x86_64-linux";
      extraModules = [ inputs.disko.nixosModules.disko ];
    };
  };
}

{ lib, ... }:
let
  inherit (lib.types) bool array string;

in

{
  options = {
    device = {
      pubKeys = lib.mkOption {
        type = array string;
        default = [ ];
      };

      type = {
        gaming.enable = lib.mkEnableOption {
          type = bool;
          default = false;
        };

        graphical.enable = lib.mkEnableOption {
          type = bool;
          default = false;
        };

        workstation.enable = lib.mkEnableOption {
          type = lib.types.bool;
          default = false;
        };

        server.enable = lib.mkEnableOption {
          type = lib.types.bool;
          default = false;
        };

        vm.enable = lib.mkEnableOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };
  };

}

{ lib, ... }:
{
  options = {
    device = {
      type = {
        gaming.enable = lib.mkEnableOption {
          type = lib.types.bool;
          default = false;
        };

        graphical.enable = lib.mkEnableOption {
          type = lib.types.bool;
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

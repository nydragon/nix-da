{ lib, config, ... }:
{
  options = {
    device = {
      type = {
        gaming.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };

        graphical.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };

        workstation.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };

        server.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };

        vm.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };
  };
}

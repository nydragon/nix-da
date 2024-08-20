{ inputs, lib, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      custom = {
        scripts = import ../../home/scripts { inherit pkgs lib; };
        rofi-obsidian = inputs.rofi-obsidian.outputs.packages.${pkgs.system}.rofi-obsidian;
      };
    };
  };
}

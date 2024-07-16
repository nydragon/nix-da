{ inputs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      custom = {
        scripts = import ../../home/scripts { inherit pkgs; };
        rofi-obsidian = inputs.rofi-obsidian.outputs.packages.${pkgs.system}.rofi-obsidian;
      };
    };
  };
}

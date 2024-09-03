{
  pkgs,
  lib,
  config,
  ...
}:
let
  toCSS = import ./tocss.nix;
in
lib.mkIf config.programs.waybar.enable {
  programs.waybar = {
    style = toCSS {
      inherit pkgs;
      file = ./style.scss;
    };
    settings = {
      main = import ./config.nix { inherit pkgs; };
    };
  };
}

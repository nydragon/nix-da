{ pkgs, ... }:
let
  toCSS = import ./tocss.nix;
in
{
  programs.waybar = {
    enable = true;
    style = toCSS {
      inherit pkgs;
      file = ./style.scss;
    };
    settings = {
      main = import ./config.nix;
    };
  };
}

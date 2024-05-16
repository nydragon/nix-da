{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      main = import ./config.nix;
    };
  };
}

{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      waybar
      grim
      slurp
      wl-clipboard
      swaynotificationcenter
      swaybg
      swaylock
      swayidle
    ];
  };
}

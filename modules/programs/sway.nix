{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.programs.sway.enable {
  programs.sway = {
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

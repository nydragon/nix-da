{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  hyprEnabled = osConfig.programs.hyprland.enable;
  swayEnabled = osConfig.programs.sway.enable;
  inherit (lib) mkIf;
in
mkIf (hyprEnabled || swayEnabled) {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = mkIf hyprEnabled "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        (mkIf hyprEnabled {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        })
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}

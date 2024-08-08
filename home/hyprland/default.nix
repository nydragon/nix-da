{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}:
lib.mkIf osConfig.programs.hyprland.enable {
  home.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      "$mod" = "SUPER";

      monitor = [
        "DP-2,1920x1080@144, 1920x0, 1"
        "HDMI-A-1,1920x1080@60, 0x0, 1"
      ];

      exec-once = [
        "${pkgs.swaynotificationcenter}/bin/swaync"
        "${pkgs.nextcloud-client}/bin/nextcloud --background"
        "${pkgs.kdeconnect}/bin/kdeconnect-indicator"
        "${pkgs.protonmail-bridge-gui}/bin/protonmail-bridge-gui --no-window"
        "${pkgs.waybar}/bin/waybar"
        # keepassxc ignores themeing and doesnt show up in system tray otherwise
        # Dirty solution but hey
        "sleep 3 && ${pkgs.keepassxc}/bin/keepassxc"
        (lib.mkIf config.services.hypridle.enable "${pkgs.hypridle}/bin/hypridle")
      ];

      general = {
        gaps_in = 3;
        gaps_out = 10;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      input = {
        numlock_by_default = true;
        kb_options = "compose:caps";
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };
      windowrulev2 =
        let
          mkRegexList = list: "^(${(lib.strings.concatStringsSep "|" list)})$";
        in
        [
          "float,initialClass:${
            mkRegexList [
              "com.nextcloud.desktopclient.nextcloud"
              "soffice"
              "xdg-desktop-portal-gtk"
            ]
          }"
          "bordercolor rgb(e50000) rgb(ff8d00) rgb(ffee00) rgb(028121) rgb(004cff) rgb(770088), fullscreen:1"
          "focusonactivate, title:${mkRegexList [ "Firefox" ]}"
          "workspace 2,initialClass:${mkRegexList [ "firefox" ]}"
          "workspace 3,initialClass:${mkRegexList [ "obsidian" ]}"
          "workspace 4,initialClass:${mkRegexList [ "discord" ]}"
          "workspace 5,initialClass:${mkRegexList [ "lollypop" ]}"

          # Fixes: Nextcloud Client having a variable size depending on open tiled windows
          "size 30% 50%, initialClass:com.nextcloud.desktopclient.nextcloud"
          # Fixes: Nextcloud Client closing instantly because the cursor is not on the app
          "noinitialfocus, initialClass:com.nextcloud.desktopclient.nextcloud"
        ];
      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {

        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
        focus_on_activate = true; # Open windows without focusing them
      };

      bindm = [ "$mod,mouse:272,movewindow" ];

      bind =
        [
          "$mod, D, exec, ${pkgs.fuzzel}/bin/fuzzel"
          "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"
          "$mod, Return, exec, ${pkgs.foot}/bin/foot"
          "$mod SHIFT, Q, killactive,"
          "$mod, V, togglefloating"
          "$mod SHIFT, P, exec, rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu"
          "$mod, P, exec, ${pkgs.cliphist}/bin/cliphist wipe & ${pkgs.hyprlock}/bin/hyprlock"
          "$mod SHIFT, C, exec, hyprctl reload"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Example special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          "$mod, X, fullscreen, 1"
          "$mod, F, fullscreen, 0"
          "$mod, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
          "$mod, U, exec, ${pkgs.hyprpicker}/bin/hyprpicker -r -z & ${pkgs.hyprshot}/bin/hyprshot -o ~/Pictures/screenshots -m region"
          "$mod SHIFT, U, exec, ${pkgs.hyprpicker}/bin/hyprpicker -r -z & ${pkgs.hyprshot}/bin/hyprshot --raw -m region | ${pkgs.swappy}/bin/swappy -f -"

          #: Brightness and Media {{{
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s +10%"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
          ",XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5"
          ",XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5"
          ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -m"
          ",XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
          ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ",XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          #: }}}
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
  };
}

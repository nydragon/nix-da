# vim:fileencoding=utf-8:foldmethod=marker
{ pkgs, config, lib, ... }: {
  imports = [ ./swayidle.nix ];

  wayland.windowManager.sway = let
    screenshot = (import ../scripts { inherit pkgs; }).screenshot;
    set-background = (import ../scripts { inherit pkgs; }).set-background;

    homeDirectory = config.home.homeDirectory;
    term = "${pkgs.alacritty}/bin/alacritty";
    filemanager = "${pkgs.gnome.nautilus}/bin/nautilus";
    colors = {
      lavender = "#babbf1";
      black = "#000000";
    };
    inputs = {
      kb = {
        builtin = "1:1:AT_Translated_Set_2_keyboard";
        keychron = "1452:591:Keychron_K4_Keychron_K4";
        keychron_bt = "1452:591:Keychron_K4";
      };
    };
    wallpaper = "${homeDirectory}/Pictures/backgrounds/catppucchin";
    scripts = "${homeDirectory}/.config/system_scripts";
  in {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true;
    extraConfigEarly = ''
      exec systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service
    '';
    extraConfig = ''
      titlebar_padding 1
      floating_modifier Mod4 normal
      bindgesture {
        swipe:right workspace prev
        swipe:left workspace next
        swipe:up focus up
        swipe:down focus down
      }
      workspace 1
    '';
    config = {
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
      modifier = "Mod4";
      #: Keybindings {{{
      keybindings = let mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.swaylock}/bin/swaylock";
        "${mod}+Shift+p" =
          "exec ${pkgs.rofi}/bin/rofi -show p -modi p:rofi-power-menu";
        # Reload the config file
        "${mod}+Shift+c" = "reload";
        # Kill the focused window
        "${mod}+Shift+q" = "kill";
        # Make focused window fullscreen
        "${mod}+f" = "fullscreen";
        # Start launcher
        "${mod}+d" =
          "exec rofi -config ${homeDirectory}/.config/rofi/config.rasi -show combi -automatic-save-to-history | xargs swaymsg exec --";
        # Toggle the current focus between tiling and floating mode
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+Return" = "exec ${term}";
        "${mod}+e" = "exec ${filemanager}";
        "${mod}+x" = "layout toggle stacking split";
        "${mod}+Control+Left" = "workspace prev";
        "${mod}+Control+Right" = "workspace next";
        "${mod}+n" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t";
        "--locked XF86MonBrightnessUp" =
          "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s +10%";
        "--locked XF86MonBrightnessDown" =
          "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 10%-";
        "--locked XF86AudioRaiseVolume" =
          "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -i 5";
        "--locked XF86AudioLowerVolume" =
          "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -d 5";
        "--locked XF86AudioMicMute" =
          "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer --default-source -m";
        "--locked XF86AudioMute" =
          "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -t";
        "--locked XF86AudioPlay" = "exec playerctl play-pause";
        "--locked XF86AudioPause" = "exec playerctl play-pause";
        "--locked XF86AudioNext" = "exec playerctl next";
        "--locked XF86AudioPrev" = "exec playerctl previous";
        "Print" = "exec ${screenshot}/bin/screenshot";
        "${mod}+u" = "exec ${screenshot}/bin/screenshot";
        #: {{{
        "--input-device=${inputs.kb.builtin} ${mod}+ampersand" =
          "workspace number 1";
        "--input-device=${inputs.kb.builtin} ${mod}+eacute" =
          "workspace number 2";
        "--input-device=${inputs.kb.builtin} ${mod}+quotedbl" =
          "workspace number 3";
        "--input-device=${inputs.kb.builtin} ${mod}+apostrophe" =
          "workspace number 4";
        "--input-device=${inputs.kb.builtin} ${mod}+parenleft" =
          "workspace number 5";
        "--input-device=${inputs.kb.builtin} ${mod}+minus" =
          "workspace number 6";
        "--input-device=${inputs.kb.builtin} ${mod}+egrave" =
          "workspace number 7";
        "--input-device=${inputs.kb.builtin} ${mod}+underscore" =
          "workspace number 8";
        "--input-device=${inputs.kb.builtin} ${mod}+ccedilla" =
          "workspace number 9";
        "--input-device=${inputs.kb.builtin} ${mod}+agrave" =
          "workspace number 10";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+ampersand" =
          "move container to workspace number 1";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+eacute" =
          "move container to workspace number 2";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+quotedbl" =
          "move container to workspace number 3";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+apostrophe" =
          "move container to workspace number 4";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+parenleft" =
          "move container to workspace number 5";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+minus" =
          "move container to workspace number 6";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+egrave" =
          "move container to workspace number 7";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+underscore" =
          "move container to workspace number 8";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+ccedilla" =
          "move container to workspace number 9";
        "--input-device=${inputs.kb.builtin} ${mod}+Shift+agrave" =
          "move container to workspace number 10";
        #: }}}
      };
      #: }}}
      #: Startup {{{
      startup = [
        {
          command =
            "${pkgs.swayidle}/bin/swayidle -C ${homeDirectory}/.config/swayidle/config";
        }
        {

          command = "${pkgs.swaynotificationcenter}/bin/swaync";
        }
        {
          command = ''
            [ -z "$(pidof nextcloud)" ] && ${pkgs.nextcloud-client}/bin/nextcloud --background'';
        }
        {
          command = ''
            [ -z "$(pidof kdeconnect-indicator)" ] && ${pkgs.kdeconnect}/bin/kdeconnect-indicator
          '';
        }
        {
          command =
            "${scripts.set-background}/bin/set-background -f ${wallpaper}";
          always = true;
        }
        {
          command =
            "${pkgs.swaynotificationcenter}/bin/swaync-client --reload-config --reload-css";
          always = true;
        }
      ];
      #: }}}
      assigns = {
        "2" = [{ app_id = "firefox"; }];
        "3" = [ ];
        "4" = [{ class = "discord"; }];
        "5" = [{ app_id = "lollypop"; }];
      };
      seat = {
        "*" = {
          xcursor_theme = "Catppuccin-Frappe-Lavender-Cursors 32";
          keyboard_grouping = "none";
        };
      };
      window = {
        border = 3;
        commands = [
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              class = "^.*$";
              app_id = "^.*$";
            };
          }
          {
            command = "floating enable";
            criteria.app_id = "^(${
                (lib.strings.concatStringsSep "|" [
                  "org.keepassxc.KeePassXC"
                  "xdg-desktop-portal-gtk"
                  "org.kde.polkit-kde-authentication-agent-1"
                  "com.nextcloud.desktopclient.nextcloud"
                ])
              })$";

          }
          {
            command = ''title_format "[XWayland] %title"'';
            criteria.shell = "xwayland";
          }
          {
            command = "move position mouse";
            criteria.app_id = "com.nextcloud.desktopclient.nextcloud";
          }
        ];
      };
      terminal = "${term}";
      colors = with colors; {
        focused = {
          border = lavender;
          background = lavender;
          text = black;
          indicator = "#00d4ff";
          childBorder = lavender;
        };
      };
      gaps = { inner = 5; };
      #: Input {{{
      input = {
        "*" = {
          xkb_layout = "fr,us";
          xkb_options = "grp:alt_shift_toggle,compose:caps";
        };
        "${inputs.kb.builtin}" = { xkb_layout = "fr"; };
        "${inputs.kb.keychron}" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
        };
        "${inputs.kb.keychron_bt}" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          click_method = "clickfinger";
        };
      };
      #: }}}
      #: Output {{{
      output = {
        eDP-1 = {
          scale = "2";
          pos = "0 0";
          res = "3840x2400";
          adaptive_sync = "on";
        };
      };
      #: }}}
    };
  };
}

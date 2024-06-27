{
  pkgs,
  username,
  config,
  ...
}:
{
  home-manager.users.${username} = {
    imports = [
      ../../home/firefox
      ../../home/fish
      ../../home/neovim
      ../../home/thunderbird
      ../../home/git
      ../../home/rofi
      ../../home/swaync
      ../../home/waybar
      ../../home/hyprland
      ../../home/hyprlock
      ../../home/hypridle
      ../../home/themes/catppuccin.nix
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    services.blueman-applet.enable = true;

    home = {
      stateVersion = config.system.stateVersion;
      inherit username;

      packages =
        let
          scripts = import ../../home/scripts/list.nix { inherit pkgs; };
          programs = with pkgs; [
            keepassxc
            kdeconnect
            nextcloud-client
            cliphist
            digikam
            fragments
            element-desktop
            libreoffice
            loupe
            gnome.seahorse
            gimp
            vlc
            thunderbird
            keepassxc
            gnome.nautilus
            rofi-power-menu
            lollypop
            protonmail-bridge-gui
            varia
            signal-desktop
            calibre
            alacritty

            # CLI tools
            delta
            fzf
            jhead
            fdupes
            exiftool
            sshfs
            zip
            unzip
            lazygit
            fd
            ripgrep

          ];
        in
        programs ++ scripts;
    };
  };
}

{
  pkgs,
  username,
  config,
  ...
}:
{
  home-manager.users.${username} = rec {
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
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    qt.platformTheme.name = "gtk";
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Frappe-Compact-Lavender-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          size = "compact";
          variant = "frappe";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "lavender";
          flavor = "frappe";
        };
      };
      cursorTheme = with home.pointerCursor; {
        inherit name package size;
      };
    };

    services.blueman-applet.enable = true;

    home = {
      stateVersion = config.system.stateVersion;
      inherit username;
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "catppuccin-frappe-lavender-cursors";
        package = pkgs.catppuccin-cursors.frappeLavender;
        size = 32;
      };

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

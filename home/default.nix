{
  stateVersion,
  username,
  homeDirectory,
  pkgs,
  ...
}:
rec {
  imports = [
    ./firefox
    ./fish
    ./sway
    ./neovim
    ./rofi
    ./thunderbird
    ./git
    ./vscodium
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  services.blueman-applet.enable = true;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "catppuccin-frappe-lavender-cursors";
      package = pkgs.catppuccin-cursors.frappeLavender;
      size = 32;
    };

    packages =
      let
        pk = with pkgs; [
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

          # Proprietary
          postman
          mongodb-compass

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
          swaybg
        ];
        scripts = with import ./scripts { inherit pkgs; }; [
          screenshot
          set-background
          nixedit
        ];
      in
      scripts
      ++ pk
      ++ [
        (pkgs.calibre.overrideAttrs (old: {
          postInstall = ''
            wrapProgram $out/bin/calibre \
                --set QT_QPA_PLATFORM xcb \
                --set-default ACSM_LIBCRYPTO ${pkgs.openssl.out}/lib/libcrypto.so \
                --set-default ACSM_LIBSSL ${pkgs.openssl.out}/lib/libssl.so
          '';
        }))
      ];

    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
}

{
  stateVersion,
  username,
  homeDirectory,
  pkgs,
  ...
}:
{
  imports = [
    ./firefox
    ./fish
    ./sway
    ./neovim
    ./rofi
    ./thunderbird
    ./git
  ];

  xdg.configFile."gtk-4.0/gtk.css".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Blue-Dark/gtk-4.0/gtk.css";

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  services.blueman-applet.enable = true;

  qt.enable = true;
  qt.platformTheme.name = "gtk";

  gtk =
    let
      pointer = {
        name = "Catppuccin-Frappe-Lavender-Cursors";
        package = pkgs.catppuccin-cursors.frappeLavender;
        size = 32;
      };
    in
    {
      enable = true;
      theme = {
        name = "Catppuccin-Frappe-Compact-Lavender-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          size = "compact";
          variant = "frappe";
        };
      };
      cursorTheme = pointer;
      iconTheme = {
        name = "Papirus-Dark";
        #   package = pkgs.papirus-icon-theme;
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "lavender";
          flavor = "frappe";
        };
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
            wrapProgram $out/bin/calibre --prefix QT_QPA_PLATFORM = "xcb"
          '';
        }))
      ];

    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
}

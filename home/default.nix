{
  stateVersion,
  username,
  homeDirectory,
  pkgs,
  ...
}:
let
  scripts = import ./scripts { inherit pkgs; };
in
{
  imports = [
    ./firefox
    ./fish
    ./sway
    ./neovim
    ./rofi
    ./thunderbird
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

  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;

    packages = with pkgs; [
      digikam
      fragments
      element-desktop
      libreoffice
      loupe
      gnome.seahorse
      gimp
      calibre
      vlc
      thunderbird
      keepassxc
      gnome.nautilus
      rofi-power-menu
      lollypop
      protonmail-bridge-ui

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

      # Scripts
      scripts.screenshot
      scripts.set-background
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
}

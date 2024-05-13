{ config, inputs, system, stateVersion, username, homeDirectory, pkgs, unstable
, ... }:
let scripts = import ./scripts { inherit pkgs; };
in {
  imports = [
    ./firefox
    ./fish
    #./sway
    ./neovim
    ./rofi
    #./thunderbird
  ];

  xdg.configFile."gtk-4.0/gtk.css".source =
    "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Blue-Dark/gtk-4.0/gtk.css";
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
  qt.platformTheme = "gtk";

  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;

    packages = with pkgs; [
      digikam
      element-desktop
      libreoffice
      loupe
      gnome.seahorse
      gimp
      calibre
      vlc
      thunderbird
      gnome.nautilus
      rofi-power-menu
      unstable.lollypop

      # Proprietary
      unstable.postman
      unstable.mongodb-compass

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

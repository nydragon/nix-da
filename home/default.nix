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
    ./vscodium
    ./themes/catppuccin.nix
  ];

  dconf = {
    enable = true;
    settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  services.blueman-applet.enable = true;

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
          signal-desktop
          calibre

          # Proprietary
          postman
          mongodb-compass
          obsidian

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
      scripts ++ pk;
  };
}

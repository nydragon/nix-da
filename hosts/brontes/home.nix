{
  pkgs,
  username,
  config,
  ...
}:
{
  home-manager.users.${username} = {
    imports = [
      ../../home/rofi
      ../../home/swaync
      ../../home/waybar
      ../../home/hyprlock
      ../../home/hyprpaper
      ../../home/themes/catppuccin.nix
      ../../home
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    services.blueman-applet.enable = true;

    home = {
      stateVersion = config.system.stateVersion;
      inherit username;

      packages = with pkgs; [
        keepassxc
        kdeconnect
        nextcloud-client
        cliphist
        digikam
        fragments
        element-desktop
        libreoffice
        loupe
        seahorse
        gimp
        vlc
        pavucontrol
        thunderbird
        keepassxc
        nautilus
        protonmail-bridge-gui
        varia
        signal-desktop
        calibre
        alacritty
        tagger
        soundconverter
        foliate
        kid3

        # proprietary
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
        wl-clipboard

        custom.scripts.nixedit
      ];
    };
  };
}

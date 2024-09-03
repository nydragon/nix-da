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

    programs = {
      waybar.enable = true;
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
        tagger
        soundconverter
        foliate
        kid3
        pulseview
        prismlauncher

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

        # custom
        nysh
        scripts.nixedit
        scripts.set-background
        scripts.fishl
        scripts.nrun
        scripts.rpaste
        scripts.genswitch
        scripts.gentest
        scripts.editsym
      ];
    };
  };
}

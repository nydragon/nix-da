{
  username,
  pkgs,
  config,
  ...
}:
{
  home-manager.users.${username} = {
    imports = [
      ../../home/sway
      ../../home/themes/catppuccin.nix
      ../../home
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

    programs = {
      waybar.enable = true;
      rofi.enable = true;
    };
    home = {
      stateVersion = config.system.stateVersion;
      inherit username;

      packages = with pkgs; [
        digikam
        fragments
        element-desktop
        libreoffice
        loupe
        seahorse
        gimp
        vlc
        thunderbird
        keepassxc
        nautilus
        protonmail-bridge-gui
        varia
        signal-desktop
        calibre
        pulseview
        foot

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
        wl-clipboard

        # custom
        nysh
        scripts.screenshot
        scripts.nixedit
        scripts.set-background
        scripts.rpaste
        scripts.nrun
        scripts.genswitch
        scripts.gentest
        scripts.editsym
      ];
    };
  };
}

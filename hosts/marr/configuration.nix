# vim:fileencoding=utf-8:foldmethod=marker
{
  config,
  pkgs,
  inputs,
  system,
  ...
}:
let
  stateVersion = "23.11";
  username = "nico";
  hostname = "marr";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-7adaa102-d438-4e9e-9972-4a3c91b887b3".device = "/dev/disk/by-uuid/7adaa102-d438-4e9e-9972-4a3c91b887b3";
  networking.hostName = hostname;

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.opengl.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    powerKey = "hibernate";
  };

  services.blueman.enable = true;
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1200
  '';

  xdg.mime = {
    enable = true;
    defaultApplications =
      let
        fileManager = "org.gnome.Nautilus.desktop";
        browser = "firefox.desktop";
      in
      {
        "inode/directory" = fileManager;
        "application/zip" = fileManager;
        "application/pdf" = browser;
        "x-www-browser" = browser;
        "text/html" = browser;
        "image/*" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
      };
  };

  home-manager.users.${username} = import ../../home {
    inherit
      config
      pkgs
      system
      inputs
      stateVersion
      username
      homeDirectory
      ;
  };

  programs.dconf.enable = true;

  #security.polkit.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.thermald.enable = true;

  services.tlp = {
    enable = false;
    settings = {
      #        CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      #        CPU_MIN_PERF_ON_AC = 0;
      #       CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr = {
      settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
      enable = true;
    };
    config.common.default = "*";
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.gvfs.enable = true;

  # Configure console keymap
  console.keyMap = "fr";
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users.${username} = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "libvirtd"
    ];
    shell = pkgs.fish;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.sway}/bin/sway";
        user = "${username}";
      };
      default_session = initial_session;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CURRENT_DESKTOP = "sway";
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    shared-mime-info
    fish
    nextcloud-client
    git
    firefox
    htop
    alacritty
    eza
    bat
    kdeconnect
    glib
    wireguard-tools
    dconf
    pavucontrol
    xdg-utils
    brightnessctl
  ];

  fonts = with pkgs; {
    packages = [
      (nerdfonts.override { fonts = [ "Noto" ]; })
      d2coding
      jigmo
      last-resort
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

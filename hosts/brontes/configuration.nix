{
  pkgs,
  inputs,
  username,
  hostname,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules
    ./home.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.hyprland}/bin/hyprland";
        user = "${username}";
      };
      default_session = initial_session;
    };
  };

  programs = {
    steam.enable = true;
    fish.enable = true;
    firefox.enable = true;
    thunderbird.enable = true;
    hyprland.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
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
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    fish
    git
    htop
    eza
    bat
    swaynotificationcenter
    pipewire
    wireplumber
  ];

  system.stateVersion = "24.05";
}

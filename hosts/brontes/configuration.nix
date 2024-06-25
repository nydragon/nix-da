{
  config,
  pkgs,
  lib,
  inputs,
  system,
  username,
  hostname,
  ...
}:
let
  stateVersion = "24.05";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  networking.hostName = hostname;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs = {
    steam.enable = true;
    fish.enable = true;
    firefox.enable = true;
    thunderbird.enable = true;
  };

  home-manager.users.${username} = {
    imports = [
      ../../home/firefox
      ../../home/fish
      ../../home/neovim
      ../../home/thunderbird
      ../../home/git
    ];

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
          scripts = import ../../home/scripts/list.nix { inherit pkgs; };
          programs = with pkgs; [
            keepassxc
            nextcloud-client
          ];
        in
        programs ++ scripts;
    };
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
  environment.systemPackages = with pkgs; [
    fish
    git
    firefox
    htop
    alacritty
    eza
    bat
    kdeconnect
  ];

  system.stateVersion = stateVersion;
}

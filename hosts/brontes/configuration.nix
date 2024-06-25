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
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${username} = {
    imports = [
      ../../home/firefox
      ../../home/fish
      ../../home/neovim
      ../../home/thunderbird
      ../../home/git
      ../../home/rofi
      ../../home/sway/swaync
      ../../home/sway/waybar
      ../../home/hyprland
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
            cliphist
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
    swaynotificationcenter
  ];

  system.stateVersion = stateVersion;
}

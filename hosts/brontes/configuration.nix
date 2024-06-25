{

}:
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
  stateVersion = "23.11";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules
  ];

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
}

{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.programs.steam.enable {
  programs.steam = {
    gamescopeSession.enable = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}

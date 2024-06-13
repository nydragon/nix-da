{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.steam = lib.mkIf config.programs.steam.enable {
    gamescopeSession.enable = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}

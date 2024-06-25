{ ... }:
{
  imports = [
    ./locale.nix
    ./networking.nix
    ./fonts.nix
    ./nix
    ./programs/firefox.nix
    ./programs/thunderbird.nix
    ./programs/sway.nix
    ./programs/lazygit.nix
    ./programs/steam.nix
  ];
}

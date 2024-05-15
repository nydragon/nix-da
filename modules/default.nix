{ ... }:
{
  imports = [
    ./locale.nix
    ./networking.nix
    ./nix
    ./programs/firefox.nix
    ./programs/sway.nix
  ];
}

{ ... }:
{
  imports = [
    ./locale.nix
    ./networking.nix
    ./nix
    ./programs/firefox.nix
    ./programs/thunderbird.nix
    ./programs/sway.nix
    ./programs/lazygit.nix
  ];
}

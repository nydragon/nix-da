{ ... }:
{
  imports = [
    ./sddm.nix
    ./locale.nix
    ./networking.nix
    ./fonts.nix
    ./nix
    ./programs/firefox.nix
    ./programs/thunderbird.nix
    ./programs/sway.nix
    ./programs/lazygit.nix
    ./programs/steam.nix
    ./programs/hyprland.nix
    ./programs/ssh.nix
    ./home-manager.nix
    ./system/mime.nix
    ./env.nix
    ./system/printing.nix
    ./system/audio.nix
    ./secrets.nix
    ./portals.nix
    ./themes
  ];
}

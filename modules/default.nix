{ pkgs, config, lib, ... }: {
  imports = [ ./locale.nix ./networking.nix ./nix ./programs/firefox.nix ];
}

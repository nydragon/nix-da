{ pkgs, config, lib, ... }: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}

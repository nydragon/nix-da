{ ... }:
{
  imports = [ ./overlays.nix ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
      # Catch up on missed runs due to being powered off
      persistent = true;
    };
    #Deduplicate identical files in the store regularly
    optimise = {
      automatic = true;
    };
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}

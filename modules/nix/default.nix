{ ... }:
{

  imports = [
    ./nixpkgs.nix
    ./overlays.nix
  ];

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
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}

{ self, pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${self}/assets/wallpapers/nix-flake-pastel.jpg";
      loginBackground = true;
    })
  ];
}

{ self, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings =
      let
        wp = "${self}/assets/wallpapers/nix-flake-pastel.jpg";
      in
      {
        ipc = "on";
        preload = [ "${wp}" ];
        wallpaper = [ ",${wp}" ];
      };
  };
}

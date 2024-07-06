{
  services.hyprpaper = {
    enable = true;
    settings =
      let
        wp = ./wallpaper.jpg;
      in

      {
        ipc = "on";
        preload = [ "${wp}" ];
        wallpaper = [ ",${wp}" ];
      };
  };
}

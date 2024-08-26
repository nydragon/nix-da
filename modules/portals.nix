{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.xdg.portal.enabme {
  xdg.portal = {
    config = {
      sway = {
        "org.freedesktop.impl.portal.Screenshot.PickColor" = [ "hyprpicker" ];
      };
      common.default = "*";
    };

    # gtk portal needed to make gtk apps happy
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

}

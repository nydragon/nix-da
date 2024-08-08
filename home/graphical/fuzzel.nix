{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        icon-theme = "Papirus-Dark";
        width = 25;
        font = "Hack:weight=bold";
        line-height = 30;
        fields = "name,generic,comment";
        terminal = "${pkgs.foot}/bin/foot -e";
        prompt = "❯   ";
        layer = "overlay";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };
      border = {
        radius = 20;
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };

}

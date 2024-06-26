{ lib, ... }:
let
  enable = true;
  swayncFolder = ".config/swaync";
  themes = import ./themes;
in
{

  home.file =
    {
      swaync-config = {
        inherit enable;
        target = "${swayncFolder}/config.json";
        text = builtins.toJSON (import ./config.nix);
      };

      swaync-theme = {
        inherit enable;
        target = "${swayncFolder}/style.css";
        text = themes.gruvbox;
      };
    }
    // lib.mapAttrs' (
      name: value:
      lib.nameValuePair "swaync-theme-${name}" {
        inherit enable;
        target = "${swayncFolder}/${name}.css";
        text = value;
      }
    ) themes;
}

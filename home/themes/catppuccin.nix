{ pkgs, ... }:
let
  validatePath =
    s: if (builtins.pathExists s) then (builtins.baseNameOf s) else throw "${s} does not exist";
in
rec {
  qt.platformTheme.name = "gtk";

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = rec {
      name = validatePath "${package}/share/themes/catppuccin-frappe-lavender-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        variant = "frappe";
      };
    };
    iconTheme = rec {
      name = validatePath "${package}/share/icons/Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
        flavor = "frappe";
      };
    };
    cursorTheme = with home.pointerCursor; {
      inherit name package size;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-frappe-lavender-cursors";
    package = pkgs.catppuccin-cursors.frappeLavender;
    size = 32;
  };
}

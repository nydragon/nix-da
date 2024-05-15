{ pkgs, ... }:

let
  pointer = {
    name = "Catppuccin-Frappe-Lavender-Cursors";
    package = pkgs.catppuccin-cursors.frappeLavender;
    size = 32;
  };
in
{
  programs.swaylock = {
    enable = true;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Compact-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        variant = "frappe";
      };
    };
    cursorTheme = pointer;
    iconTheme = {
      name = "Papirus-Dark";
      #   package = pkgs.papirus-icon-theme;
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
        flavor = "frappe";
      };
    };
  };
}

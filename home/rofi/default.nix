{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.rofi =
    let
      conf = "${config.home.homeDirectory}/.config/rofi";
    in
    rec {
      package = pkgs.rofi-wayland.override { inherit plugins; };
      enable = true;
      plugins = [ pkgs.rofi-calc ];
      theme = "${conf}/themes/rounded-gray-dark.rasi";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      extraConfig = {
        modes = [
          "combi"
          "filebrowser"
          "ssh"
          "drun"
          "run"
          # WARNING: ABI version mismatch
          # "calc"
          "clipboard:${lib.my.checkPath pkgs.cliphist "cliphist-rofi-img"}"
          "obsidian:${lib.my.checkPath pkgs.rofi-obsidian "rofi-obsidian"}"
        ];
        matching = "fuzzy";
        sort = true;
        sorting-method = "fzf";
        show-icons = true;
        steal-focus = true;
        drun-use-desktop-cache = true;
        drun-reload-desktop-cache = true;
        combi-modes = [
          "window"
          "drun"
          "obsidian"
        ];
      };
    };
}

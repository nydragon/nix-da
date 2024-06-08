{ pkgs, config, ... }:
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
          # TODO: Update to use nixpkgs version of cliphist
          "clipboard:cliphist-rofi-img"
          "obsidian:${pkgs.rofi-obsidian}/bin/rofi-obsidian"
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

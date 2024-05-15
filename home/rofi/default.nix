{ pkgs, config, ... }:
{
  programs.rofi =
    let
      conf = "${config.home.homeDirectory}/.config/rofi";
    in
    {
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
          "calc"
          "vm:${conf}/scripts/libvirt-controller.py"
          "obsidian:rofi-obsidian"
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
          "filebrowser"
          "ssh"
          "calc"
          "obsidian"
        ];
      };
    };
}

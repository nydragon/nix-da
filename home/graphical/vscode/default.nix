{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.programs.vscode.enable {
  programs.vscode = {
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      #ms-vscode.atom-keybindings
      #akamud.vscode-theme-onedark
    ];
    userSettings = {
      "update.mode" = "none";
      "idf.espIdfPath" = "/home/nico/esp/v5.2.2/esp-idf";
    };
  };
}

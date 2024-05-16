{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Nydragon";
    userEmail = "contact@ccnlc.eu";
    signing = {
      key = "25FF8464F0627EC001296A4314AA30A865EA1209";
      signByDefault = true;
    };
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "${pkgs.neovim}/bin/nvim";
      };
      init = {
        defaultBranch = "master";
      };
      #interactive = {
      #diffFilter = "delta --color-only";
      #};
      #delta = {
      #navigate = true;
      #};
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
    delta.enable = true;
  };
}

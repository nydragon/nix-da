{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Nydragon";
    userEmail = "contact@ccnlc.eu";
    extraConfig = {
      gpg.format = "ssh";
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
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      user = {
        signingKey = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0cON0May+E0KkDrmiHRo5O4uAAVw6dvqYKGsALybUJ";
      };
    };
    delta.enable = true;
  };
}

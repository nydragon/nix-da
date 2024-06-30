{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      clip = "wl-copy";
      dp = "env --chdir ~/.dotfiles/ ${pkgs.dotter}/bin/dotter deploy -v";
      l = "eza -laa";
      ls = "eza -la";
      ll = "eza -l";
      cat = "bat";
      sd = ''cd "$(dirname "$HOME/$(env --chdir ~ fzf)")"'';
      mkdir = "mkdir --parent";
      cp = "cp -i";
      mv = "mv -i";
    };
    functions =
      let
        rf = builtins.readFile;
      in
      {
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
        nrun = "nix run nixpkgs#$argv[1] -- $argv[2..]";
        mv-bad-creation-date = ''exiftool -if 'not $CreateDate' -p '$FileName' "$PWD/$argv[1]" | xargs -I {} mv -i "$PWD/$argv[1]/{}" "$argv[2]"'';
        rename-images = rf ./rename_images.fish;
        fish_prompt = rf ./fish_prompt.fish;
        rebuild = ''
          env --chdir $HOME/.nixconf sudo nixos-rebuild switch --flake .#$(hostname) \
          && ${pkgs.libnotify}/bin/notify-send nixos-rebuild "Rebuild complete" \
              -a nixos-rebuild \
              -i ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg
        '';
      };
  };
}

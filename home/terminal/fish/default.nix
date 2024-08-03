{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      clip = "wl-copy";
      l = "eza -laa";
      ls = "eza -la";
      ll = "eza -l";
      cat = "bat";
      sd = ''cd "$(dirname "$HOME/$(env --chdir ~ fzf)")"'';
      mkdir = "mkdir --parent";
      cp = "cp -i";
      mv = "mv -i";
    };
    functions = rec {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      nrun = "nix run nixpkgs#$argv[1] -- $argv[2..]";
      nrunb = "${nrun} & disown";
      mv-bad-creation-date = ''
        ${lib.my.checkPath pkgs.exiftool "exiftool"} -if 'not $CreateDate' -p '$FileName' "$PWD/$argv[1]" | xargs -I {} mv -i "$PWD/$argv[1]/{}" "$argv[2]"
      '';
      rename-images = ''
        set -f input "$PWD/$argv[1]"

        if not test -d $input
            echo "input is not a directory"
        else
            ${lib.my.checkPath pkgs.exiftool "exiftool"} -if '$CreateDate' -p '$FileName' "$input" | xargs -I {} jhead -n%Y-%m-%d-%H%M%S "$input/{}"
        end
      '';
      fish_prompt = builtins.readFile ./fish_prompt.fish;
      rebuild = ''
        env --chdir $HOME/.nixconf sudo nixos-rebuild switch --flake .#$(hostname) \
        && ${lib.my.checkPath pkgs.libnotify "notify-send"} nixos-rebuild "Rebuild complete" \
            -a nixos-rebuild \
            -i ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg
      '';
      revert = ''
        env --chdir $HOME/.nixconf sudo nixos-rebuild switch --flake .#$(hostname) --rollback
      '';
    };
  };
}

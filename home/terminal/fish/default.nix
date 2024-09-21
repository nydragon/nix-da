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
      cp = "cp -vi";
      mv = "mv -vi";
      rm = "rm -v";
    };
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
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
      revert = ''
        env --chdir $HOME/.nixconf sudo nixos-rebuild switch --flake .#$(hostname) --rollback
      '';
    };
  };
}

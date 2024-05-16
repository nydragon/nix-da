{ ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      clip = "wl-copy";
      dp = "env --chdir ~/.dotfiles/ dotter deploy -v";
      l = "eza -laa";
      ls = "eza -la";
      ll = "eza -l";
      cat = "bat";
      sd = ''cd "$(dirname "$HOME/$(env --chdir ~ fzf)")"'';
      mkdir = "mkdir --parent";
    };
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      nrun = "nix run nixpkgs#$argv[1] -- $argv[2..]";
      mv-bad-creation-date = ''exiftool -if 'not $CreateDate' -p '$FileName' "$PWD/$argv[1]" | xargs -I {} mv -i "$PWD/$argv[1]/{}" "$argv[2]"'';
      rename-images = ''
        set -f input "$PWD/$argv[1]"

        if not test -d $input
        echo "input is not a direcotry"
        else
        exiftool -if '$CreateDate' -p '$FileName' "$input" | xargs -I {} jhead -n%Y-%m-%d-%H%M%S "$input/{}"
        end
      '';
      fish_prompt = builtins.readFile ./fish_prompt.fish;
    };
  };
}

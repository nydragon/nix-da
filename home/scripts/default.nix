{ pkgs, ... }:
{
  screenshot =
    with pkgs;
    writeShellApplication {
      name = "screenshot";
      runtimeInputs = [
        slurp
        wl-clipboard
        libnotify
      ];
      text = ''
        location="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d-%H%M%S)-screenshot.png";

        if zone=$(slurp); then
        grim -t png -g "$zone" - | wl-copy --type image/png && wl-paste > "$location" \
        && notify-send --app-name Screenshot -i "$location" --urgency=low "Screenshot copied to clipboard" "Screenshot created at $location";
        fi
      '';
    };

  set-background = pkgs.writers.writeFishBin "set-background" ''
    argparse 'f/file=!test -e "$_flag_value"' -- $argv; or return

    set pids $(pidof swaybg)

    if set -q _flag_file
      ${pkgs.swaybg}/bin/swaybg -i "$(find $_flag_file | shuf -n 1)" > /dev/null 2>&1 &
    else
      ${pkgs.swaybg}/bin/swaybg -i "$(find ~/Pictures/backgrounds | shuf -n 1)" > /dev/null 2>&1 &
    end

    sleep 0.5;

    for i in $(string split " " $pids)
      echo "killing process $i";
      kill -9 "$i";
    end
  '';

  nixedit = pkgs.writers.writeFishBin "nixedit" "env --chdir ~/.nixconf $EDITOR .";

  getext = pkgs.writeScriptBin "ls | grep -E \"\.[a-zA-Z0-9]+$\" --only-matching  | sort | uniq";

  fishl = pkgs.writers.writeFishBin "fishl" ./logo.fish;
}

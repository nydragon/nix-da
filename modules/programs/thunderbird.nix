{ lib, config, ... }:
{
  programs.thunderbird = lib.mkIf config.programs.thunderbird.enable {
    preferencesStatus = "locked";
    preferences = {
      "mail.biff.play_sound" = false;
      "mail.chat.play_sound" = false;
    };
  };
}

{ lib, config, ... }:
lib.mkIf config.programs.thunderbird.enable {
  programs.thunderbird = {
    preferencesStatus = "locked";
    preferences = {
      "mail.biff.play_sound" = false;
      "mail.chat.play_sound" = false;
      "mail.pane_config.dynamic" = 2;
    };
  };
}

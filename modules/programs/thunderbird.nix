{ ... }:
{
  programs.thunderbird = {
    enable = true;
    preferencesStatus = "locked";
    preferences = {
      "mail.biff.play_sound" = false;
      "mail.chat.play_sound" = false;
    };
  };
}

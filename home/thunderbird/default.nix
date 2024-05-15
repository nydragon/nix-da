{ ... }:
{
  programs.thunderbird = {
    enable = true;
    settings = {
      "mailnews.wraplength" = 80;
      "mail.pane_config.dynamic" = 2;
      "mail.biff.play_sound" = false;
      "mail.chat.play_sound" = false;
    };
    profiles.nico = {
      isDefault = true;
    };
  };
}

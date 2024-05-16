{ ... }:
{
  programs.thunderbird = {
    enable = true;
    settings = {
      "mailnews.wraplength" = 80;
      "mail.pane_config.dynamic" = 2;
      "mail.biff.play_sound" = false;
      "mail.chat.play_sound" = false;
      # Never allow cookies
      "network.cookie.cookieBehavior" = 2;
      "mailnews.start_page.enabled" = false;
      # Date descending
      "mailnews.default_sort_order" = 2;
    };
    profiles.nico = {
      isDefault = true;
    };
  };
}

{ ... }:
{
  programs.thunderbird = {
    enable = true;
    #settings = { mailnews.wraplength = 80; };
    profiles.nico = {
      isDefault = true;
    };
  };
}

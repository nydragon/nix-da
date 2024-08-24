{
  programs.fastfetch.enable = true;
  programs.hyfetch = {
    enable = true;
    settings = {
      mode = "rgb"; # dunno the other value :sob:
      lightness = 0.7; # u may change this
      distro = "nixos";
      preset = "pansexual"; # sexuality
      light_dark = "dark"; # u not crazy are u
      backend = "fastfetch";
      color_align.mode = "horizontal"; # looks better
    };
  };
}

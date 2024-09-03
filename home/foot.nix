{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "NotoSansM Nerd Font Mono:size=13";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors = {
        alpha = 0.8;
      };

      scrollback = {
        indicator-position = "none";
      };
    };
  };
}

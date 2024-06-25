{ pkgs, ... }:
{
  fonts = with pkgs; {
    packages = [
      (nerdfonts.override { fonts = [ "Noto" ]; })
      d2coding
      jigmo
      last-resort
    ];
  };
}

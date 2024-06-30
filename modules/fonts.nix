{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Noto" ]; })
      d2coding
      jigmo
      last-resort
    ];
  };
}

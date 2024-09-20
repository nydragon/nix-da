{
  inputs,
  config,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      # Add env vars to calibre so they may get propagated to a plugin that needs them
      calibre = prev.calibre.overrideAttrs (old: {
        postInstall = ''
          wrapProgram $out/bin/calibre \
              --set QT_QPA_PLATFORM xcb \
              --set-default ACSM_LIBCRYPTO ${prev.openssl.out}/lib/libcrypto.so \
              --set-default ACSM_LIBSSL ${prev.openssl.out}/lib/libssl.so
        '';
      });

      lollypop = prev.lollypop.override {
        #lastFMSupport = false;
        youtubeSupport = false;
      };

      scripts = import ../../home/scripts {
        inherit lib config;
        pkgs = prev.pkgs;
      };

      rofi-obsidian = inputs.rofi-obsidian.outputs.packages.${prev.pkgs.system}.rofi-obsidian;
      nysh = inputs.nysh.defaultPackage.${prev.pkgs.system};

      hyprland = inputs.hyprland.packages.${prev.pkgs.system}.hyprland;

      xdg-desktop-portal-hyprland =
        inputs.hyprland.packages.${prev.pkgs.system}.xdg-desktop-portal-hyprland;
    })
  ];
}

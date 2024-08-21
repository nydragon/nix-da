{
  inputs,
  config,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    # Add env vars to calibre so they may get propagated to a plugin that needs them
    (final: prev: {
      calibre = prev.calibre.overrideAttrs (old: {
        postInstall = ''
          wrapProgram $out/bin/calibre \
              --set QT_QPA_PLATFORM xcb \
              --set-default ACSM_LIBCRYPTO ${prev.openssl.out}/lib/libcrypto.so \
              --set-default ACSM_LIBSSL ${prev.openssl.out}/lib/libssl.so
        '';
      });
    })

    (final: prev: {
      lollypop = prev.lollypop.override {
        #lastFMSupport = false;
        youtubeSupport = false;
      };
    })

    (final: prev: {
      scripts = import ../../home/scripts {
        inherit lib config;
        pkgs = prev.pkgs;
      };
    })

    (final: prev: {
      rofi-obsidian = inputs.rofi-obsidian.outputs.packages.${prev.pkgs.system}.rofi-obsidian;
    })
  ];
}

{
  calibre = final: prev: {
    calibre = prev.calibre.overrideAttrs (old: {
      postInstall = ''
        wrapProgram $out/bin/calibre \
            --set QT_QPA_PLATFORM xcb \
            --set-default ACSM_LIBCRYPTO ${prev.openssl.out}/lib/libcrypto.so \
            --set-default ACSM_LIBSSL ${prev.openssl.out}/lib/libssl.so
      '';
    });
  };
}

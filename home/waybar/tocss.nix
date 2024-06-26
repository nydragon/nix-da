{ pkgs, file, ... }:
pkgs.stdenv.mkDerivation {
  name = "toCSS";
  buildCommand = ''
    ${pkgs.sass}/bin/scss ${file} $out
  '';
}

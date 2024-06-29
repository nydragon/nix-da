{ pkgs, ... }:
{
  environment.sessionVariables = {
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };
}

{ pkgs, ... }:
with import ./. { inherit pkgs; };
[
  screenshot
  set-background
  nixedit
]

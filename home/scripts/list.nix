{ pkgs, ... }: builtins.attrValues (import ./. { inherit pkgs; })

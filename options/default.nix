{ lib, ... }:
{
  options.custom.pubKey = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
}

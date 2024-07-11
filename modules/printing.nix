{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.services.printing.enable {
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.printing = {
    drivers = with pkgs; [ hplip ];
  };
}

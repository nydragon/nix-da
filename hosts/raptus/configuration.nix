{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./docker-compose.nix
    ../../modules/nix
  ];

  age.secrets.couchdb.file = ../../secrets/couchdb.age;

  device.type = {
    vm.enable = true;
    server.enable = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.firewall = lib.mkForce {
    enable = true;
    allowedTCPPorts = [
      80
      22
      5984 # couchdb
    ];
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."rusty.ccnlc.eu" = {
      # TODO: Enable https

      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;'';
      };
    };
  };

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvPqWPXEUOSMGMIRmirQfbrzq//NkPlEI2TmFpIkSfw" # brontes
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwlScEmVbdc0EH93XLX+K8yP5FKUKzMf/bWTSO+rMiO" # marr
  ];

  system.stateVersion = "24.11";
}

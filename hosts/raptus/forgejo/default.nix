{ lib, pkgs, ... }:
{
  # Containers
  virtualisation.oci-containers.containers."forgejo" = {
    image = "codeberg.org/forgejo/forgejo:7";
    environment = {
      "USER_GID" = "1000";
      "USER_UID" = "1000";
    };
    volumes = [
      #"/etc/localtime:/etc/localtime:ro"
      #"/etc/timezone:/etc/timezone:ro"
      "test_forgejo:/data:rw"
      "${./app.ini}:/data/gitea/app.ini:ro"
    ];
    ports = [
      "3000:3000/tcp"
      "222:22/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=server"
      "--network=test_forgejo"
    ];
  };
  systemd.services."podman-forgejo" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
    };
    after = [ "podman-network-test_forgejo.service" ];
    requires = [ "podman-network-test_forgejo.service" ];
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

  # Networks
  systemd.services."podman-network-test_forgejo" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f test_forgejo";
    };
    script = ''
      podman network inspect test_forgejo || podman network create test_forgejo
    '';
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

  # Volumes
  systemd.services."podman-volume-test_forgejo" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect test_forgejo || podman volume create test_forgejo
    '';
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

}

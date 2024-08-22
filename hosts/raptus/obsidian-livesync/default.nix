{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.oci-containers.containers."obsidian-livesync" = {
    image = "couchdb";
    environmentFiles = [ config.age.secrets.couchdb.path ];
    volumes = [
      "${./local.ini}:/opt/couchdb/etc/local.ini:rw"
      "test_dbdata:/opt/couchdb/data:rw"
    ];
    ports = [ "5984:5984/tcp" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=couchserver"
      "--network=test_default"
    ];
  };
  systemd.services."podman-obsidian-livesync" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
    };
    after = [
      "podman-network-test_default.service"
      "podman-volume-test_dbdata.service"
    ];
    requires = [
      "podman-network-test_default.service"
      "podman-volume-test_dbdata.service"
    ];
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

  # Volumes
  systemd.services."podman-volume-test_dbdata" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect test_dbdata || podman volume create test_dbdata
    '';
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

}

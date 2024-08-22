{
  pkgs,
  config,
  lib,
  ...
}:
{
  virtualisation.oci-containers.containers."rustypaste" = {
    image = "orhunp/rustypaste:latest";
    environment = {
      "RUST_LOG" = "debug";
    };
    environmentFiles = [ config.age.secrets.rustypaste.path ];
    volumes = [
      "${(pkgs.formats.toml { }).generate "conf" (import ./conf.nix)}:/app/config.toml:ro"
      "test_rustypaste-data:/app/upload:rw"
    ];
    ports = [ "8000:8000/tcp" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=rustypaste"
      "--network=test_default"
    ];
  };
  systemd.services."podman-rustypaste" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
    };
    after = [
      "podman-network-test_default.service"
      "podman-volume-test_rustypaste-data.service"
    ];
    requires = [
      "podman-network-test_default.service"
      "podman-volume-test_rustypaste-data.service"
    ];
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };

  systemd.services."podman-volume-test_rustypaste-data" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect test_rustypaste-data || podman volume create test_rustypaste-data
    '';
    partOf = [ "podman-compose-test-root.target" ];
    wantedBy = [ "podman-compose-test-root.target" ];
  };
}

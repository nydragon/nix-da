let
  raptus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdpjGR/pV1roktZdKIVVWqds0JB+x1ksfyQmYPMLK7o";
  marr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMh2nUUKt3xsKiwZUuo6HgvR3lr7rRAl0SOH/502sFP";
  brontes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICgknH3OPazZNhH5xkYfXBcYpI3TXj/eRp0/zzjtVJBf";

  devices = [
    marr
    raptus
    brontes
  ];
in
{
  "couchdb.age".publicKeys = devices;
  "rustypaste.age".publicKeys = devices;
}

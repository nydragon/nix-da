let
  userBrontes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvPqWPXEUOSMGMIRmirQfbrzq//NkPlEI2TmFpIkSfw";

  userMarr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwlScEmVbdc0EH93XLX+K8yP5FKUKzMf/bWTSO+rMiO";

  users = [
    userMarr
    userBrontes
  ];

  raptus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdpjGR/pV1roktZdKIVVWqds0JB+x1ksfyQmYPMLK7o";
in
{
  "couchdb.age".publicKeys = [ raptus ] ++ users;
  "rustypaste.age".publicKeys = [ raptus ] ++ users;
}

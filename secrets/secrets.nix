let
  userBrontes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvPqWPXEUOSMGMIRmirQfbrzq//NkPlEI2TmFpIkSfw";

  userMarr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwlScEmVbdc0EH93XLX+K8yP5FKUKzMf/bWTSO+rMiO";

  users = [
    userMarr
    userBrontes
  ];

  raptus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErbhkpCL0DuJQTxeTqxtrGvELCQFkyZmhTZ8fagszOU";
  systems = [ raptus ];
in
{
  "couchdb.age".publicKeys = [ raptus ] ++ users;
}

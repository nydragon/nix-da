{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    matchBlocks = {
      "deck" = {
        hostname = "steamdeck";
        user = "deck";
        port = 22;
      };
    };
  };
}

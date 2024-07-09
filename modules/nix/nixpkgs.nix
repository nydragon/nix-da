{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      custom = {
        scripts = import ../../home/scripts { inherit pkgs; };
      };
    };
  };
}

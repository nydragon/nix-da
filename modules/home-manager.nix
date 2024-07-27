{ self, ... }:
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit self;
    };
    verbose = true;
  };
}

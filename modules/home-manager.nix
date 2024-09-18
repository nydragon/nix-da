{ self, inputs, ... }:
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit self inputs;
    };
    verbose = true;
  };
}

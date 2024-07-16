{ inputs, ... }@args:
{
  flake.lib = inputs.nixpkgs.lib.extend (
    self: super: {
      my = import ./functions.nix {
        lib = self;
        inherit inputs;
        self = args.self;
      };
    }
  );
}

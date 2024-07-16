{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        pname = manifest.name;

        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };

        rustVersion = pkgs.rust-bin.stable.latest.default;

        rustPlatform = pkgs.makeRustPlatform {
          cargo = rustVersion;
          rustc = rustVersion;
        };

        rustBuild = rustPlatform.buildRustPackage {
          inherit pname;
          version = manifest.version;
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;

          meta = {
            description = manifest.description;
            #license = nixpkgs.lib.licenses.unlicense;
            maintainers = [ ];
          };
        };
      in
      {
        packages = {
          ${pname} = rustBuild;
          default = self.packages.${pname};
        };

        devShell = pkgs.mkShell {
          buildInputs = [ (rustVersion.override { extensions = [ "rust-src" ]; }) ];

          shellHook = '''';
        };
      }
    );
}

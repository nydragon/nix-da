rec {
  basic = {
    path = ./basic;
    description = "A basic template";
    welcomeText = ''
      # A basic flake

      ## More Info
      - [Nix Reference Manual](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake)
    '';
  };

  rust = {
    path = ./rust;
    description = "A basic rust cargo template";
    welcomeText = ''
      # A basic rust cargo template

      Maybe consider setting a license in ./flake.nix

      ## More Info
      - [Rust language](https://www.rust-lang.org/) - https://www.rust-lang.org/
      - [Rust on the NixOS Wiki](https://nixos.wiki/wiki/Rust) - https://nixos.wiki/wiki/Rust
    '';
  };

  defaultTemplate = basic;
}

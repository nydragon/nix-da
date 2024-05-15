{ pkgs, ... }:
{
  programs.neovim =
    let
      customR = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          styler
          languageserver
        ];
      };
    in
    {
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      enable = true;
      withPython3 = false;
      withRuby = false;
      extraPackages = with pkgs; [
        # Language Servers
        rust-analyzer
        nixd
        clang
        nodePackages_latest.pyright
        nodePackages_latest.bash-language-server
        lua-language-server
        zls
        #rPackages.languageserver

        # Formatter
        python311Packages.black # Python formatter
        #rPackages.styler # R formatter
        nodePackages_latest.prettier # JSON, JS, TS formatter
        yamlfmt # YAML formatter
        taplo # TOML formatter
        rustfmt # Rust formatter
        shfmt # Shell, Bash etc.
        nixfmt-rfc-style
        # Misc
        ripgrep
        rustc
        cargo

        # R
        customR
      ];
    };
}

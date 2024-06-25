{ pkgs, ... }:
{
  programs.neovim = {
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
      pyright
      bash-language-server
      lua-language-server
      zls
      #rPackages.languageserver

      # Formatter
      python311Packages.black # Python formatter
      #rPackages.styler # R formatter
      clang-tools
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
      nodejs_22
      clang
      tree-sitter
      fd
      luajitPackages.luarocks
      wl-clipboard
    ];
  };
}

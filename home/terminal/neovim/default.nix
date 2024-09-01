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
      lua

      # Language Servers
      rust-analyzer
      #nixd
      nil
      pyright
      bash-language-server
      lua-language-server
      zls
      typescript
      nodePackages_latest.typescript-language-server

      kdePackages.qtdeclarative # QML formatter

      # Formatter
      python311Packages.black # Python formatter
      clang-tools
      nodePackages_latest.prettier # JSON, JS, TS formatter
      yamlfmt # YAML formatter
      taplo # TOML formatter
      rustfmt # Rust formatter
      shfmt # Shell, Bash etc.
      nixfmt-rfc-style
      stylua # lua formatter

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

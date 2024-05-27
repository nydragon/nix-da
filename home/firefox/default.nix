{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.nico = {
      name = "Nico";
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        force = true;
        engines =
          let
            nixicon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            iconUpdateInterval = 24 * 60 * 60 * 1000; # every day
          in
          {
            "NixOS Packages" = {
              urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
              icon = nixicon;
              definedAliases = [ "@nixpkg" ];
            };
            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
              icon = nixicon;
              definedAliases = [ "@nixwiki" ];
            };
            "NixOS Options" = {
              urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
              icon = nixicon;
              definedAliases = [ "@nixoptions" ];
            };
            "Arch Wiki" = {
              urls = [
                { template = "https://wiki.archlinux.org/index.php?title=Special:Search&search={searchTerms}"; }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.ico";
              updateInterval = iconUpdateInterval;
              definedAliases = [ "@archwiki" ];
            };
            "DuckDuckGo" = {
              urls = [ { template = "https://duckduckgo.com/?q={searchTerms}"; } ];
              iconUpdateURL = "https://duckduckgo.com/favicon.ico";
              updateInterval = iconUpdateInterval;
              definedAliases = [
                "@duckduckgo"
                "@ddg"
              ];
            };
            "MyNixOS" = {
              urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://mynixos.com/favicon.ico";
              updateInterval = iconUpdateInterval;
              definedAliases = [
                "@hm"
                "@mynixos"
              ];
            };
            "stackoverflow" = {
              urls = [ { template = "https://stackoverflow.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://cdn.sstatic.net/Sites/stackoverflow/Img/favicon.ico";
              updateInterval = iconUpdateInterval;
              definedAliases = [ "@stackoverflow" ];
            };
          };
      };
    };
  };
}

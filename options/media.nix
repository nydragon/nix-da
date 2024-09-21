{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.media;
  mkMedia = defPackages: {
    enable = lib.mkOption { default = cfg.enableAll; };
    packages = lib.mkOption { default = defPackages; };
  };
in
{
  options.media = {
    enableAll = lib.mkEnableOption "";
    audio = mkMedia [
      pkgs.feishin
      pkgs.lollypop
    ];
    video = mkMedia [
      pkgs.vlc
    ];
    ebook = mkMedia [
      pkgs.calibre
      pkgs.foliate
    ];
  };

  config = {
    environment.systemPackages = lib.flatten (
      lib.map (opt: opt.packages) (
        lib.filter (opt: opt.enable) [
          cfg.audio
          cfg.video
          cfg.ebook
        ]
      )
    );
  };
}

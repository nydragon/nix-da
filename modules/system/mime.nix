{
  xdg.mime = {
    enable = true;
    defaultApplications =
      let
        fileManager = "org.gnome.Nautilus.desktop";
        browser = "firefox.desktop";
      in
      {
        "inode/directory" = fileManager;
        "application/zip" = fileManager;
        "application/pdf" = browser;
        "x-www-browser" = browser;
        "text/html" = browser;
        "application/vnd.comicbook+zip" = "com.github.johnfactotum.Foliate.desktop";
        "application/epub+zip" = "com.github.johnfactotum.Foliate.desktop";
        "image/*" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
      };
  };
}

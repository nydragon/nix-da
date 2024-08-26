{
  config = {
    refresh_rate = "1s";
  };
  server = {
    address = "127.0.0.1:8000";
    url = "https://rusty.ccnlc.eu";
    workers = 4;
    max_content_length = "50MB";
    upload_path = "./upload";
    timeout = "30s";
    expose_version = false;
    expose_list = false;
    handle_spaces = "replace";
  };
  landing_page = {
    text = ''
      ┬─┐┬ ┬┌─┐┌┬┐┬ ┬┌─┐┌─┐┌─┐┌┬┐┌─┐
      ├┬┘│ │└─┐ │ └┬┘├─┘├─┤└─┐ │ ├┤
      ┴└─└─┘└─┘ ┴  ┴ ┴  ┴ ┴└─┘ ┴ └─┘

      Submit files via HTTP POST here:
          curl -F 'file=@example.txt' <server>
      This will return the URL of the uploaded file.

      The server administrator might remove any pastes that they do not personally
      want to host.

      If you are the server administrator and want to change this page, just go
      into your config file and change it! If you change the expiry time, it is
      recommended that you do.

      By default, pastes expire every hour. The server admin may or may not have
      changed this.

      Check out the GitHub repository at https://github.com/orhun/rustypaste
      Command line tool is available  at https://github.com/orhun/rustypaste-cli
    '';
    content_type = "text/plain; charset=utf-8";
  };
  paste = {
    random_url = {
      type = "petname";
      words = 2;
      separator = "-";
    };
    default_extension = "txt";
    mime_override = [
      {
        mime = "image/jpeg";
        regex = "^.*\.jpg$";
      }
      {
        mime = "image/png";
        regex = "^.*\.png$";
      }
      {
        mime = "image/svg+xml";
        regex = "^.*\.svg$";
      }
      {
        mime = "video/webm";
        regex = "^.*\.webm$";
      }
      {
        mime = "video/x-matroska";
        regex = "^.*\.mkv$";
      }
      {
        mime = "application/octet-stream";
        regex = "^.*\.bin$";
      }
      {
        mime = "text/plain";
        regex = "^.*\.(log|txt|diff|sh|rs|toml)$";
      }
    ];
    mime_blacklist = [
      "application/x-dosexec"
      "application/java-archive"
      "application/java-vm"
    ];
    duplicate_files = false;
    default_expiry = "1h";
    delete_expired_files = {
      enabled = true;
      interval = "1h";
    };
  };
}
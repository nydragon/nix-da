{
  #"$schema" = "/etc/xdg/swaync/configSchema.json";
  control-center-height = 1025;
  control-center-margin-bottom = 10;
  control-center-margin-left = 10;
  control-center-margin-right = 10;
  control-center-margin-top = 10;
  control-center-width = 500;
  fit-to-screen = true;
  hide-on-action = true;
  hide-on-clear = false;
  image-visibility = "when-available";
  keyboard-shortcuts = true;
  notification-body-image-height = 100;
  notification-body-image-width = 200;
  notification-icon-size = 64;
  notification-visibility = {
    nextcloud = {
      desktop-entry = "com.nextcloud.desktopclient.nextcloud";
      state = "muted";
    };
  };
  notification-window-width = 500;
  positionX = "right";
  positionY = "top";
  script-fail-notify = true;
  timeout = 10;
  timeout-critical = 0;
  timeout-low = 5;
  transition-time = 200;
  widget-config = {
    backlight = {
      label = "󰃟";
    };
    dnd = {
      text = "Do Not Disturb";
    };
    label = {
      max-lines = 1;
      text = "Notification Center";
    };
    mpris = {
      image-radius = 7;
      image-size = 96;
    };
    title = {
      button-text = "Clear";
      clear-all-button = true;
      text = "Notifications";
    };
    volume = {
      label = "󰕾";
    };
  };
  widgets = [
    "dnd"
    "buttons-grid"
    "mpris"
    "volume"
    "backlight"
    "title"
    "notifications"
  ];
}

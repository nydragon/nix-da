{
  modules-left = [
    "tray"
    "privacy"
    "clock"
    "sway/mode"
  ];
  modules-center = [ "sway/workspaces" ];
  modules-right = [
    "backlight"
    "pulseaudio"
    "network"
    "group/hardware"
    "idle_inhibitor"
    "custom/notification"
  ];
  backlight = {
    format = "{}% ";
    interval = 1;
    on-scroll-down = "brightnessctl s 10%-";
    on-scroll-up = "brightnessctl s +10%";
    tooltip = false;
  };
  battery = {
    format = "{icon}   {capacity}%";
    format-charging = "   {capacity}%";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
    format-plugged = "   {capacity}%";
    states = {
      critical = 20;
      good = 95;
      warning = 30;
    };
  };
  clock = {
    actions = {
      on-click-backward = "tz_down";
      on-click-forward = "tz_up";
      on-click-right = "mode";
      on-scroll-down = "shift_down";
      on-scroll-up = "shift_up";
    };
    calendar = {
      format = {
        days = "<span color='#ecc6d9'><b>{}</b></span>";
        months = "<span color='#ffead3'><b>{}</b></span>";
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
      };
      mode = "year";
      mode-mon-col = 3;
      on-click-right = "mode";
      on-scroll = 1;
      weeks-pos = "right";
    };
    format = "{:%H:%M}";
    format-alt = "{:%A, %B %d, %Y (%R)}  ";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
  };
  cpu = {
    format = " {}%";
    interval = 15;
    max-length = 10;
  };
  "custom/notification" = {
    c-on-click-right = "swaync-client -d -sw";
    escape = true;
    exec = "swaync-client -swb";
    exec-if = "which swaync-client";
    format = "{icon}";
    format-icons =
      let
        dot = "<span foreground='red'><sup></sup></span>";
      in
      {
        dnd-inhibited-none = "";
        dnd-inhibited-notification = "${dot}";
        dnd-none = "";
        dnd-notification = "${dot}";
        inhibited-none = "";
        inhibited-notification = "${dot}";
        none = "";
        notification = "${dot}";
      };
    on-click = "sh -c 'sleep 0.1s; swaync-client -t -sw; sleep 0.1s'";
    return-type = "json";
    tooltip = false;
  };
  "group/hardware" = {
    drawer = {
      transition-left-to-right = false;
    };
    modules = [
      "battery"
      "cpu"
      "memory"
    ];
    orientation = "horizontal";
  };
  idle_inhibitor = {
    format = "{icon} ";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };
  layer = "bottom";
  memory = {
    format = " {}%";
    interval = 30;
    max-length = 10;
  };

  network = {
    format-wifi = "{essid} ({signalStrength}%) ";
    on-click = "alacritty -t nmtui -e nmtui";
  };
  position = "top";
  privacy = {
    icon-size = 18;
    icon-spacing = 4;
    modules = [
      {
        tooltip = true;
        tooltip-icon-size = 24;
        type = "screenshare";
      }
      {
        tooltip = true;
        tooltip-icon-size = 24;
        type = "audio-out";
      }
      {
        tooltip = true;
        tooltip-icon-size = 24;
        type = "audio-in";
      }
    ];
    transition-duration = 250;
  };
  pulseaudio = {
    format = "{volume}% {icon} {format_source}";
    format-bluetooth = "{volume}% {icon} {format_source}";
    format-bluetooth-muted = " {icon} {format_source}";
    format-icons = {
      car = "";
      default = [
        "奄"
        "奔"
        "墳"
      ];
      hands-free = "";
      headphone = "";
      headset = "";
      phone = "";
      portable = "";
    };
    format-muted = "婢 {format_source}";
    format-source = "{volume}% ";
    format-source-muted = "";
    on-click = "pavucontrol";
    scroll-step = 1;
    tooltip = false;
  };
  "sway/mode" = {
    format = "{}";
    max-length = 50;
  };
  "sway/workspaces" = {
    all-outputs = true;
    disable-scroll = true;
    format = "{name}";
  };
  tray = {
    icon-size = 18;
    show-passive-items = false;
    spacing = 10;
  };
}

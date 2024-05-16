''
  * {
    font-family: "DejaVuSansMNerdFont-Regular";
    border: none;
    opacity: 50;
    border-radius: 10px;
    font-size: 13px; }

  window#waybar {
    background: transparent; }

  window#waybar.hidden {
    opacity: 0.2; }

  #window {
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 10px;
    transition: none;
    color: transparent;
    background: transparent; }

  .modules-center {
    margin: 3px 0 0 0; }

  .modules-right {
    margin: 3px 8px 0 0; }

  .modules-left {
    margin: 3px 0 0 8px; }

  #workspaces {
    background-color: rgba(13, 214, 250, 0.4); }
    #workspaces button {
      padding: 1px 5px; }
    #workspaces button:hover {
      background-color: rgba(159, 255, 255, 0.9); }
    #workspaces button.focused {
      background-color: rgba(50, 194, 219, 0.7); }

  #network {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #bd93f9; }

  #pulseaudio {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    min-width: 23px;
    color: #1a1826;
    background: #fae3b0; }

  #backlight {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #f8bd96; }

  #clock {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #abe9b3; }

  #memory {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #ddb6f2; }

  #privacy {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #ddb6f2; }

  #cpu {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #96cdfb; }

  #tray {
    padding-left: 10px;
    margin-right: 4px;
    padding-right: 10px;
    border-radius: 10px;
    color: #b5e8e0;
    background: #161320; }

  #idle_inhibitor {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    font-size: 20px;
    color: #161320;
    background: #f28fad; }

  #group-power {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    font-size: 20px;
    transition: none;
    color: #161320;
    background: #f28fad; }

  #custom-notification {
    margin-left: 4px;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 10px;
    color: #161320;
    background: #f2cdcd;
    font-family: "NotoSansMono Nerd Font"; }

  #mode {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #ddb6f2; }

  @keyframes blink {
    to {
      background-color: #bf616a;
      color: #b5e8e0; } }

  #battery {
    margin-left: 4px;
    margin-right: 4px;
    border-radius: 10px;
    padding-left: 10px;
    padding-right: 10px;
    color: #161320;
    background: #b5e8e0; }
    #battery .critical:not(.charging) {
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate; }

''

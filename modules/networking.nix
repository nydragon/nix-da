{ ... }:
{
  networking = {
    wireless.iwd.enable = true;

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    firewall =
      let
        wgPort = 51820;
      in
      {
        enable = true;

        # Open ports in the firewall.
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ wgPort ];
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];

        # if packets are still dropped, they will show up in dmesg
        logReversePathDrops = true;
        # wireguard trips rpfilter up https://nixos.wiki/wiki/WireGuard#Setting_up_WireGuard_with_NetworkManager
        extraCommands = ''
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport ${toString wgPort} -j RETURN
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport ${toString wgPort} -j RETURN
        '';
        extraStopCommands = ''
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport ${toString wgPort} -j RETURN || true
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport ${toString wgPort} -j RETURN || true
        '';
      };
  };
}

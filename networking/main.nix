{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    coreutils
    bashNonInteractive
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure firewall to deny traffic everywhere with exceptions for Tailscale VPN
  networking.firewall.enable = true;
  networking.nftables.enable = true;

  # Setup Tailscale
  services.tailscale.enable = true;
  networking.firewall = {
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [ 
    "TS_DEBUG_FIREWALL_MODE=nftables" 
  ];

  # 3. Optimization: Prevent systemd from waiting for network online 
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false; 
  boot.initrd.systemd.network.wait-online.enable = false;

  # Setup SSH Server
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    listenAddresses = [
      # Restrict SSH to listen on Tailscale VPN
      {
        addr = "100.83.42.94";
        port = 22;
      }
    ];
  };

  # Ensure that tailscale systemd unit passes once tailscale has bound to network
  #   Source: https://agren.cc/p/systemd-tailscale/
  systemd.services.tailscale-bound = {
    wants = [
      "tailscaled.service"
    ];
    after = [
      "tailscaled.service"
    ];
    description = "Waits for tailscale to setup interface with bound IP that other systemd units can await.";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = 
          let 
            timeout = "${pkgs.coreutils}/bin/timeout";
            sleep = "${pkgs.coreutils}/bin/sleep";
            tailscale = "${config.services.tailscale.package}/bin/tailscale";
            bash = "${pkgs.bashNonInteractive}/bin/bash";
          in
          "${timeout} 60s ${bash} -c 'until ${tailscale} status --peers=false; do ${sleep} 1; done'";
      };
    };
  # SSH server binds to a tailscale IP so it must load after tailscale
  systemd.services.sshd = {
    after = [
      "tailscale-bound.service"
    ];
  };
  users.users.ethanlam = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFd6sz++4qEBXCiC42s9Wb+Rtpz5/0mG40Hjbw8Fidvn"
    ];
  };
}
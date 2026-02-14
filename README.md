# Setup
Update `/etc/nixos/configuration.nix` to use this repository as the entrypoint.
```nix
{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <PATH_TO_REPO>/configuration.nix
    ];
}
```

Then run `sudo nixos-rebuild switch`.
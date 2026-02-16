# Bootstrapping configuration
* Update `/etc/nixos/configuration.nix` to utilize flakes by adding
```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```
* Run `sudo nixos-rebuild switch` to obtain flakes commands
* Clone this git repository
* 
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
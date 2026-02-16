# Bootstrapping configuration
* Update `/etc/nixos/configuration.nix` to utilize flakes by adding
```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```
* Run `sudo nixos-rebuild switch` to obtain flakes commands
* Clone this git repository to a local path
* Create `/etc/nixos/flake.nix` that bootstraps the entire system
```nix
{
  description = "Bootstrap NixOS Flake";
  inputs.localNixOSConfig.url = "path:<PATH_TO_GIT_REPOSITORY>";

  outputs = inputs@{ self, localNixOSConfig, ... }: {

    nixosConfigurations.nixos = localNixOSConfig.nixosConfigurations.nixos (import ./hardware-configuration.nix);
  };
}
```
* Run `sudo nixos-rebuild switch` reconfigure system
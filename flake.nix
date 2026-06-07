{
  description = "Ethan Lam's Flake To Setup NixOS";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  }: {
    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    #
    # Deviation: This attribute takes a hardware-configuration from the bootstrapping flake
    #            to inject into the build process for nixOS as we cannot directly pull from
    #            /etc/nixos/hardware-configuration.nix.
    nixosConfigurations.nixos = hardware-configuration: 
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          hardware-configuration # Injected hardware-configuration
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ethanlam = import ./home.nix;
          }
        ];
      };
  };
}

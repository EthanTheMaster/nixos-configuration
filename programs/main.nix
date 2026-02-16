{ config, pkgs, ... }:
{
  imports = [
    ./vscode.nix
    ./firefox.nix
  ];
}
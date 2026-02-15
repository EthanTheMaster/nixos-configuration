{ config, pkgs, ... }:
{
  imports = [
    ./vscode.nix
    ./git.nix
    ./firefox.nix
  ];
}
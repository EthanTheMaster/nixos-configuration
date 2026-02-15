{ config, pkgs, ... }:
{
  users.users.ethanlam = {
    packages = with pkgs; [
      # Configure VSCode extensions
      ( vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            vscodevim.vim 
            jnoortheen.nix-ide
          ];
      })
    ];
  };
}
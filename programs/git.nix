
{ config, pkgs, ... }:
{
  home-manager.users.ethanlam = { pkgs, ... }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name  = "Ethan Lam";
          email = "elmemphis2000@gmail.com";
        };
        init.defaultBranch = "main";
        core.editor = "vim";
      };
    };
  };
}
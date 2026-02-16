{ config, pkgs, ... }:
{
  home.username = "ethanlam";
  home.homeDirectory = "/home/ethanlam";
  
  home.packages = with pkgs; [
    kdePackages.kate
    hledger
    hledger-web
    tmux
    just
    vim
    tree
    wget
    git
  ];
  programs.bash.enable = true;

  # Configure git settings
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

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
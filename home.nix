{ config, pkgs, ... }:
{
  home.username = "ethanlam";
  home.homeDirectory = "/home/ethanlam";

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
  
  home.packages = with pkgs; [
    kdePackages.kate
    hledger
    hledger-web
    just
    tree
    wget
    dig
    helix
    yazi
    glow
    # Agentic Workflows
    lmstudio
    pi-coding-agent
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

  # Configure tmux
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      set -s set-clipboard on
      set -g default-terminal "xterm-256color"
      set -s copy-command 'pbcopy'
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'pbcopy'
    '';
  }; 
  
  # Configure fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # Configure vim
  programs.vim = {
    enable = true;
    extraConfig = ''
      set tabstop=2 softtabstop=2 shiftwidth=2
      set expandtab
      set number ruler
      set autoindent smartindent
      syntax enable
      filetype plugin indent on
    '';
  };

  home.file = {
    ".config/helix/config.toml" = {
      enable = true;
      source = ./home/.config/helix/config.toml;
    };
    ".pi/agent/models.json" = {
      source = home/.pi/agent/models.json;
    };
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}

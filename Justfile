stage-changes:
    # Lock down dependencies
    nix flake lock
    # Make everything visible to flakes
    git add .

rebuild: stage-changes
    # Because the bootstrapping process creates a thin flake wrapper around
    # This repository, we'll need to force update the flake in /etc/nixos
    # to see the new changes in this local repository flake.
    cd /etc/nixos && sudo nix flake update
    sudo nixos-rebuild switch

stage-changes:
    # Lock down dependencies
    nix flake lock
    # Make everything visible to flakes
    git add .

rebuild:
    sudo nixos-rebuild switch

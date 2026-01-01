# Update the system

sudo nix flake update
> Updates the flake.lock file

sudo nixos-rebuild switch --flake .
> Rebuilds the system from the updated lockfile

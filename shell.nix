{ system ? builtins.currentSystem }:
let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { inherit system; config = {}; overlays = []; };
in pkgs.mkShellNoCC {
  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  
  shellHook = ''
    git config user.name "Adam Arbour"
    git config user.email "845679+adamarbour@users.noreply.github.com"
    git config init.defaultBranch main
    export SOPS_AGE_KEY="$(grep ^AGE-SECRET-KEY ./key.txt)"
  '';
  
  packages = with pkgs; [
    age
    git
    just
    npins
    sops
    ssh-to-age
  ];
}

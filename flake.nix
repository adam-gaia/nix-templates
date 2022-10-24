# Author: Peter Dragos
# Repository: https://github.com/dragospe/python-flake-template
{
  description = "Flake to manage python workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        poetry-env = pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; };
      in
      {
        devShell = poetry-env.env.overrideAttrs (oldAttrs: {
          buildInputs = with pkgs;
            [
              nixpkgs-fmt
              entr
              fd
              poetry
              # Poetry's export is now its own plugin.
              # Poetry plugins must be installed via nix, since poetry does not have write permission to the nix store
              python310Packages.poetry-plugin-export
            ];
        });
        packages =
          {
            default = pkgs.poetry2nix.mkPoetryApplication {
              projectDir = ./.;
            };
          };

      });
}

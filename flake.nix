{
  description = "Nix templates";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    official-templates.url = github:nixos/templates;
  };

  outputs = { self, nixpkgs, flake-utils, official-templates, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (pkgs) lib;
          toolchain = with pkgs; [
            nixpkgs-fmt
            pre-commit
          ];
        in
        {
          devShells.default = pkgs.mkShell {
            # Packages avaliable in the shell
            nativebuildInputs = toolchain;
          };
        }
      )
    // {
      # Build off of the official templates. By starting with the official templates
      # (insted of adding offical templates after) we can override names
      templates = official-templates.templates
      // {
        rust = {
          path = ./rust-cli-app;
          description = "Rust CLI app template";
        };
        rust-web-server = {
          path = ./rust-web-server;
          description = "Rust web server";
        };
        python = {
          path = ./python-poetry;
          description = "Python project managed by Poetry";
        };
      };
    };
}

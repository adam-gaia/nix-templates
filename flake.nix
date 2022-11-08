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
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) lib;
        toolchain = with pkgs; [
          nixpkgs-fmt
          pre-commit
        ];

        rust-cli-app = {
          path = ./rust-cli-app;
          description = "Rust CLI app template";
        };
        rust-web-server = {
          path = ./rust-web-server;
          description = "Rust CLI web server";
        };
        python-poetry = {
          path = ./python-poetry;
          description = "Python project managed by Poetry";
        };
      in
      {
        # Build off of the official templates. By starting with the official templates
        # (insted of adding offical templates after) we can override names
        templates = official-templates.templates
          // {
          rust = rust-cli-app;
          rust-web-server = rust-web-server;
          python = python-poetry;
        };

        devShells.default = pkgs.mkShell {
          # Packages avaliable in the shell
          nativebuildInputs = toolchain;
        };
      });
}

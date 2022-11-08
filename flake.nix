{
  description = "Nix templates";

  inputs = {
    official-templates.url = github:nixos/templates;
  };

  outputs = { self, official-templates, ... }: 
    let
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
    in {
    # Build off of the official templates. By starting with the official templates
    # (insted of adding offical templates after) we can override names
    templates = official-templates.templates
    // {
       rust = rust-cli-app;
       rust-web-server = rust-web-server;
       python = python-poetry;
    }; 
  };
}

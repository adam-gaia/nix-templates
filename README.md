# Nix Flake Templates

## Usage

- Add this repo to list of registries under the alias 'templates'

```bash
nix registry add templates .
```

- List templates

```bash
nix flake show
```

- Use a template

```bash
nix flake init -t templates#<template>
```

## Resources

- https://peppe.rs/posts/novice_nix:_flake_templates/

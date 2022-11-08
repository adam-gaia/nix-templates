# Nix Flake Templates

## Usage

- Add this repo to list of registries under the alias 'templates'

```bash
nix registry add templates "${PWD}" # Path must be absolute
```

- List avaliable registries

```bash
nix registry list
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

- Nix template notes
  https://peppe.rs/posts/novice_nix:_flake_templates/
- Python flake example
  flake-utils.lib.eachDefaultSystem (system:

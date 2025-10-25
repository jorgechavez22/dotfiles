# Módulos de Home Manager

Esta carpeta contiene módulos organizados para gestionar diferentes aspectos de tu configuración de forma declarativa.

## Módulos actuales

### [packages.nix](packages.nix)
Paquetes instalados en tu sistema:
- **Nix tooling**: nixd, nixfmt, statix, deadnix, nix-tree, nix-index
- **Development**: nodejs_20 (gestión global, usa flakes por proyecto)

### [shell.nix](shell.nix)
Configuración de shells y entorno:
- **Zsh**: Oh My Zsh, plugins, aliases, autocompletado
- **Bash**: Configuración alternativa, aliases
- **direnv**: Integración con nix-direnv para entornos por proyecto
- **Variables**: PATH personalizado (Flutter, etc.)

### [git.nix](git.nix)
Configuración de Git:
- Usuario y email
- Aliases (st, co, br, etc.)
- Comportamiento de push/pull
- Optimizaciones de rendimiento
- Archivos ignorados globalmente

### [vscode.nix](vscode.nix)
VSCode con extensiones y configuración:
- **Extensiones**: Dart, Flutter, Nix IDE, direnv, VSCode Icons
- **Nix IDE**: nixd (LSP), nixfmt (formatter)
- **Direnv**: Integración automática con proyectos
- **Settings**: Format on save, Flutter SDK path

## Cómo agregar más módulos

1. **Crea un nuevo archivo `.nix`** en esta carpeta
2. **Impórtalo en `../home.nix`** en la sección `imports`

### Ejemplo: Configuración de Neovim

```nix
# modules/nvim.nix
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-treesitter
    ];

    extraConfig = ''
      set number
      set relativenumber
    '';
  };
}
```

Luego en `home.nix`:

```nix
imports = [
  ./modules/packages.nix
  ./modules/shell.nix
  ./modules/git.nix
  ./modules/vscode.nix
  ./modules/nvim.nix  # Nuevo módulo
];
```

## Principios de organización

- **Un módulo = una responsabilidad**: Cada módulo gestiona un aspecto específico
- **Modular y reutilizable**: Fácil de habilitar/deshabilitar comentando el import
- **Declarativo**: Todo versionado en Git, reproducible
- **Sin secretos**: Nunca commits tokens, usar variables de entorno o `secrets.nix` (ignorado en .gitignore)

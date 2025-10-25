{ pkgs, ... }:

{
  # Paquetes organizados por categoría
  home.packages = with pkgs; [
    # === Herramientas de Nix ===
    nixd # Language server para Nix
    nixfmt-rfc-style # Formateador oficial
    statix # Linter
    deadnix # Detectar código no usado
    nix-tree # Visualizar dependencias
    nix-output-monitor # Builds bonitos
    nix-index # Buscar archivos en nixpkgs

    # === Terminal y shell ===
    # bat                  # cat con syntax highlighting
    # eza                  # ls moderno
    # ripgrep              # grep más rápido
    # fd                   # find más fácil
    # fzf                  # Fuzzy finder

    # === Desarrollo ===
    # git
    # neovim
    # vscode

    # === Lenguajes de programación ===
    nodejs # Node.js LTS (global, para proyectos sin flake)
    # python3
    # go
    # rustup

    # === Utilidades ===
    # htop
    # neofetch
    # tmux
  ];
}

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

    # === Claude AI ===
    claude-code # Agentic coding tool en terminal

    # === Fuentes ===
    nerd-fonts.jetbrains-mono

    # === Lenguajes de programación ===
    nodejs_22 # Node.js LTS (global, para proyectos sin flake)
    nodePackages.typescript
  ];
}

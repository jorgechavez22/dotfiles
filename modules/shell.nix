{ ... }:

{
  # Configuración de Zsh - DESHABILITADA para coexistir con ML4W
  # ML4W gestiona .zshrc, oh-my-zsh, plugins, etc.
  # Home Manager solo inyecta configuración via .zshrc_custom
  programs.zsh = {
    enable = false;  # Deshabilitado - ML4W gestiona zsh completamente
  };

  # Generar .zshrc_custom para inyectar configuración en ML4W
  home.file.".zshrc_custom".text = ''
    # ============================================
    # Configuración generada por Home Manager
    # Este archivo es cargado por ML4W automáticamente
    # ============================================

    # --------------------------------------------
    # Aliases de Nix y desarrollo
    # --------------------------------------------
    alias ll="ls -alh"
    alias la="ls -A"
    alias l="ls -CF"

    # Aliases de Nix
    alias nix-update="nix flake update ~/dotfiles"
    alias home-switch="home-manager switch --flake ~/dotfiles#jorge"
    alias home-build="home-manager build --flake ~/dotfiles#jorge"

    # Git shortcuts
    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"
    alias gl="git log --oneline --graph --all"

    # --------------------------------------------
    # PATH adicionales
    # --------------------------------------------
    # Flutter
    export PATH="$HOME/development/flutter/bin:$PATH"

    # --------------------------------------------
    # Notas
    # --------------------------------------------
    # NVM deshabilitado - usando Nix para Node.js
    # Node.js se gestiona por proyecto con flakes + direnv
    # Para versión global, agrégala en modules/packages.nix

    # --------------------------------------------
    # Variables de entorno adicionales
    # --------------------------------------------
    # Agrega tus variables aquí si lo necesitas
    # export MI_VARIABLE="valor"

    # --------------------------------------------
    # Configuraciones personalizadas adicionales
    # --------------------------------------------
    # Agrega tus funciones o configuraciones personalizadas aquí
  '';

  # Configuración de direnv (carga automática de entornos)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Bash - DESHABILITADO (ML4W no lo usa, pero mantenemos coherencia)
  programs.bash = {
    enable = false;  # Deshabilitado - no es necesario en un sistema con zsh como shell principal
  };
}

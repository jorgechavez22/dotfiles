{ config, lib, ... }:

{
  # Configuración de Zsh con oh-my-zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # Puedes cambiar el tema (agnoster, powerlevel10k, etc.)
      plugins = [
        "git"
        "docker"
        "docker-compose"
        "kubectl"
        "terraform"
        "node"
        "npm"
        "python"
        "pip"
        "sudo"
        "command-not-found"
        "direnv"
        "history"
        "colorize"
        "colored-man-pages"
        "extract"
        "z"
      ];
    };

    # Aliases
    shellAliases = {
      # Aliases básicos
      ll = "ls -alh";
      la = "ls -A";
      l = "ls -CF";

      # Aliases de Nix (usa el username dinámico)
      nix-update = "nix flake update ~/dotfiles";
      home-switch = "home-manager switch --flake ~/dotfiles#${config.home.username}";
      home-build = "home-manager build --flake ~/dotfiles#${config.home.username}";

      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --all";
    };

    # Variables de entorno
    sessionVariables = {
      # Flutter se gestiona ahora por Nix (no necesita PATH adicional)
    };

    # Configuración adicional (nueva sintaxis - reemplaza initExtra)
    initContent = lib.mkOrder 1200 ''
      # Configuraciones personalizadas adicionales

      # Historial mejorado
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS

      # Corrección automática de comandos
      setopt CORRECT
      setopt CORRECT_ALL
    '';
  };

  # Configuración de direnv (carga automática de entornos)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}

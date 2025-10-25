{ config, pkgs, ... }:

{
  # Configuración de Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Aliases básicos
      ll = "ls -alh";
      la = "ls -A";
      l = "ls -CF";

      # Aliases de Nix
      nix-update = "nix flake update ~/dotfiles";
      home-switch = "home-manager switch --flake ~/dotfiles#jorge";
      home-build = "home-manager build --flake ~/dotfiles#jorge";

      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --all";
    };

    # Configuración adicional de zsh
    initContent = ''
      # Flutter
      export PATH="$HOME/development/flutter/bin:$PATH"

      # NVM deshabilitado - usando Nix para Node.js
      # Node.js se gestiona por proyecto con flakes + direnv
      # Para versión global, agrégala en modules/packages.nix

      # Configuraciones personalizadas adicionales aquí
    '';

    # Variables de entorno específicas del shell
    sessionVariables = {
      # Agrega variables aquí si lo necesitas
    };

    # Oh My Zsh gestionado por Home Manager
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # Cambia a tu tema favorito
      plugins = [
        "git"
        "sudo"
        "direnv"
        "colored-man-pages"
      ];
    };

    # Historia de comandos
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  # Configuración de direnv (carga automática de entornos)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Bash (opcional, por compatibilidad)
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Mismos aliases que zsh
    shellAliases = {
      ll = "ls -alh";
      la = "ls -A";
      l = "ls -CF";
      nix-update = "nix flake update ~/dotfiles";
      home-switch = "home-manager switch --flake ~/dotfiles#jorge";
      home-build = "home-manager build --flake ~/dotfiles#jorge";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --all";
    };

    bashrcExtra = ''
      # Flutter
      export PATH="$HOME/development/flutter/bin:$PATH"

      # NVM deshabilitado - usando Nix para Node.js
      # Node.js se gestiona por proyecto con flakes + direnv
      # Para versión global, ver modules/packages.nix
    '';
  };
}

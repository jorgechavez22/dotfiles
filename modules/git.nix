{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Configuración usando la nueva sintaxis
    settings = {
      # Usuario
      user = {
        name = "jorgechavez22";
        email = "chavezaparco@gmail.com";
      };

      # Configuración general
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;

      # Mejoras de rendimiento
      core = {
        preloadindex = true;
        fscache = true;
      };

      # Aliases útiles
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "log --oneline --graph --all --decorate";
      };
    };

    # Ignorar archivos globalmente
    ignores = [
      # Nix
      "result"
      "result-*"
      ".direnv/"

      # Editores
      ".vscode/"
      ".idea/"
      "*.swp"
      "*.swo"
      "*~"

      # OS
      ".DS_Store"
      "Thumbs.db"
    ];

    # Delta para diffs más bonitos (opcional)
    # delta = {
    #   enable = true;
    #   options = {
    #     navigate = true;
    #     light = false;
    #     line-numbers = true;
    #   };
    # };
  };
}

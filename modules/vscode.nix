{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Perfil por defecto
    profiles.default = {
      # Extensiones instaladas (solo las disponibles en nixpkgs)
      extensions = with pkgs.vscode-extensions; [
        # Dart & Flutter
        dart-code.dart-code
        dart-code.flutter

        # Nix
        jnoortheen.nix-ide

        # JavaScript/TypeScript
        esbenp.prettier-vscode
        editorconfig.editorconfig

        # Icons
        vscode-icons-team.vscode-icons

        # Direnv integration
        mkhl.direnv
      ];

      # NOTA: Extensiones no disponibles en nixpkgs (instalar manualmente):
      # - anthropic.claude-code (Claude Code)
      # - shd101wyy.markdown-preview-enhanced (Markdown Preview Enhanced)
      #
      # Para instalarlas manualmente:
      # code --install-extension anthropic.claude-code
      # code --install-extension shd101wyy.markdown-preview-enhanced

      # Configuración de VSCode (settings.json)
      userSettings = {
        # Flutter
        "dart.flutterSdkPath" = "/home/jorge/development/flutter";

        # Apariencia
        "workbench.iconTheme" = "vscode-icons";
        "window.restoreWindows" = "none";
        "editor.minimap.enabled" = false;
        "explorer.compactFolders" = false;  # Mostrar carpetas en árbol, no compactadas

        # Fuente
        "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "editor.fontLigatures" = true;  # Activar ligaduras
        "editor.fontSize" = 14;  # Tamaño opcional

        # Terminal integrado
        "terminal.integrated.defaultProfile.linux" = "zsh";

        # Configuración de Nix Language Support
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd"; # Usar nixd como language server

        # Configuración del LSP (la forma correcta)
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "nixpkgs" = {
              # Usa nixpkgs de tu flake en lugar de NIX_PATH
              "expr" = "import (builtins.getFlake \"/home/jorge/dotfiles\").inputs.nixpkgs { }";
            };
            "options" = {
              # Opciones de Home Manager para mejor autocompletado
              "home-manager" = {
                "expr" = "(builtins.getFlake \"/home/jorge/dotfiles\").homeConfigurations.jorge.options";
              };
            };
          };
        };

        # Formateo automático para archivos Nix
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
          "editor.tabSize" = 2;
        };

        # Formateo para JavaScript y TypeScript
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        # Configuración de direnv
        "direnv.restart.automatic" = true;  # Reinicia automáticamente cuando .envrc cambia
        "direnv.path.executable" = "direnv";  # Usa el direnv de tu PATH

        # Asegurar que las terminales integradas usen el entorno de direnv
        "terminal.integrated.inheritEnv" = true;  # Heredar variables del workspace

        # Opcional: Más configuraciones útiles
        # "editor.formatOnSave" = true;
        # "editor.tabSize" = 2;
        # "files.autoSave" = "afterDelay";
      };

      # Keybindings (keybindings.json)
      keybindings = [
        # Agrega tus keybindings personalizados aquí
        # Ejemplo:
        # {
        #   key = "ctrl+shift+p";
        #   command = "workbench.action.showCommands";
        # }
      ];
    };
  };
}

{ config, pkgs, ... }:

{
  # Importar módulos
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/vscode.nix
  ];

  # Permitir paquetes unfree (necesario para VSCode)
  nixpkgs.config.allowUnfree = true;

  # IMPORTANTE: Cambia esto a tu información
  home.username = "jorge";
  home.homeDirectory = "/home/jorge";

  # Versión de Home Manager (no cambiar a menos que sepas lo que haces)
  home.stateVersion = "24.11";

  # Dejar que Home Manager se gestione a sí mismo
  programs.home-manager.enable = true;

  # Gestionar dotfiles existentes
  # Home Manager copiará estos archivos a tu $HOME
  home.file = {
    #".config/nix".source = ./.config/nix;
  };

  # Variables de entorno globales
  home.sessionVariables = {
    EDITOR = "nvim"; # Cambia a tu editor preferido
    # NIX_PATH = "nixpkgs=${pkgs.path}";
  };

  # XDG Base Directory
  xdg.enable = true;
}

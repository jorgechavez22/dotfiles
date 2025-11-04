{ config, pkgs, ... }:

{
  # Importar módulos
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/git.nix
    # ./modules/vscode.nix - Deshabilitado: En WSL2 se usa VSCode desde Windows con Remote-WSL
  ];

  # Permitir paquetes unfree (necesario para VSCode)
  nixpkgs.config.allowUnfree = true;

  # NOTA: home.username y home.homeDirectory se definen dinámicamente en flake.nix

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

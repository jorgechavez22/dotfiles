{
  description = "Configuración de dotfiles con Nix Flakes y Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Función para crear configuración de usuario
      mkHomeConfiguration = username: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    in
    {
      # Configuración de Home Manager
      homeConfigurations = {
        # Configuración específica por usuario
        tristeza = mkHomeConfiguration "tristeza";
        jorge = mkHomeConfiguration "jorge";

        # Puedes agregar más usuarios fácilmente
        # otrousuario = mkHomeConfiguration "otrousuario";
      };
    };
}

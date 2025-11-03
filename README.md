# 🏠 Jorge's Dotfiles

Mi colección personal de archivos de configuración para Linux, gestionada con **Nix Flakes** y **Home Manager** para un entorno completamente reproducible.

## 📁 Qué hay aquí

Configuraciones actuales:
- **Home Manager** - Gestión declarativa de dotfiles y paquetes de usuario
- **Nix Flakes** - Entorno de desarrollo reproducible

## 🚀 Instalación

### Prerrequisitos

- Nix instalado en tu sistema
- Daemon de Nix habilitado: `sudo systemctl enable --now nix-daemon`

### Pasos

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/jorgechavez22/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Configurar Nix Flakes** (primera vez):
   ```bash
   # Crear link simbólico para configuración de Nix con flake (nivel usuario)
   mkdir -p ~/.config/nix
   ln -sf ~/dotfiles/.config/nix/nix.conf ~/.config/nix/nix.conf

   # Verificar que flakes está habilitado
   nix flake show ~/dotfiles
   ```

3. **Personalizar la configuración**:
   ```bash
   # Edita home.nix y cambia:
   # - home.username
   # - home.homeDirectory   
   ```

4. **Aplicar la configuración con Home Manager** (bootstrap):
   ```bash
   # Eliminar symlinks existentes que Home Manager recreará
   rm ~/.config/nix/nix.conf 2>/dev/null

   # Bootstrap: Primera aplicación de Home Manager
   # Esto descarga Home Manager y lo instala declarativamente
   nix run home-manager/master -- switch -b backup --flake .#jorge

   # Home Manager se auto-instala gracias a:
   # programs.home-manager.enable = true (en home.nix)
   ```

5. **Recargar tu shell**:
   ```bash
   # Bash
   source ~/.bashrc

   # O reinicia tu terminal
   ```

6. **Verificar instalación**:
   ```bash
   # Verificar que home-manager está disponible
   which home-manager
   # → ~/.nix-profile/bin/home-manager

   # Ver symlinks creados por Home Manager
   ls -la ~/.config/hypr ~/.config/waybar

   # Ver paquetes instalados
   home-manager packages | head -20
   ```

### Actualizaciones futuras

```bash
# Actualizar dependencias del flake
nix flake update

# Aplicar cambios de configuración
home-manager switch --flake ~/dotfiles#jorge

# O usar el alias (después de aplicar por primera vez)
home-switch
```

## 📂 Estructura del proyecto

```
dotfiles/
├── flake.nix              # Definición del flake con Home Manager
├── flake.lock             # Lock file de dependencias (reproducibilidad)
├── home.nix               # Configuración principal de Home Manager
├── modules/               # Módulos organizados por categoría
│   ├── packages.nix       # Paquetes instalados (nixd, nodejs, etc.)
│   ├── shell.nix          # Zsh/Bash, Oh My Zsh, direnv
│   ├── git.nix            # Configuración de Git
│   ├── vscode.nix         # VSCode (extensiones, settings)
│   └── README.md          # Documentación de módulos
├── .config/
│   ├── hypr/              # Configuración de Hyprland
│   ├── waybar/            # Configuración de Waybar
│   └── nix/
│       └── nix.conf       # Habilita flakes y experimental features
└── .gitignore             # Ignora secrets y archivos locales
```

## ⚙️ Personalización

### Agregar paquetes

Edita [modules/packages.nix](modules/packages.nix) y descomenta o agrega los paquetes que necesites:

```nix
home.packages = with pkgs; [
  neovim
  nodejs
  python3
  # Agrega más paquetes aquí
];
```

### Configurar programas

Cada módulo en `modules/` gestiona un aspecto de tu configuración:

- **packages.nix** - Paquetes instalados (Nix tooling, Node.js, etc.)
- **shell.nix** - Shell (Zsh/Bash), aliases, direnv
- **git.nix** - Configuración de Git
- **vscode.nix** - VSCode con extensiones y settings

Crea nuevos módulos según necesites (editor, terminal, etc.) y agrégalos a `imports` en [home.nix](home.nix).

### Gestionar dotfiles

Home Manager puede copiar tus archivos de configuración:

```nix
# En home.nix
home.file = {
  ".config/nvim".source = ./.config/nvim;
};
```

## 🔄 Direnv - Entornos por proyecto

Esta configuración incluye **direnv** con **nix-direnv** para cargar automáticamente entornos de desarrollo específicos por proyecto.

### Cómo funciona

Cuando entras a un directorio con un archivo `.envrc`, direnv automáticamente:
1. Carga el entorno definido en `flake.nix` del proyecto
2. Actualiza tu PATH con las herramientas del proyecto
3. Configura variables de entorno específicas
4. Se descarga al salir del directorio

### Configurar un proyecto

1. **Crear `flake.nix` en tu proyecto**:
   ```nix
   {
     description = "Mi proyecto";
     inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
     outputs = { self, nixpkgs }:
       let
         system = "x86_64-linux";
         pkgs = nixpkgs.legacyPackages.${system};
       in {
         devShells.${system}.default = pkgs.mkShell {
           buildInputs = with pkgs; [
             nodejs_22  # Versión específica para este proyecto
             python312
           ];
           shellHook = ''
             echo "Entorno de desarrollo cargado"
           '';
         };
       };
   }
   ```

2. **Crear `.envrc`**:
   ```bash
   use flake
   ```

3. **Permitir direnv**:
   ```bash
   direnv allow
   ```

### Integración con VSCode

La extensión **mkhl.direnv** está configurada para:
- Detectar automáticamente `.envrc` en proyectos
- Cargar el entorno en terminales integradas
- Proporcionar las herramientas correctas al LSP

**Configuración en [modules/vscode.nix](modules/vscode.nix)**:
```nix
extensions = [
  mkhl.direnv  # Extensión de direnv
];

userSettings = {
  "direnv.restart.automatic" = true;
  "terminal.integrated.inheritEnv" = true;
};
```

### Ventajas vs Gestores de Versiones Tradicionales

#### ❌ Problemas con NVM, pyenv, rbenv, etc.

Estos gestores tienen conflictos con Nix:
- Se cargan globalmente en el shell (`.zshrc`, `.bashrc`)
- Tienen prioridad en PATH sobre herramientas de Nix
- VSCode los detecta primero, ignorando el entorno de direnv
- Requieren instalación y gestión manual por proyecto

**Ejemplo del problema**:
```bash
# En proyecto con direnv + Nix
cd mi-proyecto-con-node-18
which node
# ❌ /home/user/.nvm/versions/node/v22.21.0/bin/node  (mal!)
# ✅ /nix/store/.../node-18.../bin/node  (esperado)
```

#### ✅ Solución: Nix-only

**Enfoque recomendado**:
1. **Herramientas globales** → `modules/packages.nix`
   ```nix
   home.packages = with pkgs; [
     nodejs_20  # Node global para scripts
   ];
   ```

2. **Versiones por proyecto** → `flake.nix` + direnv
   ```nix
   # proyecto-a/flake.nix → nodejs_18
   # proyecto-b/flake.nix → nodejs_22
   ```

3. **Desinstalar gestores tradicionales**:
   ```bash
   # Remover NVM
   rm -rf ~/.nvm
   # Remover configuración de .zshrc, .bashrc
   ```

**Beneficios**:
- ✅ Aislamiento perfecto entre proyectos
- ✅ Reproducible (lock file)
- ✅ VSCode detecta el entorno correcto
- ✅ No hay conflictos de PATH
- ✅ Cache con nix-direnv (carga instantánea)

## 🔧 Comandos útiles

```bash
# Home Manager
home-manager build --flake ~/dotfiles#jorge  # Verificar sin aplicar
home-manager switch --flake ~/dotfiles#jorge  # Aplicar cambios
home-manager expire-generations "-30 days"   # Limpiar antiguas
home-switch  # Alias configurado

# Nix Flakes
nix flake show          # Ver configuración del flake
nix flake update        # Actualizar dependencias (nixpkgs, etc.)
nix flake lock          # Actualizar lock file

# Direnv
direnv allow            # Permitir .envrc en directorio actual
direnv reload           # Recargar entorno
direnv deny             # Deshabilitar .envrc

# Nix cleanup
nix-collect-garbage -d  # Recolectar basura
nix-store --gc          # Garbage collection
```

## 🐚 Cambiar shell por defecto

Para usar Zsh como shell por defecto (ya configurado en Home Manager):

```bash
# Verificar que zsh está instalado
which zsh

# Cambiar shell (no necesita sudo, pero pedirá tu contraseña)
chsh -s /bin/zsh

# Cerrar sesión y volver a iniciar

# Verificar el cambio
echo $SHELL  # Debería mostrar /bin/zsh
```

## 📝 Notas

- Estas configuraciones están hechas para **Arch Linux con Nix**
- Home Manager gestiona paquetes y configuraciones de forma declarativa
- Los cambios en los archivos `.nix` requieren ejecutar `home-manager switch`
- **No uses NVM, pyenv, rbenv** - Usa Nix para gestión de versiones por proyecto
- Para más información: [Home Manager Manual](https://nix-community.github.io/home-manager/)

### Configuración de Nix: Usuario vs Sistema

Esta configuración usa **nivel de usuario** (`~/.config/nix/nix.conf`) para:
- ✅ Portabilidad - Todo en dotfiles, fácil de versionar
- ✅ Sin permisos root - No requiere sudo para cambios
- ✅ Por usuario - Cada usuario puede tener su config

**Alternativa (nivel sistema):**
```bash
# Si prefieres configuración global para todos los usuarios
sudo cp ~/.config/nix/nix.conf /etc/nix/nix.conf
sudo systemctl restart nix-daemon
```

**Prioridad:** Nix lee primero `~/.config/nix/nix.conf`, luego `/etc/nix/nix.conf`

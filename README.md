# 🏠 Jorge's Dotfiles

Mi colección personal de archivos de configuración para Linux.

## 📁 Qué hay aquí

Configuraciones actuales:
- **Hyprland** - Window manager (Wayland)
- **Waybar** - Barra de estado

## 🚀 Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/jorgechavez22/dotfiles.git ~/dotfiles
   ```

2. **Crear enlaces simbólicos**:
   ```bash
   # Respalda tus configs actuales primero
   mv ~/.config/hypr ~/.config/hypr.backup
   mv ~/.config/waybar ~/.config/waybar.backup

   # Crea los symlinks
   ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
   ln -sf ~/dotfiles/.config/waybar ~/.config/waybar
   ```

3. **Recargar tu entorno**

## 📝 Notas

- Estas configuraciones están hechas para Arch Linux
- Adapta las rutas y paquetes según tu distribución
- Consulta la documentación oficial de cada herramienta para más detalles

---

*Modificado por Claude Code*
# 🏠 Jorge's Dotfiles

My personal configuration files for Arch Linux with Hyprland and Waybar.

## 🖥️ System Information

- **OS**: Arch Linux
- **WM**: Hyprland
- **Status Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Wofi
- **File Manager**: Dolphin

## 📁 Repository Structure

```
.config/
├── hypr/
│   └── hyprland.conf       # Hyprland window manager configuration
└── waybar/
    └── config.jsonc        # Waybar status bar configuration
```

## ✨ Features

### Hyprland Configuration
- **Dual Monitor Setup**: Optimized for eDP-1 (laptop) + HDMI-A-1 (external)
- **Custom Workspace Distribution**: 
  - Workspaces 1-5: External monitor (HDMI-A-1)
  - Workspaces 6-8: Laptop screen (eDP-1)
- **Smooth Animations**: Custom bezier curves for fluid window transitions
- **Keyboard Layout**: Latin American (latam) layout support
- **Multimedia Keys**: Volume, brightness, and media player controls

### Waybar Configuration
- **System Monitoring**: CPU, memory, temperature, and battery status
- **Audio Control**: PipeWire integration with volume control
- **Network Status**: WiFi and Ethernet connection display
- **Power Management**: Power profile daemon integration
- **Workspace Indicator**: Hyprland workspace visualization

## 🚀 Quick Start

### Prerequisites

Make sure you have the following packages installed:

```bash
# Essential packages
sudo pacman -S hyprland waybar kitty wofi dolphin

# Additional dependencies
sudo pacman -S pipewire pipewire-pulse wireplumber
sudo pacman -S brightnessctl playerctl pwvucontrol
sudo pacman -S ttf-font-awesome # For waybar icons
```

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   ```

2. **Create symbolic links**:
   ```bash
   # Backup existing configs (optional)
   mv ~/.config/hypr ~/.config/hypr.backup
   mv ~/.config/waybar ~/.config/waybar.backup
   
   # Create symlinks
   ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
   ln -sf ~/dotfiles/.config/waybar ~/.config/waybar
   ```

3. **Restart Hyprland**:
   ```bash
   hyprctl reload
   ```

## ⌨️ Key Bindings

| Key Combination | Function |
|----------------|----------|
| `Super + Q` | Open terminal (Kitty) |
| `Super + C` | Close active window |
| `Super + M` | Exit Hyprland |
| `Super + E` | Open file manager |
| `Super + R` | Open application launcher |
| `Super + V` | Toggle floating mode |
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Arrow Keys` | Move focus |
| `Super + Shift + Arrow Keys` | Resize windows |

## 🎨 Customization

### Monitor Configuration
Edit the monitor settings in `hyprland.conf`:
```bash
monitor = eDP-1, preferred, 0x0, 1.25
monitor = HDMI-A-1, preferred, -2560x0, 1
```

### Waybar Modules
Customize the status bar modules in `waybar/config.jsonc`:
- Add/remove modules in `modules-left`, `modules-center`, `modules-right`
- Modify individual module configurations

## 📋 TODO

- [ ] Add custom Hyprpaper wallpaper configuration
- [ ] Configure notification daemon (dunst/mako)
- [ ] Add custom scripts for waybar
- [ ] Theme customization (GTK/Qt themes)
- [ ] Add screenshot utilities configuration

## 🤝 Contributing

Feel free to suggest improvements or share your own configurations! Open an issue or submit a pull request.

## 📄 License

This repository is available under the [MIT License](LICENSE).

---

⭐ If you found these configurations helpful, consider giving this repo a star!
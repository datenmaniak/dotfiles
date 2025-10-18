# 🎛️ Sway Configuración Modular 

Este directorio contiene la configuración personalizada del gestor de ventanas [Sway](https://swaywm.org/), adaptada para entornos Wayland, con enfoque en ergonomía, modularidad, y branding técnico.

---

## 📁 Estructura del directorio

```text
sway/
├── config              # Archivo principal que incluye todos los módulos
├── input.conf          # Configuración de teclado y layouts
├── output.conf         # Posicionamiento y resolución de monitores
├── keybindings.conf    # Atajos personalizados para apps y acciones
├── apps.conf           # Lanzadores y utilidades
├── style.conf          # Fondo, fuentes, Waybar y estética
└── README.md           # Este archivo
```


## 🔗 Enlace simbólico

Para activar esta configuración:

```
rm -rf ~/.config/sway
ln -s ~/dotfiles/sway ~/.config/sway

```

## 🎯 Shortcuts personalizados

Estos atajos están definidos en los módulos `keybindings.conf` y `apps.conf`, y permiten controlar visuales, lanzar aplicaciones y reiniciar componentes del entorno Sway.

| Acción                              | Combinación de teclas     | Sintaxis en configuración de Sway                            |
|-------------------------------------|----------------------------|----------------------------------------------------------------|
| 🔠 Aumentar fuente en WezTerm       | `Ctrl + ↑`                | Definido en `wezterm.lua`:<br>`key = 'UpArrow', mods = 'CTRL', action = IncreaseFontSize` |
| 🔡 Reducir fuente en WezTerm        | `Ctrl + ↓`                | Definido en `wezterm.lua`:<br>`key = 'DownArrow', mods = 'CTRL', action = DecreaseFontSize` |
| 🔁 Reiniciar Waybar                 | `Super + Shift + W`       | `bindsym $mod+Shift+w exec pkill waybar && waybar &`          |
| 🚀 Lanzar VSCodium                  | `Ctrl + C`                | `bindsym Control+c exec codium`                               |
| 🌐 Lanzar Microsoft Edge            | `Super + Shift + B`       | `bindsym $mod+Shift+b exec microsoft-edge`                    |

> 🧠 Los shortcuts de WezTerm se definen en `wezterm.lua`, mientras que los demás viven en los módulos de configuración de Sway.


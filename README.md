# 🛠️ Dotfiles de datenmaniak

Este repositorio contiene la configuración modular y personalizada de mi entorno de desarrollo, centrado en **shells**, **WezTerm** y **Neovim**. Está diseñado para ser seguro, adaptable y visualmente coherente con mi branding **Violet Pulse**.

## 📁 Estructura actual

- `.zshrc` → Configuración avanzada de Zsh con alias, funciones, hooks (`precmd()`), y detección de entorno gráfico.
- `.bashrc` / `.bash_profile` → Configuración heredada para compatibilidad y transición hacia Zsh.
- `wezterm.lua` → Layout personalizado, integración con Starship, y estética modular.
- `nvim/` → Configuración de Neovim con plugins orientados a desarrollo web, navegación eficiente y resaltado temático.

## 🔐 Seguridad y entorno

- Scripts y configuraciones que validan privilegios (`root`), detectan entorno bajo `sudo`, y preservan `$HOME` del usuario real.
- Integración con **Starship prompt** y lógica condicional para shells (`zsh`, `bash`).
- Preparado para entornos gráficos y terminales como **WezTerm**, con soporte para layouts dinámicos.

## 🎨 Branding Violet Pulse

- Paleta aplicada en:
  - Prompt visual
  - Temas de Neovim
  - Layout de WezTerm
- Comentarios y estructuras que reflejan mi enfoque estético y funcional.

## 🚀 Instalación

```bash
git clone https://github.com/datenmaniak/dotfiles.git ~/dotfiles

cd ~/dotfiles
```


## 🔗 Enlaces al directorio 'dotfiles' recomendados

Para mantener tus configuraciones versionadas en ~/dotfiles y que las herramientas las carguen correctamente, crea los siguientes enlaces simbólicos:

### Neovim (editor favorito)
```
ln -s ~/dotfiles/nvim ~/.config/nvim
```

### WezTerm (terminal)
```
mkdir -p ~/.config/wezterm
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

### Starship (prompt)

```
 ln -s ~/dotfiles/starship/starship.toml ~/.config/
```

### Shell

```
ln -s ~/dotfiles/shell/.zshrc ~/.zshrc

ln -s ~/dotfiles/shell/.bashrc ~/.bashrc
```

### Módulos Zsh

```
mkdir -p ~/.zsh/modules

ln -s ~/dotfiles/zsh/modules/systemd-shortcuts.zsh ~/.zsh/modules/systemd-shortcuts.zsh
```

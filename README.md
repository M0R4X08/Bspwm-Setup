# Bspwm-Setup

Este script automatiza la instalación de **BSPWM** en Debian, diseñado para ofrecer un entorno ágil y optimizado para el desarrollo de software. Incluye herramientas preinstaladas como **VSCode** y **Obsidian**, así como una terminal **ZSH** con el tema **Powerlevel10k**. Utiliza **Kitty** como gestor de terminal y **Rofi** como lanzador de aplicaciones. Además, está pensado para maximizar la comodidad del usuario, incorporando atajos de teclado para controlar el brillo, indicadores de red, y gestores de **WiFi** y **Bluetooth**.

## Instalación

```bash
   git clone https://github.com/M0R4X08/bspwm-setup.git
```

```bash
cd bspwm-setup
```

```bash
chmod +x install.sh
```

```bash
./install.sh
```

> **📝 Nota:**
> Ejecuta el script como usuario normal, ya que durante su ejecución se te solicitará la contraseña de administrador.

## Setup

![Setup](https://github.com/M0R4X08/bspwm-setup/raw/main/img/setup.png)

## Posibles Errores

Si al hacer doble clic en el touchpad no se registra como clic, puedes solucionarlo de la siguiente manera:

1. Busca o crea el siguiente archivo

```bash
nano /etc/X11/xorg.conf.d/30-touchpad.conf
```

2. Copia el siguiente texto en el archivo y reinicia el pc

```text
Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "NaturalScrolling" "on"
  Option "ClickMethod" "clickfinger"
EndSection
```

## Menciones

Este entorno está basado en el setup de [S4vitar](https://github.com/s4vitar), cuyo trabajo sirvió como inspiración para la configuración.

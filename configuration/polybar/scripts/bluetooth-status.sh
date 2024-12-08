#!/bin/bash

bluetoothctl show &>/dev/null
if [ $? -ne 0 ]; then
    # Si no hay adaptador, no muestra nada y termina
    exit 0
fi

# Si el script se ejecuta con un clic, alterna el estado
if [ "$1" == "toggle" ]; then
    current=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
    if [ "$current" == "yes" ]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
fi

# Muestra el estado actual
status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
if [ "$status" == "yes" ]; then
    echo "%{F#FFFFFF}"
else
    echo "%{F#FFFFFF}"
fi

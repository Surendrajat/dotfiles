#!/bin/bash

VOL=$(pactl list sources | awk '/\tVolume/ {print $0}' | awk '{print $5}' | tail -n1)

if pactl list sources | grep -q "Mute: yes"; then echo " $VOL"; else echo " $VOL"; fi

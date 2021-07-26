#!/bin/bash

## default
# VOL=$(pactl list sources | awk '/\tVolume/ {print $0}' | awk '{print $5}' | tail -n1)
# if pactl list sources | grep -q "Mute: yes"; then echo " $VOL"; else echo " $VOL"; fi

## HP 14-dv005xxx
VOL=$(pactl list sources | awk '/\tVolume/ {print $0}' | awk '{print $5}' | tail -n2 | head -n1)
if pactl list sources | grep "Mute:" | tail -n2 | head -n1 | grep -q "Mute: yes"; then echo " $VOL"; else echo " $VOL"; fi


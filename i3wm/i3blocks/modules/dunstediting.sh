#!/bin/bash

pidof dunst && killall dunst
dunst -config ~/.config/dunst/dunstrc &

notify-send "message one"
notify-send "message two"
notify-send "message three"
notify-send "message four"
notify-send "message five"

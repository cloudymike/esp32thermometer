#!/bin/bash
PORT='/dev/ttyUSB0'
PUSHCMD="ampy --port $PORT put "
CURDIR=$(pwd)
#TOPDIR=${CURDIR%/*}
DEVKITDIR=$CURDIR/micropythonexamples/DEVKITv1

echo "Loading secret configs"
# Enter your path to your WLAN configuration file here, see ../wlan/wlanconfig.py for example
$PUSHCMD ~/secrets/wlanconfig.py

echo "Loading program files..."
$PUSHCMD $DEVKITDIR/wlan/wlan.py
$PUSHCMD $DEVKITDIR/textout/textout.py
$PUSHCMD $DEVKITDIR/LED/LED.py
$PUSHCMD $DEVKITDIR/tempreader/tempreader.py
$PUSHCMD $DEVKITDIR/oled/gfx.py
$PUSHCMD $DEVKITDIR/oled/ssd1306.py
$PUSHCMD $DEVKITDIR/oled/bignumber.py

$PUSHCMD main.py

echo "Resetting board..."
sudo timeout 2  ampy --port /dev/ttyUSB0 run $DEVKITDIR/reset/reset.py

#!/bin/bash
PORT='/dev/ttyUSB0'
PUSHCMD="ampy --port $PORT put "
CURDIR=$(pwd)
#TOPDIR=${CURDIR%/*}
DEVKITDIR=$CURDIR/micropythonexamples/DEVKITv1

#$PUSHCMD $TOPDIR/oled/ssd1306.py
echo "Loading program files..."
$PUSHCMD $DEVKITDIR/textout/textout.py
echo loading LED.py
$PUSHCMD $DEVKITDIR/LED/LED.py
echo loading tempreader.py
$PUSHCMD $DEVKITDIR/tempreader/tempreader.py
echo loading main.py
$PUSHCMD main.py
echo "Resetting board..."
sudo timeout 2  ampy --port /dev/ttyUSB0 run $DEVKITDIR/reset/reset.py

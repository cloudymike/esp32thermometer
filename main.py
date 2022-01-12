import tempreader
import textout
import time
import machine
from machine import Pin, I2C
import ssd1306
import os
import bignumber
import socket
import wlan
import network
import ntptime
import LED
import time
temperature = 0


###############################################
# Display loop, running every second
# Reads temperature and time and displays them
# Note temperature is a global, accessible from
# rest of program
###############################################
def displayLambda(tempDevice, oled, rtc, ip):
    global temperature
    temperature = tempDevice.get_temp()
    current_time = rtc.datetime()

    oled.fill(0)
    oled.text(" UTC: {4:02d}:{5:02d}:{6:02d}".format(*current_time), 0, 0)
    oled.text(" {}".format(ip), 0, 9)
    bignumber.bigTemp(oled, temperature, unit)
    oled.show()



###############################################
# Setup WLAN
###############################################
wlan.do_connect()
addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]
s = socket.socket()
# Allow reuse of socket address on softreboot
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(addr)
s.listen(1)
ifconfig = network.WLAN(network.STA_IF).ifconfig()
ip = ifconfig[0]

###############################################
#  Setup OLED
###############################################
i2c = I2C(-1, scl=Pin(22), sda=Pin(21))
oledReset=Pin(16, Pin.OUT)
oledReset.value(0)
time.sleep_ms(500)
oledReset.value(1)
oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)


###############################################
#  Setup ntp time
###############################################
rtc = machine.RTC()
try:
    ntptime.settime()
except:
    pass
    #Use old time



t = textout.textout()
unit='F'
tempDevice = tempreader.tempreader(unit)

displaytimer = machine.Timer(-1)
displaytimer.init(period=1000,
                  mode=machine.Timer.PERIODIC,
                  callback=lambda t:displayLambda(tempDevice, oled, rtc, ip))

while(1):
    LED.LED.value(abs(LED.LED.value()-1))
    time.sleep_ms(750)

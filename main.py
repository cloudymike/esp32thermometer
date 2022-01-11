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




while(1):

    temp = tempDevice.get_temp()
    current_time = rtc.datetime()

    oled.fill(0)
    oled.text(" UTC: {4:02d}:{5:02d}:{6:02d}".format(*current_time), 0, 0)
    oled.text(" {}".format(ip), 0, 9)

    #t.text("Temp: {:.1f}{}".format(temp,unit))
    #oled.text("IP: {}".format(ip), 0, 0)
    #t.text("IP: {}".format(addr))
    bignumber.bigTemp(oled, temp, unit)
    oled.show()
    time.sleep_ms(750)


'''
    tempdict = tempDevice.get_temp_list()
    for deviceID, temp in tempdict.items():
        print("ID: {}, Temp: {}".format(deviceID, temp))
        t.text("Temp: {:.1f}{}".format(temp,unit))
'''

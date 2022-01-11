import tempreader
import textout
import time
from machine import Pin, I2C
import ssd1306
import os
import bignumber


# ESP32 Pin assignment
i2c = I2C(-1, scl=Pin(22), sda=Pin(21))

# Reset OLED
oledReset=Pin(16, Pin.OUT)
oledReset.value(0)
time.sleep_ms(500)
oledReset.value(1)

oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)

t = textout.textout()
unit='F'
tempDevice = tempreader.tempreader(unit)
while(1):
    temp = tempDevice.get_temp()
    #t.text("Temp: {:.1f}{}".format(temp,unit))
    oled.fill(0)
    bignumber.bigTemp(oled, temp, unit)
    oled.show()
    time.sleep_ms(750)


'''
    tempdict = tempDevice.get_temp_list()
    for deviceID, temp in tempdict.items():
        print("ID: {}, Temp: {}".format(deviceID, temp))
        t.text("Temp: {:.1f}{}".format(temp,unit))
'''

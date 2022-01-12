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

def web_page():
  if LED.LED.value() == 1:
    gpio_state="ON"
  else:
    gpio_state="OFF"

  html = """<html><head> <title>ESP Web Server</title> <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:,"> <style>html{font-family: Helvetica; display:inline-block; margin: 0px auto; text-align: center;}
  h1{color: #0F3376; padding: 2vh;}p{font-size: 1.5rem;}.button{display: inline-block; background-color: #e7bd3b; border: none;
  border-radius: 4px; color: white; padding: 16px 40px; text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}
  .button2{background-color: #4286f4;}</style></head><body> <h1>ESP Web Server</h1>
  <p>Blue LED: <strong>""" + gpio_state + """</strong></p><p><a href="/?led=on"><button class="button">ON</button></a></p>
  <p><a href="/?led=off"><button class="button button2">OFF</button></a></p><p>Temperature: <strong>""" + str(temperature) + """</strong></p></body></html>"""
  return html


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


###############################################
#  Setup temperature reader
###############################################
unit='F'
tempDevice = tempreader.tempreader(unit)

###############################################
#  Setup Display loop
###############################################
displaytimer = machine.Timer(-1)
displaytimer.init(period=1000,
                  mode=machine.Timer.PERIODIC,
                  callback=lambda t:displayLambda(tempDevice, oled, rtc, ip))

print('Starting while loop')
while(1):
  #LED.LED.value(abs(LED.LED.value()-1))
  conn, addr = s.accept()
  print('Got a connection from %s' % str(addr))
  request = conn.recv(1024)
  request = str(request)
  print('Content = %s' % request)
  led_on = request.find('/?led=on')
  led_off = request.find('/?led=off')
  if led_on == 6:
    print('LED ON')
    LED.LED.value(1)
  if led_off == 6:
    print('LED OFF')
    LED.LED.value(0)
  response = web_page()
  conn.send('HTTP/1.1 200 OK\n')
  conn.send('Content-Type: text/html\n')
  conn.send('Connection: close\n\n')
  conn.sendall(response)
  conn.close()

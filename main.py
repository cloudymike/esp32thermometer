import tempreader
import textout
import time

t = textout.textout()
unit='F'
tempDevice = tempreader.tempreader(unit)
while(1):
    temp = tempDevice.get_temp()
    t.text("Temp: {:.1f}{}".format(temp,unit))
    time.sleep_ms(750)

'''
    tempdict = tempDevice.get_temp_list()
    for deviceID, temp in tempdict.items():
        print("ID: {}, Temp: {}".format(deviceID, temp))
        t.text("Temp: {:.1f}{}".format(temp,unit))
'''

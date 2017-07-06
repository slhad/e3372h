#!/bin/bash

#E3372H STORAGE MAC
MODEM_STORAGE="12d1:1f01"

while [ 1 = 1 ];do

lsusb | grep --quiet "$MODEM_STORAGE"
if [ $? -eq 0 ]; then
echo "Modem->storage found, waiting 5s for full init,then switch to Modem->modem+storage-microsd"
sleep 5
usb_modeswitch --verbose -s 0 -J -c /etc/usb_modeswitch.conf
else
echo "No Modem->storage found by MAC"
fi
sleep 5
done

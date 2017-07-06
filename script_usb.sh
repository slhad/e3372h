#!/bin/bash

#E3372 STORAGE MAC
#MODEM_STORAGE="12d1:14fe"

#E3372H STORAGE MAC
MODEM_STORAGE="12d1:1f01"

#E3372 MODEM MAC
#MODEM_MODEM="12d1:1506"

#E3372H MODEM MAC
MODEM_MODEM="12d1:14dc"

# 0 = storage, 1= modem
MODEM_MODE=0

check_modem_mode () {
 echo -n "Checking modem presence... "

 lsusb | grep --quiet "$MODEM_STORAGE"

 if [ $? -eq 0 ]; then
  MODEM_MODE=0
  echo "OK: modem in mass storage mode"
 else
  lsusb | grep --quiet "$MODEM_MODEM"
  if [ $? -eq 0 ]; then
   MODEM_MODE=1
   echo "OK: modem in modem mode"
  else
   echo "ERROR: modem not found"
   exit 1
  fi
 fi
}

set_modem_mode () {
 while [ $MODEM_MODE -eq 0 ]
 do
  echo -n "Setting modem mode... "
  usb_modeswitch -s 15 -J -c /etc/usb_modeswitch.conf >/dev/null 2>&1
  lsusb | grep --quiet "$MODEM_MODEM"
  if [ $? -eq 0 ]; then
   MODEM_MODE=1
   echo "OK"
  else
   echo "FAILED"
  fi
 done
}

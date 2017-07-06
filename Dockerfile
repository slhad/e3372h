FROM ubuntu:16.04

RUN apt-get update && apt-get install -y usb-modeswitch usbutils

ADD ./usb_modeswitch.conf /etc/usb_modeswitch.conf
ADD ./script_usb.sh /
ADD ./bootstrap.sh /
ADD ./switcher.sh /

RUN chmod +x /bootstrap.sh
RUN chmod +x /switcher.sh

CMD ["/bootstrap.sh"]

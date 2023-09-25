# Website
https://web.archive.org/web/20211027124225/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/

# compiled USB Modules

sudo su

modprobe usbserial
modprobe ftdi_sio
modprobe cdc-acm

cd /lib/modules/

sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/apollolake/dsm-7.2/ch341.ko
sudo insmod /lib/modules/ch341.ko
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/apollolake/dsm-7.2/cp210x.ko
sudo insmod /lib/modules/cp210x.ko
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/apollolake/dsm-7.2/pl2303.ko
sudo insmod /lib/modules/pl2303.ko
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/apollolake/dsm-7.2/ti_usb_3410_5052.ko
sudo insmod /lib/modules/ti_usb_3410_5052.ko

# Configure an autoload script

cd  /usr/local/etc/rc.d/
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/usb-serial-drivers.sh
sudo chmod +x usb-serial-drivers.sh

# Make sure your devices are recongnized

sudo /usr/local/etc/rc.d/usb-serial-drivers.sh start

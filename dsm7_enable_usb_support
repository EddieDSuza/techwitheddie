# compiled USB Modules

sudo su

modprobe usbserial
modprobe ftdi_sio
modprobe cdc-acm

cd /lib/modules/

sudo wget https://web.archive.org/web/20220126180837/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/ch341.ko
sudo insmod /lib/modules/ch341.ko
sudo wget https://web.archive.org/web/20220126180837/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/cp210x.ko
sudo insmod /lib/modules/cp210x.ko

# Configure an autoload script

cd  /usr/local/etc/rc.d/
sudo wget https://raw.githubusercontent.com/robertklep/dsm7-usb-serial-drivers/main/usb-serial-drivers.sh
sudo chmod +x usb-serial-drivers.sh

# Make sure your devices are recongnized

sudo /usr/local/etc/rc.d/usb-serial-drivers.sh start

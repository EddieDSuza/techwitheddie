# Website
https://web.archive.org/web/20211027124225/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/

# compiled USB Modules

sudo su

modprobe usbserial
modprobe ftdi_sio
modprobe cdc-acm

cd /lib/modules/

sudo wget https://web.archive.org/web/20211027134846/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/ch341.ko
sudo insmod /lib/modules/ch341.ko
sudo wget https://web.archive.org/web/20211027134846/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/cp210x.ko
sudo insmod /lib/modules/cp210x.ko
sudo wget https://web.archive.org/web/20211027134846/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/pl2303.ko
sudo insmod /lib/modules/pl2303.ko
sudo wget https://web.archive.org/web/20211027134846/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/ti_usb_3410_5052.ko
sudo insmod /lib/modules/ti_usb_3410_5052.ko

# Configure an autoload script

cd  /usr/local/etc/rc.d/
sudo wget https://web.archive.org/web/20211027134846/http://www.jadahl.com/iperf-arp-scan/DSM_7.0/apollolake/start-usb-drivers.sh
sudo chmod +x start-usb-drivers.sh

# Make sure your devices are recongnized

sudo /usr/local/etc/rc.d/start-usb-drivers.sh start

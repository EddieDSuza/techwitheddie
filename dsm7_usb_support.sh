# compiled USB Modules

cd /lib/modules/

sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/braswell/ch341.ko
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/braswell/cp210x.ko
sudo wget https://github.com/robertklep/dsm7-usb-serial-drivers/raw/main/modules/braswell/pl2303.ko # optional

# Configure an autoload script

cd  /usr/local/etc/rc.d/
sudo wget https://raw.githubusercontent.com/robertklep/dsm7-usb-serial-drivers/main/usb-serial-drivers.sh
sudo chmod +x usb-serial-drivers.sh

# Make sure your devices are recongnized

sudo /usr/local/etc/rc.d/usb-serial-drivers.sh start

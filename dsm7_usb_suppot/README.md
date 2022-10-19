Download drivers as you need and copy to your NAS. Place the drivers in /lib/modules folder.

Follow detailed instructions that is provided here https://github.com/EddieDSuza/techwitheddie/blob/main/dsm7_usb_suppot/dsm7_enable_usb_support

You can also download the start-usb-drivers.sh script and copy to folder: /usr/local/etc/rc.d/start-usb-drivers.sh
Then: chmod +x /usr/local/etc/rc.d/start-usb-drivers.sh
The the drivers will be loaded when you reboot your NAS.

You must edit the start-usb-drivers.sh script if you want to load another driver.

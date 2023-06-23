# Edit Boot Config
sudo nano /boot/config.txt

# Uncomment some or all of these to enable the optional hardware interfaces
dtparam=i2c_arm=on
dtparam=i2s=on

# Add > Additional overlays and parameters are documented /boot/overlays/README
dtoverlay=disable-bt
dtoverlay=disable-wifi

# add > [all]
enable_uart=1

# Disable Serial Port & Enable Serial Power
sudo raspi-config

# configure the RTC module
sudo hwclock --systohc 
sudo hwclock --verbose

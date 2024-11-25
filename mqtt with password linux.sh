#MQTT Install
sudo apt-get install mosquitto -y
sudo apt-get install mosquitto-clients
 
#Configure MQTT
sudo nano /etc/mosquitto/mosquitto.conf
 
#Append these lines to the bottom of the file and save it:
allow_anonymous false
password_file /etc/mosquitto/pwfile
listener 1883
        
#Set an MQTT username and password
 sudo mosquitto_passwd -c /etc/mosquitto/pwfile YOUR-NEW-MQTT-USERNAME
 
#Test the broker
mosquitto_sub -d -u YOUR-MQTT-USERNAME -P YOUR-MQTT-PASSWORD -t dev/test

#start Service
sudo systemctl enable mosquitto
sudo systemctl start mosquitto

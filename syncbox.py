import logging
import requests
import time

while True:
    r = requests.post('https://YOUR.IP.ADDRESS.HERE/api/v1/registrations',
                      json={
                          "appName": "homebridge",
                          "appSecret": "MDAwMTExMDAwMTExMDAwMTExMDAwMTExMDAwMTExMDA=",
                          "instanceName": "homebridge"
                      }, verify=False)
    print(r.status_code, r.json())
    if r.status_code == 200:
        break
    time.sleep(0.1)

print("Done")

import os
import pandas as pd
from subprocess import check_output

import requests
from flask import render_template

from app import app

FILE_DIR_PATH = os.path.dirname(__file__)
SCAN_DATA_PATH = os.path.join(FILE_DIR_PATH, '../../Output/scannedlist.xml')


def getPublicIP():
    print("GETPUBLICIP CALLED")
    return requests.get("http://ipecho.net/plain?").text


@app.route('/api/get_public_ip')
def getpublicip():
    return getPublicIP()


@app.route('/api/get_device_list')
def get_device_list():
    return


# background process happening without any refreshing
@app.route('/api/background_process_test')
def background_process_test():
    print("someone wants the background test")
    return 'Hi from the web API :)'


@app.route('/')
@app.route('/index')
def index():
    scanresults = None

    if os.path.exists(SCAN_DATA_PATH):
        scanresults = ""
        with open(SCAN_DATA_PATH, 'r') as f:
            for line in f:
                scanresults += line
    else:
        print("scannedlist.xml does not exist.")
        print(os.path.abspath(SCAN_DATA_PATH))
        scanresults = None

    return render_template('index.html', 
                           scanresults=scanresults,
                           hostname=hostname(),
                           interface=interface(),
                           getpublicip=getpublicip(),
                           gateway=gateway(),
                           Shodan='https://shodan.io/search?query=')


def make_device_list():
     device_list = check_output(['app/boomsetupscan.sh', ''])
     return device_list


def get_device_list():
    txt_headers = ['IP', 'MAC ADDRESS', 'MANUFACTURER']
    txt_cols = [0, 1, 4]
    device_list = pd.read_fwf('Output/Devices.txt', header=None, usecols=txt_cols, names=txt_headers)
    device_list = device_list.dropna()
    device_list.to_json(r'Output/Devices.json')
    return device_list


def hostname():
    return check_output(['hostname', '-I']).decode('UTF-8')


def interface():
    return check_output(['app/NetInfo.sh']).decode('UTF-8')


def gateway():
    return check_output(['app/getGateway.sh']).decode('UTF-8')

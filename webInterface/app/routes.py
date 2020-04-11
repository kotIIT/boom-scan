import json
import os
import pandas as pd
from subprocess import check_output

import requests
from flask import render_template

from app import app

FILE_DIR_PATH = os.path.dirname(__file__)
SCAN_DATA_PATH = os.path.join(FILE_DIR_PATH, '../Output/scannedsubnet.xml')


def getPublicIP():
    print("GETPUBLICIP CALLED")
    return requests.get("http://ipecho.net/plain?").text


@app.route('/api/get_public_ip')
def getpublicip():
    return getPublicIP()


@app.route('/api/make_device_list')
def makedevicelist():
    print("make_device_list")

    return make_device_list()


@app.route('/api/get_device_list')
def getdevicelist():
    generate_device_list_json()

    f = open('Output/Devices.json', 'r')
    object = json.load(f)
    f.close()

    return object


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
    print(os.getcwd())
    device_list = check_output(['sudo', 'bash', '-x', 'app/boomsetupscan.sh', 'd'])
    return device_list


def generate_device_list_json():
    txt_headers = ['IP', 'MAC ADDRESS', 'MANUFACTURER']
    txt_cols = [0, 1, 4]
    device_list = pd.read_fwf('Output/Devices.txt', header=None, usecols=txt_cols, names=txt_headers)
    device_list = device_list.dropna()
    device_list.to_json(r'Output/Devices.json')


def hostname():
    return check_output(['sudo', 'app/boomsetupscan.sh', 'sub']).decode('UTF-8')


def interface():
    return check_output(['app/boomsetupscan.sh', 'iface']).decode('UTF-8')


def gateway():
    return check_output(['app/boomsetupscan.sh', 'gate']).decode('UTF-8')

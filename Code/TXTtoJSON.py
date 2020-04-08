import pandas as pd


def get_device_list():
    txt_headers = ['IP', 'MAC ADDRESS', 'MANUFACTURER']
    txt_cols = [0, 1, 4]
    device_list = pd.read_fwf('Output/Devices.txt', header=None, usecols=txt_cols, names=txt_headers)
    device_list = device_list.dropna()
    device_list.to_json(r'Output/Devices.json')
    return device_list


print(get_device_list())

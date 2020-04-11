#!/usr/bin/env bash

myIP="$(hostname -I)"
myInterface="$(ip -o -f inet addr show | awk '/scope global/ {print $2}')"
mySubnet="$(ip -o -f inet addr show | awk '/scope global/ {print $4}')"
outFile="Output/Devices.txt"
IPList="Output/IPs.txt"
getDeviceList()
{
    echo "Performing ARP Scan..."
    touch $outFile
    sudo netdiscover -r $mySubnet  -PN > $outFile
    sed  -i '$d' $outFile
    echo "Devices are:"
    cat $outFile
    awk '{print $1} ' $outFile > $IPList


}

getDeviceList
#!/usr/bin/env bash
#automated enumeration
#this script should perform automated scans by pulling network info from DHCP
#what to do
#get device IP address
myIP="$(hostname -I)"
myInterface="$(ip -o -f inet addr show | awk '/scope global/ {print $2}')"
mySubnet="$(ip -o -f inet addr show | awk '/scope global/ {print $4}')"
gateway="$(ip r | awk '/default via/ {print $3}')"

outFile="Output/Devices.txt"
IPList="Output/IPs.txt"
chmod 755 $outFile
chmod 755 $IPList

#get a list of devices on the network
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

#Perform a scripted network scan to find devices
#Identify Open Ports
#Identify Default Credentials

ScanSubnet(){
    File="Output/scannedsubnet.xml"
    newFile="app/static/scannedsubnet.html"
    echo 
    echo "Scanning Subnet"
    echo $mySubnet
    sudo nmap $mySubnet -A --open  -A -oX  $File
    sudo chmod 755 $File
    xsltproc $File -o $newFile
}

ScanList(){
    File="Output/scannedlist.xml"
    newFile="app/static/scannedlist.html"
    echo
    echo "Scanning Listed Devices..."
    sudo nmap -iL  $IPList -A --open -oX  $File
    sudo chmod 755 $File
    xsltproc $File -o $newFile

}

ScanFast(){
    File="Output/fastportscan.xml"
    newFile="app/static/fastportscan.html"
    echo
    echo "Scanning Listed Devices..."
    sudo nmap -iL  $IPList -F  -oX  $File
    sudo chmod 755 $File
    xsltproc $File -o $newFile
}

ScanPort(){
    File='Output/Port'$arg'.xml'
    newFile='app/static/Port'$arg'.html'
    txtOutput='Output/Port'$arg'.txt'
    echo "Scanning for port" $arg
    nmap -iL  $IPList  -p$arg --open -oX $File
    sudo chmod 755 $File
    xsltproc $File -o $newFile

    #gawk -i inplace '/open/{print $2} ' $File
    #sed -i '1d'  $File
    #cat $File
    }


#create optional menu to run script in terminal
Menu()
{
    echo "Enter 'ip' to find your IP and subnet"
    echo "Enter 'iface' to list device interface"
    echo "Enter the Port number to check if the port is open in the device list"
    echo ""
    echo "Enter d. to listen for devices on the network"
    echo "Enter l. to display the devices on the network (must run "d" first)"
    echo "Enter to dl display list of IP Addresses"
    echo "Enter sf to do a fast port scan of the list"
    echo "Enter sl to perform a scripted scan on the listed devices"
    echo "Enter ss. to scan the entire subnet, perform OS Detection and Scripted Scanning"



}


arg=$1

Output()
{
    case  $arg in
    l)echo "List of devices on the network: " 
      cat $IPList;;
    ip) echo $myIP;;
    iface) echo $myInterface;;
    sub) echo $mySubnet;;
    gate) echo $gateway;;
    dl) cat $outFile;;
    d) getDeviceList ;;
    sf|SF) ScanFast;;
    SS |ss) ScanSubnet ;;
    SL | sl) ScanList;;
    $1 | m)  Menu;;
    q) exit 0;;
    $arg) ScanPort ;;
esac

}


Output




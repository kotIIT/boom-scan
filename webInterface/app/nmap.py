import nmap

nm = nmap.PortScanner()
#nm.scan(hosts='-iL Output/IPs.txt -F')
nm.command_line('nmap -iL /Output/IPs.txt -F -oX Output/fastscan.xml')
'nmap -iL /Output/IPs.txt -F -oX Output/fastscan.xml'

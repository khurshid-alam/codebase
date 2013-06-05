Networking
----------


IP, Interface & Gateway:

ip route ls


Code: https://github.com/khurshid-alam/codebase/blob/master/Bash/get_ip.sh

----------


**Hostname:**

**Find Online hosts in local network:**


    gateway=$(ip route ls | awk '{print $3}' | grep '^[0-9]')
    
    nmap $1 $2 $3 $gateway/24

OR

    nmap -SP 192.168.169.*

OR 

    arp -a

**Find Host from IP:**

    nslookup <ip>
    dig -x <ip>
    host <ip>
    getent hosts <ip>

http://askubuntu.com/questions/126467/how-to-find-a-computer-name-in-a-lan-from-the-ip-address

**Name resolution on home LAN:**

> To resolve Avahi hostname, other computers should have libnss-mdns 
> installed.
> 
> Another option, if you are the network administrator is to distribute
> a private DNS address by DHCP (I your computers are configured by
> DHCP). For small network, dnsmasq  is good combined package
> (DNS+DHCP). It allows you to serve simply your /etc/hosts to the
> network.

http://askubuntu.com/questions/20313/name-resolution-on-home-lan


----------



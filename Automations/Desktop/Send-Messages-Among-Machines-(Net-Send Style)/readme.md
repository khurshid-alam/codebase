Send messages between 2 Ubuntu PCs (Net Send Style)
---------------------------------------------------

While commenting on the answer (by Matt) of the [askubuntu question][1] I have shown how netacat can be setup on the server side, so when a notification is received from client (over), it also show the remote client ip along with message where both, server & client use libnotify (notify-osd in ubuntu) library.

![nc notification][2]

**Requiement:**
1. netcat-openbsd package.
2. libnotify
3. 

Here we are using notify-osd to create poup notification. One can also use zenity


Steps:
--------

**Install necessary packages on server & clients:**

sudo apt-get install netcat-openbsd libnotify-bin

**On server create netcat bash-script & run the daemon:**

'''
   
    #!/bin/bash
    
    port=3333

    while true; do nc -l -v 3333 2> status | while read msg; do ip=$(cat status | grep -o -P '(?<=from).*(?=port)') && notify-send "$ip" "$msg" -i gtk-network; done ; done

''' 

What is does is, redirect stderr to a file called status; then it reads ip of remote connector from the file; finally shows the ip in notify-osd message.
    
save the file as ns.
    
   

     chmod a+x ns

    ./ns
    
**Now simply open port 3333 & send message to the server:**

    nc 192.168.x.x 3333

    Wow its magic!


  [1]: http://askubuntu.com/questions/31582/send-messages-between-2-ubuntu-pcs-net-send-style
  [2]: http://i.stack.imgur.com/y3pGs.png
Transmission-Shutdown-Script
========

> Github Gist: https://gist.github.com/khurshid-alam/6474227

This is the transmission shutdown script I wrote for a [askubuntu question](http://askubuntu.com/questions/202537/transmission-shutdown-script-for-multiple-torrents) with the help of transmission RPC interface.  

**What it Does?**

1. Pause or remove completed torrents after they are completed.

2. Send a pushover notification (with curl)[optional]

3. Send a twitter notification (requires twidge)[optional]

4. Suspend/Shutdown Computer OR leave it as it is.





----------


**Setup**
---------

On Ubuntu

    sudo apt-get install libnotify-bin





On Ubuntu >= 13.04 (For twitter notification):

    sudo apt-get install transmission-cli
	sudo add-apt-repository ppa:moorhen-core/moorhen-apps
	sudo apt-get install twidge

For `suspend` action on non-Ubuntu distro (Ubuntu uses Upower) install powermanagement-interface package

    sudo apt-get install powermanagement-interface

**After installation:**


1. Get the code from [github-gist][1] & save the file as `trsm` anywhere on your hard-drive. Make the file executable ` chmod a+x trsm` .

2. Login to pushover & copy your *user key*. Paste it under `user-key` in the script.

3. If you want notifications send with nice looking application (transmission) icon just create a fake app in pushover with transmission icon & then copy the application key (API/Token key) & paste it under `app-key` in the script.

4. For twitter setup see twidge documentation.

5. Open transmission. Go to preference->web. Enable web client (default port `9091`) & enable user authentication . Choose a username & password. Put that username & password in the script as `username` & `password` respectively.

6. Click open web-client to check if it is working properly.

7. Finally save the script & go to downloading tab (in transmission preference) & click `call script when torrent is complete`. Select the respective script.


----------

**Script**
----------

```

#!/bin/bash


user-key=" "  #put your pushover user-key
app-key=" "  #put your pushover application-key
device=" "    #Your device name in pushover

username=" "  # Transmission remote username
password=" "   # Transmission remote password



sleep 100s

# default display on current host
DISPLAY=:0.0

# authorize transmission
trsm="transmission-remote --auth $username:$password"

# find out number of torrent

TORRENTLIST=`$trsm --list | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=' ' --fields=1`

for TORRENTID in $TORRENTLIST
do
 echo "* * * * * Operations on torrent ID $TORRENTID starting. * * * * *"

 #echo $TORRENTID

 DL_COMPLETED=`$trsm --torrent $TORRENTID --info | grep "Percent Done: 100%"`

 #echo $DL_COMPLETED

# pause completed torrents & get those torrent names.

 if [ "$DL_COMPLETED" != "" ]; then
  $trsm --torrent $TORRENTID --stop
  trname=`$trsm --torrent $TORRENTID --info | grep "Name:" | awk -F: '{print $NF}'`

  # post an update to twitter

  echo "$trname download was completed" | twidge update  # Put "#" if you don't need this.

  # push update for pushover
  
  curl -s \
	-F "token=$user-key" \
	-F "user=$app-key" \
        # -F "device=$device" \  # uncomment, if you want to send notification to a particular device.
	-F "title=Download Finished" \
	-F "message=$trname download has completed." \
	http://api.pushover.net/1/messages > /dev/null

  # The following codes works assuming One take advantage of gnome-power-manager by setting "black screen after 2/5/10/.. minitues ". 
  # if monitor(Including laptop screen but EXCLUDING external monitor) is on, it will  just force blank the screen, if not, it will shutdown/suspend or leave it as it is.
  # Modify it as per your requirement.

  STATUS=`xset -display $DISPLAY -q | grep 'Monitor'`
  #echo $STATUS

  if [ "$STATUS" == "  Monitor is On" ]
  then
	  notify-send "Downloads Complete" "turning off the screen now"
          xset dpms force off

  else
	  notify-send "Downloads Complete" "$trname"

        # uncomment to shutdown the computer
        #dbus-send --session --type=method_call --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.RequestShutdown

        # uncomment to suspend (on ubuntu)
        #dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend

        # uncomment to suspend (on Linux) (requires powermanagement-interface package)
        #pmi action suspend

 else
  echo "Torrent #$TORRENTID is not completed. Ignoring."
 fi

done

```


  [1]: https://gist.github.com/khurshid-alam/6474227
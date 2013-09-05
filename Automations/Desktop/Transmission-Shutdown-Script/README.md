Transmission-Shutdown-Script
========

This is the transmission shutdown script I wrote for a [askubuntu question](http://askubuntu.com/questions/202537/transmission-shutdown-script-for-multiple-torrents) with the help of transmission RPC interface.  

**What it Does?**

1. Pause or remove completed torrents after they are completed.

2. Send a pushover notification (with curl)[optional]

3. Send a twitter notification (requires twidge)[optional]

4. Suspend/Shutdown Computer OR leave it as it is.


----------


**Setup**

On Ubuntu >= 13.04:

    sudo apt-get install transmission-cli
	sudo add-apt-repository ppa:moorhen-core/moorhen-apps
	sudo apt-get install twidge



Login to pushover & copy your *user key*. Paste it under `user-key` in the script.

If you want notifications send with nice looking application (transmission) icon just create a fake app in pushover with transmission icon & then copy the application key (API/Token key) & paste it under `app-key` in the script.


----------

**Script**











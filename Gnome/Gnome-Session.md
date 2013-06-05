Gnome-session
-------------

**Log-Out/Restart:**

**Logout:**

`gnome-session-save --logout`    

> gnome2; ctrl+alt+backspace

OR

`DISPLAY=:0 gnome-session-quit --logout --no-prompt`  #gnome3



**Restart gnome-session:**

    killall gnome-session


**Recover From Freeze:**

`CTRL+ALT+F2`   #switches to tty2

    Display=:0 gnome-session-save --force-logout

OR

    Display=:0 killall gnome-session

OR

    kill -9 -1

    logout

> CTRL+ALT+F8  #switches back to gdm login screen.






Gnome-session services details:
http://gnomeshell.wordpress.com/2011/08/28/manage-the-startup-applications/ [Manage the startup applications | The GNOME Shell]


----------


**Run a Script On Boot:**

**Method1:**

In Ubuntu (and I presume Xubuntu), the file you want is /etc/rc.local. This script will be run near or at the end of the boot process. Thus, everything should be up by this time.

Add your script that you want to run on boot process there, for example:
sh /home/ivan/iptables.sh echo 'Iptable Configured!'
exit0

http://askubuntu.com/questions/88589/run-command-at-boot-as-root


**Method2:**


The traditional way to start services in Linux was to place a script in /etc/init.d, and then use the update-rc.d command (or in RedHat based distros, chkconfig) to enable/disable it. This command, btw, uses some mildly complicated logic to create symlinks in /etc/rc#.d, that control the order of starting services. If you run ls /etc/rc2.d you can see the order that services will be killed (K##xxxx) and started (S##xxxx).

Example:

To do this, make your script executable, copy it to /etc/init.d and create a symbolic link to the script in /etc/rc2.d if you want it executed in the default multi-user runlevel (runlevel 2). You should rename it with an S followed by the order you want it executed in, respective to the other links in there.

Make script executable:

    sudo chmod u+x myscript.sh

Copy it to /etc/init.d:

    sudo cp myscript /etc/init.d

Create a symlink in rc2.d:

    cd /etc/rc2.d

    sudo ln -s /etc/init.d/myscript.sh

Rename it according to the naming scheme:

    sudo mv myscript.sh S70myscript.sh


> For more information, see the README files in /etc/init.d and
> /etc/rc2.d.

http://askubuntu.com/questions/72123/how-to-write-an-init-script-that-will-execute-an-existing-start-script


**Upstart:**

Upstart uses job definition files in /etc/init to define on what events a service should be started. So, while the system is booting, upstart processes various events, and then can start multiple services in parallel. This allows them to fully utilize the resources of the system, for instance, by starting a disk-bound service up while another CPU-bound service runs, or while the network is waiting for a dynamic IP address to be assigned.

You can see all of the upstart job files by running ls /etc/init/*.conf

Let me just stop here and say that if you don't know what a service is, or what it does, DO NOT disable it!

Not all services have been converted to upstart. While working on the server team at Canonical for the past few months, I've worked on a number of converted job files, and the nicest part is that it allows one to get rid of all the script "magic" and just put in a few commands here and there to define exactly how to start the service, and nothing more. But for now, only a handful of traditional network services, like squid and samba, have been converted.

**Example1:**

Create a file /etc/init/bruce_script.conf (you need to create the file as root) containing something like this:

    description "Bruce's boot script"
    start on filesystem and net-device-up IFACE=eth0
    task
    exec su -c '/home/bruce/script' bruce

**Example2:**

Simply place this file my_script.conf into /etc/init

    # Start when pc starts up
    start on runlevel [2345]
    # Stop when pc shuts down 
    stop on runlevel [016]
    
    # Start Script 
    exec my_start_script
    # Stop Script 
    pre-stop my_stop_script

> The Pre Stop will script contain code to kill your 3 process and is
> optional, when the service is stopped sigterm will be sent to the
> my_start_script process but depending on your script it may already
> have exited.
> 
> You can test your new service by running sudo service my_script start
> and sudo service my_script stop


**Disable service from running at boot:**

Starting with the version of upstart that will be in 11.04, there is a new keyword that disables the 'start on' and 'stop on' stanzas, it is 'manual'. So another way to disable the service as of 11.04 is to do:

command using sudo

    echo 'manual' | sudo tee /etc/init/mysql.override

command from root shell

    echo manual >> /etc/init/smbd.conf

**Gui-Tools:**

bum
jobs-admin  #support upstart.







**source:**

http://askubuntu.com/questions/19320/whats-the-recommend-way-to-enable-disable-services/20347#20347

http://askubuntu.com/questions/9806/getting-a-script-to-run-on-boot-not-on-login



**Method3:**

Add the path of the script under  ~/.profile . For example adding line like this: ~/.scripts/batteryfull.sh .

**Method4:**

using cron. The special time value of @reboot will spawn your job at each reboot as your user. For example, run crontab -e and use:

@reboot /home/yourself/bin/some_script_to_run
For more details on the special time formats, see man 5 crontab.


or use gnome-schedule.


**Method5:**

Add the link to the Startup Applications application in Ubuntu if you want to use the GUI. The downside of this is that it will only execute when you log in to the GUI (i.e. not for other users, and not if you don't log in to the Ubuntu Desktop environment).


----------


Run a script only at the very first boot:

**example1:**

Combining the first two answers Assuming you name your script /usr/local/bin/firstboot.sh put it at the end of /etc/rc.local (this scripts runs on every boot) the scripts goes like this


    #!/bin/bash
    
    FLAG="/var/log/firstboot.log"
    if [ ! -f $FLAG ]; then
       #Put here your initialization sentences
       echo "This is the first boot"
    
       #the next line creates an empty file so it won't run the next boot
       touch $FLAG
    else
       echo "Do nothing"
    fi

**example2:**

    start on desktop-session-start
    task
    
    env FLAGFILE=/run/.my_script_has_run
    
    pre-start script
      if [ -e $FLAGFILE ]; then
        stop
      fi
    end script
    
    script
      ...
      touch $FLAGFILE
    end script

This assumes Ubuntu 11.10 or later. Use /var/run for earlier releases. /run is cleared after every reboot, so this will be run again on the next boot, but never again. It will stop normally after the touch statement, so there's no need for a 'stop on'.

http://askubuntu.com/questions/106941/how-do-i-run-a-script-once-and-only-once-in-upstart

http://askubuntu.com/questions/156771/run-a-script-only-at-the-very-first-boot


----------------------------------------------------------------------------------------------------

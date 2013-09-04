GDM
===

Change Theme in GDM-2.32:
-------------------------

All you can do now is change the wallpaper, fonts, and theme like this

1. Logout of your current session and return to the GDM
2. Switch to the tty command line prompt using Ctrl-Alt-F1
3. Login using your normal login/password
4. at the command line prompt type: export DISPLAY=:0.0
5. then type: sudo -u gdm gnome-control-center
6. Switch back to the gdm screen using Ctrl+ALT+F7 or F8
7. The gnome-control-center should be loaded. Use it to configure your GDM.
8. Click on the Appearances icon, in appearances you can change your GDM's font, theme and background image.
9. Close the gnome-control-center and login normally.

**Method2:**

2. You can use this method to customize the gdm screen directly from your desktop. First, allow user gdm to connect to the X server, then run the gnome-appearance-properties and gconf-editor apps as user gdm:

**Code:**

    sudo -i
    xhost +SI:localuser:gdm  #add gdm to local user
    su gdm -s /bin/bash         #promt changes : gdm under root
    dbus-launch dconf-editor
    dbus-launch gnome-appearance-properties

**Cleanup:**

	exit 		#if its shows error prec Ctrl+C to kill jobs & then try exit
	xhost -SI:localuser:gdm 
    logout #exit from root user

    pkill gsksu


https://bbs.archlinux.org/viewtopic.php?id=110874

http://askubuntu.com/questions/64001/how-do-i-change-the-wallpaper-in-lightdm


----------


GDM Screenshot:
---------------

http://askubuntu.com/questions/50605/is-there-a-way-to-take-a-screenshot-of-your-log-in-screen-on-startup

http://askubuntu.com/questions/43458/how-can-i-take-a-screenshot-of-the-login-screen

Modify the file /etc/gdm/Init/Default, by adding the following line

(sleep 10; gnome-screenshot) &
just before the last exit 0 line. Then logout and wait 10 seconds for the interactive screenshot dialog to appear.

It propose the /tmp directory to save the image, in any case take attention to where you save the file, to found it later, after login.

Remember to remove the line inserted in the file /etc/gdm/Init/Default to remove this annoying screenshot dialog every time you login :)


----------


Xorg/Xserver



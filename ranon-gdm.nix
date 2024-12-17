# change the display manager
{
sudo systemctl enable gdm.service -f
sudo systemctl enable sddm.service -f
  };

# download the gdm-settings package

  yay -S gdm-settings

check:

/etc/dconf/profile/gdm


set XKBLAYOUT=us
/etc/vconsole.conf

# set Automatic login

/etc/gdm/custom.conf
[daemon]
AutomaticLogin=balltugger
AutomaticLoginEnable=True

/var/lib/AccountsService/users/balltugger

XSession=gnome-xorg

sudo groupadd nopasswdLogin

sudo usermod -aG balltugger nopasswdLogin

# Desktop Linux on Windows Subsystem For Linux (WSL)

What follows are distilled directions for getting a Debian system running on Windows.
Last tested in 2026-07 with Debian 13 and Windows 11.

These directions are distilled and edited from hints in [this post](https://askubuntu.com/questions/1252007/opening-ubuntu-20-04-desktop-on-wsl2).

I suspect this probably works on Ubuntu and derivatives as well, but I haven't tested it fully.

## Steps:

`1.` [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install); or just `wsl --install --web-download`.  This will install the default Ubuntu VM but these instructions are guaranteed to work with Debian.  See that link for how to download and install other WSL 'distributions' (VM images).

`2.` Once you have your WSL distro running, do this in its terminal:

```
# from https://github.com/microsoft/WSL/issues/8867#issuecomment-1256344696
# fixes acpi install issues
sudo ln -s /dev/null /etc/systemd/system/acpid.service
sudo ln -s /dev/null /etc/systemd/system/acpid.path

apt-get install xfce4 desktop-base xfce4-whiskermenu-plugin  xrdp
# If asked, select lightdm, although it probably doesn't matter

# open up rdp ports (use the IP address from Windows 'ipconfig' under "Ethernet adapter vEthernet (WSL (Hyper-V firewall))":
ufw allow in from 172.20.63.1 to any port 3350
ufw allow in from 172.20.63.1 to any port 3390

# Optionally, back up the default config
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak

# Windows Pro and higher are often already running RDP on 3389
# Prevent conflicts:
sudo sed -i 's/3389/3390/g' /etc/xrdp/xrdp.ini

# I also change this in xrdp.ini in order to try to disable encryption in RDP (it is assemed you trust the host since this is a local connection):
sudo sed -i 's/crypt_level=high/crypt_level=none/g' /etc/xrdp/xrdp.ini

# Prevent Wayland from being used in Xrdp.
F=/home/user/.xsessionrc
echo "export WAYLAND_DISPLAY=" >> $F && chown user:user $F && chmod 770 $F

# Optional, if you have more than one desktop environment installed:
echo startxfce4 > ~/.xsession

# Lastly restart the xrdp stuff, if running Systemd (which you should be):
sudo systemctl enable xrdp xrdp-sesman
sudo systemctl restart xrdp xrdp-sesman
## (if not running Systemd just start xrdp using 'service'):
sudo service xrdp start
```

`3.`  Set up a Remote Desktop Connection on the Windows host and connect.

## Remote Desktop Connection and Performance Notes

`1.` Don't forget to use the port you configured above in your remote desktop configuration in Windows.

`2.` For performance, you will probably wish to configure your RDP connection to use less colors.  Adjust as needed to balance looks and speed.

`3.` Inside the VM, you can disable display compositing (in XFCE, go to Settings / Window Manager Tweaks / Compositor to disable it completely).  You'll lose desktop effects and a smoother window dragging experience, but it will be noticeably faster.

## Bonus: Docker Containers

The above process works inside containers as well, not just WSL.




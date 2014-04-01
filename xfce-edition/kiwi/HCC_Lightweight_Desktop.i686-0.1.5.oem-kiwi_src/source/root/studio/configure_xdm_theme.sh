#!/bin/sh -x

echo "#====================================="
echo "# configuring XDM theme               "
echo "#-------------------------------------"

if [ -e /etc/X11/Xresources ]; then
  echo "xlogin*greeting: Login"                    >> /etc/X11/Xresources
  echo "xlogin*namePrompt: Name:\040"              >> /etc/X11/Xresources
  echo "xlogin*passwdPrompt: Password:\040"        >> /etc/X11/Xresources
  echo "xlogin*fail: Failed!"                      >> /etc/X11/Xresources
  echo "xlogin.Login.greetFont: 9x15bold"          >> /etc/X11/Xresources
  echo "xlogin.Login.promptFont: 6x13bold"         >> /etc/X11/Xresources
  echo "xlogin.Login.font: 6x13"                   >> /etc/X11/Xresources
  echo "xlogin.Login.failFont: 6x13"               >> /etc/X11/Xresources
  echo "xlogin*geometry: 300x200"                  >> /etc/X11/Xresources
  echo "xlogin*borderWidth: 1"                     >> /etc/X11/Xresources
  echo "xlogin*frameWidth: 0"                      >> /etc/X11/Xresources
  echo "xlogin*innerFramesWidth: 0"                >> /etc/X11/Xresources
  echo "xlogin*shdColor: black"                    >> /etc/X11/Xresources
  echo "xlogin*hiColor: black"                     >> /etc/X11/Xresources
  echo "xlogin*greetColor: white"                  >> /etc/X11/Xresources
  echo "xlogin*failColor: red"                     >> /etc/X11/Xresources
  echo "xlogin*promptColor: grey75"                >> /etc/X11/Xresources
  echo "xlogin*foreground: grey75"                 >> /etc/X11/Xresources
  echo "xlogin*background: black"                  >> /etc/X11/Xresources
  echo "xlogin*borderColor: grey50 "               >> /etc/X11/Xresources
fi

if [ -e /etc/icewm/preferences ]; then
  sed -i 's#DesktopBackgroundImage=.*#DesktopBackgroundImage="/etc/X11/xdm/BackGround.xpm"#' /etc/icewm/preferences
fi

if [ -e /etc/X11/xdm/Xsetup ]; then
  sed -i 's#^exit 0$#kill `cat /var/run/xconsole.pid`;/sbin/startproc /usr/bin/icewmbg || /usr/bin/xsetroot -solid lightgray;\\nexit 0#g' /etc/X11/xdm/Xsetup
fi

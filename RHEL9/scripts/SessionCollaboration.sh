#!/usr/bin/env bash
#https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/customizing_the_gnome_desktop_environment/enabling-and-enforcing-gnome-shell-extensions_customizing-the-gnome-desktop-environment
#https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfiguringSessionCollaborationonLinuxDesktops.html
cd /tmp/PackerBuildFiles/SoftwareDownloads/
mkdir "appindicatorsupport@rgcjonas.gmail.com"
unzip ./appindicatorsupportrgcjonas.gmail.com.v42.shell-extension.zip -d "appindicatorsupport@rgcjonas.gmail.com/"
mv "appindicatorsupport@rgcjonas.gmail.com" "/usr/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com"
chmod -R 755 "/usr/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com/"
cd /tmp/PackerBuildFiles/OtherFiles/
cp ./00-extensions.txt /etc/dconf/db/local.d/00-extensions
chmod 744 /etc/dconf/db/local.d/00-extensions
dconf update
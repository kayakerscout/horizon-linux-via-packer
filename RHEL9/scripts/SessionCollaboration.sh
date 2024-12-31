#!/usr/bin/env bash
#https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/customizing_the_gnome_desktop_environment/enabling-and-enforcing-gnome-shell-extensions_customizing-the-gnome-desktop-environment
#https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfiguringSessionCollaborationonLinuxDesktops.html
cd /tmp/PackerBuildFiles/SoftwareDownloads/
base_name="appindicatorsupport@rgcjonas.gmail.com"
unzip ./${base_name}.v42.shell-extension.zip -d "${base_name}/"
mv "${base_name}" "/usr/share/gnome-shell/extensions"
chmod -R 755 "/usr/share/gnome-shell/extensions/${base_name}/"
cd /tmp/PackerBuildFiles/OtherFiles/
cp ./00-extensions.txt /etc/dconf/db/local.d/00-extensions
chmod 644 /etc/dconf/db/local.d/00-extensions
dconf update
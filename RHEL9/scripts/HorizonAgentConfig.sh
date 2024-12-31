#!/usr/bin/env bash
#See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/EditConfigurationFilesonaLinuxDesktop.html for details on avalible options and option values
#Enable clipboard in both directions
 sed -E 's/#Clipboard.Direction=1/Clipboard.Direction=1/' /etc/vmware/config -i
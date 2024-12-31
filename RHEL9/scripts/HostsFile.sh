#!/usr/bin/env bash
# add hostname as entries for 127.0.0.1 address in /etc/hosts https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
cp /etc/hosts /etc/hosts.bak
sed 's/^\(127\.0\.0\.1\)\([[:space:]]*\)\([[:alnum:]][[:print:]]*\)/\1\2'`hostname --fqdn`' '`hostname --short`' \3/' /etc/hosts -i

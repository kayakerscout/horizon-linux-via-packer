#!/usr/bin/env bash
#Check if virsh is a valid command. If so run commands from Horizon documentation, step 10 on https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html.
if command -v virsh; then
  virsh net-destroy default
  virsh net-undefine default
  service libvirtd restart;
fi
#/usr/bin/env bash
#DKMS steps that need to run as privilaged user for VHCI isb redirection driver.
#https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#vhci_driver_for_usb_redirection
cd /tmp/PackerBuildFiles/SoftwareDownloads/
cp -r ./vhci-hcd-1.15 /usr/src/usb-vhci-hcd-1.15
cp /tmp/PackerBuildFiles/OtherFiles/vhci-dkms.conf /usr/src/usb-vhci-hcd-1.15/dkms.conf
dkms add usb-vhci-hcd/1.15
dkms build usb-vhci-hcd/1.15
dkms install usb-vhci-hcd/1.15
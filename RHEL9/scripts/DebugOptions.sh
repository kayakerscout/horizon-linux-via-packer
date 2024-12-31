#!/usr/bin/env bash
#Documentation for all avalible options and values: https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/EditConfigurationFilesonaLinuxDesktop.html#configuration_options_in_config

#Smartcard Redirection Log Level [info | debug]
#sed -E 's/#VVC.ScRedir.logLevel=debug/VVC.ScRedir.logLevel=debug/' /etc/vmware/config -i

#PC/SC smartcard daemon [info | debug]
#sed -E 's/#pcscd.logLevel=debug/pcscd.logLevel=debug/' /etc/vmware/config -i

#Real Time Audio Video Log Level (rtav) [error | info | debug | trace]
#sed -E 's/#RTAV.logLevel=debug/RTAV.logLevel=debug/' /etc/vmware/config -i

#Client Drive Redirection (cdr) [error | warn | info | debug | trace | verbose]
#sed -E 's/#cdrserver.logLevel=debug/cdrserver.logLevel=debug/' /etc/vmware/config -i

#vmware-vvcProxy-Node Log Level [ fatal | error | warn | info | debug | trace | all ]
#sed -E 's/#vvc.logLevel=debug/vvc.logLevel=debug/' /etc/vmware/config -i

#vmware-vdpService-Server Log Level 
#sed -E 's/#vdpservice.log.logLevel=debug/vdpservice.log.logLevel=debug/' /etc/vmware/config -i

#Blast Protocol Statistics in mks log
#sed -E 's/#RemoteDisplay.enableStats=FALSE/RemoteDisplay.enableStats=TRUE/' /etc/vmware/config -i

#USB redirection plugin Log Level [error | warn | info | debug | trace | verbose]
#sed -E 's/#UsbRedirPlugin.log.logLevel=debug/UsbRedirPlugin.log.logLevel=debug/' /etc/vmware/config -i

#USB redirection Log Level [error | warn | info | debug | trace | verbose]
#sed -E 's/#UsbRedirServer.log.logLevel=debug/UsbRedirServer.log.logLevel=debug/' /etc/vmware/config -i
#sed -E 's/#UsbRedirServer.log.throttleBytesPerSec=-1/UsbRedirServer.log.throttleBytesPerSec=-1/' /etc/vmware/config -i

#TrueSSO Logging [error | warn | info | debug | trace | verbose]
#sed -E 's/#VMWPkcs11Plugin.log.enable=true/VMWPkcs11Plugin.log.enable=true/' /etc/vmware/config -i
#sed -E 's/#VMWPkcs11Plugin.log.logLevel=debug/VMWPkcs11Plugin.log.logLevel=debug/' /etc/vmware/config -i

#Session Collaboration Log Level [error | info | debug]
#sed -E 's/#collaboration.logLevel=debug/collaboration.logLevel=debug/' /etc/vmware/config -i

#Blast Sever Log Level [error | warn | info | debug | trace | verbose]
#sed -E 's/#BlastServer.log.logLevel=debug/BlastServer.log.logLevel=debug/' /etc/vmware/config -i

#Blast Proxy Log Level [error | warn | info | debug | trace | verbose]
#sed -E 's/#BlastProxy.log.logLevel=debug/BlastProxy.log.logLevel=debug/' /etc/vmware/config -i
#sed -E 's/#BlastProxy.log.throttleBytesPerSec=-1/BlastProxy.log.throttleBytesPerSec=-1/' /etc/vmware/config -i

#Desktop Daeomon Log Level  [error | warn | info | debug | trace | verbose]
#sed -E 's/#DesktopDaemon.log.logLevel=debug/DesktopDaemon.log.logLevel=debug/' /etc/vmware/config -i

#Desktop Worker Log Level [error | warn | info | debug | trace | verbose]
#sed -E 's/#DesktopWorker.log.logLevel=debug/DesktopWorker.log.logLevel=debug/' /etc/vmware/config -i

#Desktop Controller Log Level [ error | warn | info | debug | trace | verbose]
#sed -E 's/#DesktopController.log.logLevel=debug/DesktopController.log.logLevel=debug/' /etc/vmware/config -i

#rde service log level [error | warn | info | debug]
#sed -E 's/#rdeSvc.logLevel=debug/rdeSvc.logLevel=debug/' /etc/vmware/config -i

#App Scanner Process Log Level [error | warn | info | debug]
#sed -E 's/#appScanner.logLevel=debug/appScanner.logLevel=debug/' /etc/vmware/config -i

#Printer Redirection Service Log Level [error | warn | info | debug]
#sed -E 's/#printSvc.logLevel=\"debug\"/printSvc.logLevel=\"debug\"/' /etc/vmware/config -i

#Greeter Log Level [warn | error | info | debug]
#sed -E 's/#Greeter.logLevel=debug/Greeter.logLevel=debug/' /etc/vmware/config -i

#Session Recording Library Log Level [ error | warn | info | debug | trace | verbose]
#sed -E 's/#VMBlastRec.log.logLevel=debug/VMBlastRec.log.logLevel=debug/' /etc/vmware/config -i

#Options for sssd debugging/logging.
#See man page for sssd, https://www.mankier.com/5/sssd.conf#General_Options for debug level discussion 
#sed -E '/\[pam]/ a debug = 9'  /etc/sssd/sssd.conf -i
#sed -E '/\[sssd]/ a debug = 9'  /etc/sssd/sssd.conf -i
#See https://www.mankier.com/5/sssd.conf#Special_Sections-The_%5Bsssd%5D_section for certificate verification option, do not disable in production
#sed -E '/\[sssd]/ a certificate_verification = no_ocsp, no_verification'  /etc/sssd/sssd.conf -i
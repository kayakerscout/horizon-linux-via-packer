#/usr/bin/env bash
#Steps to build the V4L2Loopback driver for real time audio-video.
#Documented at https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstalltheV4L2LoopbackDriveronaLinuxMachine.html.
cd /tmp/PackerBuildFiles/SoftwareDownloads/
tar -xzvf ./v4l2loopback-0.12.5.tar.gz
cd ./v4l2loopback-0.12.5
patch -p1 < /tmp/PackerBuildFiles/VMwareHorizonAgent/VMware-horizonagent-linux-x86_64-2406-8.13.0-10030307256/resources/v4l2loopback/v4l2loopback.patch
make clean & make
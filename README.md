# Introduction
A packer template and associated scripts to automate building Linux desktops for Omnissa Horizon lab and proof of concept environments.

Focus is currently on configuration directly related leveraging Horizon functionality. As such this is best suited to lab and proof of concept images as many non-Horizon specific requirements for production use may be missing.  

# Usage
## Environment
You will need a system with a working Packer and one of the [command line iso creation tools](https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso#cd-rom-configuration) supported by the vSphere-ISO builder. As time of writing this is: xorriso, mkisofs, hdiutil, oscdimg.

You will also need a functional Horizon environment, including Connection Broker(s), TrueSSO enrollment server(s), and a recording server. You will likely need a unified access gateway (UAG) to test the TrueSSO functionality. However, this is not strictly required to build the virtual machine as no UAG is referenced in the build process. 

Additionally, you will need a working vSphere environment to host the virtual machine, and a Active Directory domain that is compatible and functional with your Horizon environment.

Test build system:
* [CentOS Stream 9](https://www.centos.org/) installed with the *Server with GUI* software selection. 
* Packer installed via the HashiCorp rpm repo. <br>See the [Package manager directions under the Linux heading](https://developer.hashicorp.com/packer/install?product_intent=packer#linux) on the Packer install documentation.<br>Most recently tested with Packer v1.11.2.
* Packer vSphere plugin. Installed via [packer init command](https://developer.hashicorp.com/packer/docs/commands/init).<br>Most recently tested with plugin v1.4.2.
* Xorriso installed via the CentOS appstream repo `dnf install xorriso`

Test build environment:
* Horizon 2406.
* vCenter and ESXi 8.0U3.

## Download the template repository
Clone or Download a copy of this repository and extract into a folder.

## Software to Download - Red Hat Enterprise Linux 9
Your need to download the required software packages and place them as noted below. **All noted paths are relative to the RHEL9 folder**.
* Horizon 8 Agent in tar.gz format. For Horizon 8.13.0 this file is is **VMware-horizonagent-linux-x86_64-2406-8.13.0-10030307256.tar.gz**. Place this file in **./PackerBuildFiles/HorizonAgent**.
* Horizon Recording Agent in .tar.gz format. Most recently tested with **Horizon.Recording.Linux.Agent-1.11.0.0.tar.gz**. Also place this file in **./PackerBuildFiles/HorizonAgent**. 
* App Indicator GNOME extension. As specified in the [session collaboration documentation](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfiguringSessionCollaborationonLinuxDesktops.html) Red Hat Enterprise Linux 9 needs **appindicatorsupportrgcjonas.gmail.com.v42.shell-extension.zip**. Place this file in **./PackerBuildFiles/SoftwareDownloads**.
* USB VHCI source code, see [Omnissa System Requirements](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#vhci_driver_for_usb_redirection) and [referenced Sourceforge project files](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#vhci_driver_for_usb_redirection). Download **vhci-hcd-1.15.tar.gz** and place it in **./PackerBuildFiles/SoftwareDownloads**.
* V4L2Loopback driver source package, version v0.12.5. See Omnissa documentation for [installing V4L2Loopback driver](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstalltheV4L2LoopbackDriveronaLinuxMachine.html) and referenced [tagged releases via the project's Github page](https://github.com/umlaeute/v4l2loopback/tags). Download **v4l2loopback-0.12.5.tar.gz** and place it in **./PackerBuildFiles/SoftwareDownloads**.

## Other Files
In addition to the software downloads, you will need to gather the required public certificates for your environment.
In **./PackerBuildFiles/TrueSSO_Certs/TrustedCAs** place the public certificates for any internal CAs for your environment. This includes the public certificates for each certificate authority that issues certificates for your Horizon Enrollment Servers, any intermediate certificate authorities used for your Active Directory Domain Services, and the appropriate root certificates for each.
You will need to build a **ssd_auth_ca_db.pem** file as described in the [Horizon documentation](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html). The contents of this file is the public certificate for each certificate authority that issues certificates for your Horizon Enrollment Servers followed by the intermediate and root certificates that complete the chain for those certificates. Place this file at **./PackerBuildFiles/TrueSSO_Certs**

## Populate Variables File
Finally you'll need to populate the variables file (or otherwise supply values for all required variables) to describe your Horizon environment. The majority of these variables have descriptive test in the packer template file, often including links for further information.

You will need:
* Uri, username, password, and trusted certificate thumbprint for your Horizon Recording Server. See the [Horizon Recording Server documentation](https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent) for further guidance.
* If you are using different versions of the Horizon Agent for Linux or the Horizon Recording Agent, uncomment the lines for the respective tar files and update file names as needed.
* File name, file path, and datastore name for the location of the Red Hat iso file. Tested most recently with *rhel-9.5-x86_64-boot.iso*.
* vCenter server fqdn, username, and password for the vSphere environment.
* Datacenter, cluster, and host names for the location to build the gold image virtual machine.
* Datastore, virtual machine and template folder, and network name to use for the virtual machine.
* Active Directory domain name, Active Directory netbios name, and domain controller/dns server name.
* Username and password for an account that can join the system to the domain.
* Active Directory organizational unit to place the computer object into.
* dns domain name for the virtual desktop.
* Username and password for the local account to be created on the system.
* Password in escaped form for use within the shell via pipe.
* Desired timezone. See [https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automatically_installing_rhel/kickstart-commands-and-options-reference_rhel-installer#timezone-required_kickstart-commands-for-system-configuration](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automatically_installing_rhel/kickstart-commands-and-options-reference_rhel-installer#timezone-required_kickstart-commands-for-system-configuration) for valid values.
* List of ntp servers.
* Organization ID and activation key for Red Hat Enterprise Linux subscription. See Red Hat's [Getting Started with Activation Keys on the Hybrid Cloud Console](https://docs.redhat.com/en/documentation/subscription_central/1-latest/html/getting_started_with_activation_keys_on_the_hybrid_cloud_console/index) for instructions on accessing or generating this key.

## Executing the Build
Once the above preparation steps have been completed, you should be ready to build a golden image virtual machine via Packer.<br>
```bash
/usr/bin/packer init ./RH9-SingleUserInstantClone.pkr.hcl
/usr/bin/packer build -var-file=./RH9-Common.pkvars.hcl ./RH9-SingleUserInstantClone.pkr.hcl
```
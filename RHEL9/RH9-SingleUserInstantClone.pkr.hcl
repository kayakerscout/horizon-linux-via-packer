packer {
  required_plugins {
    vsphere-iso = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

#Horizon Settings
variable "hv_agent_tar" {
  type        = string
  default     = "VMware-horizonagent-linux-x86_64-2406-8.13.0-10030307256.tar.gz"
  description = "File name tar.gz Horizon Agent Installer, for example VMware-horizonagent-linux-x86_64-2406-8.13.0-10030307256.tar.gz. Should be placed in PackerBuildFiles/HorizonAgent"
}
variable "hv_recording_tar" {
  type        = string
  default     = "Horizon.Recording.Linux.Agent-1.11.0.0.tar.gz"
  description = "File name tar.gz Horizon Recording Agent Installer, for example Horizon.Recording.Linux.Agent-1.11.0.0.tar.gz. Should be placed in PackerBuildFiles/HorizonAgent"
}
variable "hv_recording_server" {
  type        = string
  description = "Address for the Horizon Recording Server, as needed by the uri parameter for the recording agent installer. For example https://myrecodingserver.domain.tld:9443. See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent for further details/"
}
variable "hv_recording_user" {
  type        = string
  default     = "administrator"
  description = "Horizon Recording Server Username, as needed by the username parameter for the recording agent installer. See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/HorizonRecordingSettings.html and https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent for further details."
}
variable "hv_recording_pass" {
  type        = string
  sensitive   = true
  description = "Horizon Recording Server Password, as needed by the password parameter for the recording agent installer. See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/HorizonRecordingSettings.html and https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent for further details."
}
variable "hv_recording_cert" {
  type        = string
  description = "Horizon Recording Server Certificate Thumbprint, as needed by the trusted-ssl-certificate parameter for the recording agent installer. See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent for further details."
}

#Boot Media Settings
variable "iso_datastore" {
  type        = string
  description = "Name of the vSphere Datastore, without formatting, containing the Red Hat ISO media"
}
variable "iso_path" {
  type        = string
  description = "Path for the location within the vSphere Datastore for the Red Hat ISO media"
}
variable "iso_name" {
  type        = string
  default     = "rhel-9.5-x86_64-boot.iso"
  description = "Name of the Red Hat ISO media file, can be the boot or dvd file from Red Hat."
}

#vSphere Settings
variable "vm_vcenter" {
  type        = string
  description = "Hostname of the vSphere vCenter server."
}
variable "vm_vcenter_user" {
  type        = string
  description = "vCenter Username. See https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso#privileges for details of required privileges."
}
variable "vm_vcenter_pass" {
  type        = string
  sensitive   = true
  description = "Password for the vcenter User."
}
variable "vm_datacenter" {
  type        = string
  description = "Name of the Datacenter object within vCenter."
}
variable "vm_cluster" {
  type        = string
  description = "Name of the vSphere cluster that will host the Virtual Machine."
}
variable "vm_host" {
  type        = string
  description = "ESXi host for the virtual machine."
}
variable "vm_datastore" {
  type        = string
  description = "Datastore to host the virtual machine."
}
variable "vm_vm_folder" {
  type        = string
  description = "VM and Template folder location for the virtual machine."
}
variable "vm_prefix" {
  type        = string
  default     = "RH09"
  description = "VM name prefix, will be prepended to a date and time, limit 4 characters"
  validation {
    condition     = length(var.vm_prefix) <= 4
    error_message = "The vm_prefix value is limited to four characters in length."
  }
}
variable "vm_network_name" {
  type        = string
  description = "Name of the network port group."
}
variable "vm_build_note" {
  type        = string
  default     = ""
  description = "Uniquie notes about this build. Added to the VM's note field as well as the snapshot name."
    validation {
    condition     = length(var.vm_build_note) <= 80
    error_message = "The vm_build_note value is limited to 80 characters in length. This is the maximum length for a snapshot name."
  }
}

#AD Settings
variable "ad_domain_name" {
  type        = string
  description = "Fully qualified name of the Active Directory Domain."
}
variable "ad_domain_user" {
  type        = string
  description = "Domain user account to use for joining the Active Directory domain."
}
variable "ad_domain_pass" {
  type        = string
  sensitive   = true
  description = "Password for the ad_domain_user, used to join Active Directory."
}
variable "ad_netbios_string" {
  type        = string
  description = "NETBIOS name of the Active Directory Domain."
}
variable "ad_kdc_name" {
  type        = string
  description = "Name of the kdc within the domain. Referenced as dnsserver.mydomain.com in Horizon TrueSSO documentation https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html"
}
variable "ad_orgunit" {
  type        = string
  default     = "CN=Computers,DC=lab,DC=jley,DC=net"
  description = "DistinguishedName of the object within Active Directory to place the computer object."
}
variable "ad_fqdn_domain" {
  type        = string
  description = "DNS domain for the virtual machine."
}

#TargetVM Settings
variable "ssh_user" {
  type = string
  description = "Name of the local user account to create during desktop build. Is also used to connect Packer to the VM to complete build process."
}
variable "ssh_pass" {
  type      = string
  sensitive = true
  description = "Password to set for ssh_user."
}
variable "ssh_escaped_pass" {
  type      = string
  sensitive = true
  description = "Password value with any special characters excaped to use within Packer's execute_command configuration option. Will be piped into the sudo command via shell command. See https://developer.hashicorp.com/packer/docs/provisioners/shell#execute-command-example"
}
variable "ssh_timezone" {
  type        = string
  default     = "America/Chicago"
  description = "Timezone to place in the kickstart file, see https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automatically_installing_rhel/kickstart-commands-and-options-reference_rhel-installer#timezone-required_kickstart-commands-for-system-configuration for details of valid values."
}
variable "ssh_ntpservers" {
  type = set(string)
  description = "List of ntp servers. Minimal example: [\"ntpserver.domain.tld\"]" 
}

#RHEL Settings
variables {
  rhel_codeready_repo = "codeready-builder-for-rhel-9-x86_64-rpms"
  rhel_epel_rpm_url   = "https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm"
  rhel_vm_guest_type  = "rhel9_64Guest"
  rhel_sys_role       = "Red Hat Enterprise Linux Server"
  rhel_sys_sla        = "Self-Support"
  rhel_sys_usage      = "Development/Test"
}
variable "rhel_subscription_orgid" {
  type = string
  description = "Organization ID for the Red Hat Subscription."
}
variable "rhel_subscription_activation" {
  type = string
  description = "Activation Key for the Red Hat Subscription. See https://docs.redhat.com/en/documentation/subscription_central/1-latest/html/getting_started_with_activation_keys_on_the_hybrid_cloud_console/index for overview and 1.2 Creating an activation key for instructions."
}

locals {
  start_time     = timestamp()
  vm_name        = "${var.vm_prefix}-${formatdate("YYMMDDhhmm", local.start_time)}"
  vm_note_prefix = var.vm_build_note != "" ? "${var.vm_build_note}\n\n" : ""
  vm_snap_name   = var.vm_build_note != "" ? var.vm_build_note : "Created By Packer"
  ad_realm_name  = upper(var.ad_domain_name)
  ad_netbios     = upper(var.ad_netbios_string)
  ks_content = {
    ssh_user        = var.ssh_user,
    ssh_pass        = var.ssh_pass,
    ks_hostname     = local.vm_name,
    ks_timezone     = var.ssh_timezone,
    ks_ntpservers   = var.ssh_ntpservers,
    rhel_orgid      = var.rhel_subscription_orgid,
    rhel_activation = var.rhel_subscription_activation,
    rhel_sys_role   = var.rhel_sys_role,
    rhel_sys_sla    = var.rhel_sys_sla,
    rhel_sys_usage  = var.rhel_sys_usage,
  }
}

#build the execute_command value for running commands as root
#from the Packer documentation, https://developer.hashicorp.com/packer/docs/provisioners/shell#execute-command-example
local "exec_command" {
  expression = "echo \"${var.ssh_escaped_pass}\" | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
}

source "vsphere-iso" "SingleUserInstantClone" {
  boot_command = [
    "<up><wait>",
    "<enter>"
  ]
  #Set vCPU and RAM for 2D Graphics, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#virtual_machine_settings_for_2d_graphics
  CPUs            = 4
  RAM             = 4096
  RAM_reserve_all = true

  network_adapters {
    network      = var.vm_network_name
    network_card = "vmxnet3"
  }

  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 81920
    disk_thin_provisioned = true
  }

  #Disabling hot plug, as noted in https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureaGoldenImageLinuxVMforInstantClones.html#prerequisites
  #Packer syntax, https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso#extra-configuration
  #Configuration value, https://kb.omnissa.com/s/article/1012225
  configuration_parameters = {
    "devices.hotplug" = "false"
  }

  #Populate the kickstart file with required values, https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automatically_installing_rhel/kickstart-commands-and-options-reference_rhel-installer#using_kickstart_files_from_previous_rhel_releases
  cd_content = {
    "ks.cfg" = templatefile("./templates/ks.cfg.pkrtpl.hcl", local.ks_content)
  }
  cd_label      = "OEMDRV"
  datastore     = var.vm_datastore
  guest_os_type = var.rhel_vm_guest_type
  #By default builds to the latest hardware version on the host, uncomment if need to set for a multi-version environment
  # vm_version          = 19
  iso_paths           = ["[${var.iso_datastore}] ${var.iso_path}/${var.iso_name}"]
  vm_name             = local.vm_name
  notes               = "${local.vm_note_prefix} ${local.vm_name} produced via Packer Template ${source.name} at ${local.start_time}"
  folder              = var.vm_vm_folder
  datacenter          = var.vm_datacenter
  cluster             = var.vm_cluster
  host                = var.vm_host
  vcenter_server      = var.vm_vcenter
  username            = var.vm_vcenter_user
  password            = var.vm_vcenter_pass
  insecure_connection = true
  create_snapshot     = true
  snapshot_name       = local.vm_snap_name
  ssh_username        = var.ssh_user
  ssh_password        = var.ssh_pass
}

build {
  sources = ["source.vsphere-iso.SingleUserInstantClone"]
  #Place collected files onto the build system.
  provisioner "file" {
    destination = "/tmp"
    source      = "PackerBuildFiles"
  }

  #If build fails due to an error, attempt to unregister from Red Hat subscription.
  error-cleanup-provisioner "shell" {
    execute_command = local.exec_command
    inline = ["systemctl restart rhsmcertd",
      "insights-client --unregister",
      "subscription-manager remove --all",
      "subscription-manager unregister",
    "subscription-manager clean"]
  }

  #Set hostname before we place it into the /etc/hosts
  #https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_managing_networking/assembly_changing-a-hostname_configuring-and-managing-networking
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["hostnamectl set-hostname ${local.vm_name}.${var.ad_fqdn_domain}"]
  }

  #Map hostname to 127.0.0.1 in /etc/hosts, step 1 in https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/HostsFile.sh"
  }

  #Enable epel as several packages will come from here
  #About https://docs.fedoraproject.org/en-US/epel/
  #Getting start https://docs.fedoraproject.org/en-US/epel/getting-started/
  #As noted in getting started, need to enable the codeready builder repo 
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["subscription-manager repos --enable ${var.rhel_codeready_repo}",
    "dnf install ${var.rhel_epel_rpm_url} --assumeyes"]
  }

  #Install updates to the Linux system, step 3 in https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf upgrade --assumeyes"]
  }

  #Make sure open-vm-tools is installed,  step 5 in https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf install open-vm-tools --assumeyes"]
  }

  #Join to AD domain
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureSSSDOfflineDomainJoinforLinuxDesktops.html
  #https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html-single/integrating_rhel_systems_directly_with_windows_active_directory/index
  #"systemctl enable --now oddjobd.service" from realm join output
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["dnf install samba-common-tools realmd oddjob oddjob-mkhomedir sssd adcli krb5-workstation --assumeyes",
      "echo '${var.ad_domain_pass}' | realm --computer-ou=\"${var.ad_orgunit}\" --user=\"${var.ad_domain_user}\" --verbose join ${var.ad_domain_name}",
    "systemctl enable --now oddjobd.service"]
  }

  #Install supported desktop environment, for RHEL this is gnome, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#desktop_environment
  #Configure graphical mode to be the default, step 12 in https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
  #Red Hat guidance on installing gnome, https://access.redhat.com/solutions/5238
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["dnf group install GNOME base-x Fonts --assumeyes",
    "systemctl set-default graphical.target"]
  }

  #Remove all desktop startup files, except for gnome classic, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#ssodesktoptype_option 
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cd /usr/share/xsessions",
      "mkdir backup",
      "mv *.desktop backup",
    "mv backup/gnome-classic.desktop ./"]
  }

  #Horizon Agent documentation describes the use of wireshark to determine the transport protocol in use for Blast
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#network_requirements
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf install wireshark wireshark-cli --assumeyes"]
  }
  
  #Install BC as required by agent installer, will not run without.
  #Install cups as the horizon agent 2312 and 2312.1 installers look for /usr/lib/cups/backend as part of the install process (continues if not found). 2406 does not produce the same messages, but leaving in place.  
  #Also decided to install cups-pdf. This is an epel package
  #Install libXScrnSaver as the horizon agent 2406/8.13.0 requires it to run, 2312 and 2312.1 do not
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["dnf install bc --assumeyes",
      "dnf install cups cups-pdf --assumeyes",
    "dnf install libXScrnSaver --assumeyes"]
  }

  #Install unzip as required by session collaboration feature setup to extract the gnome extension
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["dnf install unzip --assumeyes"]
  }

  #Install mandatory dependency packages, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstallLinuxDependencyPackagesforHorizonAgent.html
  #Install nss-tools
  #Install libappindicator-gtk3, requires epel (previously enabled)
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf install nss-tools libappindicator-gtk3  --assumeyes"]
  }

  #Install pulseaudio-utils as required for audio input and output
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/FeaturesofLinuxDesktopsinHorizon8.html#audio-in_and_audio-out
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf install pulseaudio-utils --assumeyes"]
  }

  #Configure SSO
  #Configure SSSD to treat AD username as case-insensitive, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SettingUpSingleSignOnforLinuxDesktops.html
  #Modify sssd.conf to use short name for user, step 5, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["sed -E '/\\[domain\\/${replace(var.ad_domain_name, ".", "\\.")}\\]/ a case_sensitive = False'  /etc/sssd/sssd.conf -i",
    "sed -E 's/use_fully_qualified_names = True/use_fully_qualified_names = False/' /etc/sssd/sssd.conf -i"]
  }

  #Configure TrueSSO
  #Using prepared sssd_auth_ca_db.pem, step 4b, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["cp /tmp/PackerBuildFiles/TrueSSO_Certs/sssd_auth_ca_db.pem /etc/sssd/pki/sssd_auth_ca_db.pem"]
  }
  #Using templated TrueSSO_sssd.conf file and [pam] and [certmap] sections to sssd.conf, step 5, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  #Populate domain name in content to add to sssd.conf
  provisioner "file" {
    content     = templatefile("./templates/TrueSSO_sssd.conf.pkrtpl.hcl", { domain_name = var.ad_domain_name })
    destination = "/tmp/PackerBuildFiles/OtherFiles/TrueSSO_sssd.conf"    
  }
  #Add content to end of sssd.conf
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cat /etc/sssd/sssd.conf /tmp/PackerBuildFiles/OtherFiles/TrueSSO_sssd.conf > /tmp/sssd.conf",
      "cp /tmp/sssd.conf /etc/sssd/sssd.conf",
    "rm -f /tmp/sssd.conf"]
  }
  #Make krb5.conf world readable, step 6, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  #Enable SHA1 crypotographic policy, step 7-1, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["chmod 644 /etc/krb5.conf",
      "update-crypto-policies --set DEFAULT:SHA1"]
  }
  #Update system's trusted certificate authorities, step 7-2, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  #Use certificates staged in PackerBuildFiles/TrueSSO_Certs/TrustedCAs
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cp /tmp/PackerBuildFiles/TrueSSO_Certs/TrustedCAs/* /etc/pki/ca-trust/source/anchors/.",
    "update-ca-trust"]
  }
  #Update [realms] and [domain_realm] sections of /etc/krb5.conf, step 7-3, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  #Prepare realms content
  provisioner "file" {
    content     = templatefile("./templates/realms_content.pkrtpl.hcl", { ad_realm_name = local.ad_realm_name, ad_kdc_name = var.ad_kdc_name })
    destination = "/tmp/PackerBuildFiles/OtherFiles/realms_content.txt"    
  }
  #Prepare domain_realm content
  provisioner "file" {
    content     = templatefile("./templates/domain_realm_content.pkrtpl.hcl", { ad_realm_name = local.ad_realm_name, ad_domain_name = lower(var.ad_domain_name) })
    destination = "/tmp/PackerBuildFiles/OtherFiles/domain_realm_content.txt"    
  }
  #Place prepared content into /etc/krb5.conf 
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["sed -E '/\\[realms\\]/ r /tmp/PackerBuildFiles/OtherFiles/realms_content.txt'  /etc/krb5.conf -i",
    "sed -E '/\\[domain_realm\\]/ r /tmp/PackerBuildFiles/OtherFiles/domain_realm_content.txt'  /etc/krb5.conf -i"]
  }

  #Update failback_homedir to include domainname in path.
  #as documented in https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html-single/windows_integration_guide/index?extIdCarryOver=true&sc_cid=701f2000001Css5AAC#sssd-ad-proc
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["sed -E 's/fallback_homedir = \\/home\\/%u@%d/fallback_homedir = \\/home\\/%d\\/%u/g' /etc/sssd/sssd.conf -i"]
  }

  #Expand Horizon Agent Installer, step 2 under Install Horizon Agent Using the Unsigned Tarball Installer, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstallHorizonAgentonaLinuxMachine.html
  provisioner "shell" {
    inline = ["cd /tmp/PackerBuildFiles/HorizonAgent",
    "tar -xzf ./${var.hv_agent_tar}"]
  }

  #As the VHCI and V4L2Loopback drivers require kernel specific packages, reboot to any pending updated kernel. Also handles the reboot requested after changing the crypto policy.
  provisioner "shell" {
    execute_command   = local.exec_command
    inline            = ["reboot"]
    pause_before      = "30s"
    expect_disconnect = true
  }

  #Give time to reboot and verify install can continue.
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["uname -a"]
    pause_before    = "60s"
    timeout         = "240s"
  }

  #Verify that virbr0 is deactived, step 10 on https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/PrepareLinuxMachineforRemoteDesktopDeployment.html
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/Virsh.sh"
  }

  #Install development tools as required by VHCI drier via dkms (usb redirection) and V4L2Loopback driver (realtime audio video) setup
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#compile_and_install_the_usb_vhci_driver
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstalltheV4L2LoopbackDriveronaLinuxMachine.html#install_v4l2loopback_on_a_rhel_or_rocky_linux_machine
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["dnf install gcc-c++ --assumeyes",
      "dnf install kernel-devel-$(uname -r) --assumeyes",
      "dnf install kernel-headers-$(uname -r) --assumeyes",
      "dnf install patch --assumeyes",
      "dnf install elfutils-libelf-devel --assumeyes",
    "dnf install dkms --assumeyes"]
  }

  #Install the VHCI driver for USB redirection https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/SystemRequirementsforHorizonAgentforLinux.html#vhci_driver_for_usb_redirection
  #Requires that vhci-hcd-1.15.tar.gz is placed in the SoftwareDownloads folder
  #Build VHCI driver
  provisioner "shell" {
    inline = ["cd /tmp/PackerBuildFiles/SoftwareDownloads/",
      "tar -xzf ./vhci-hcd-1.15.tar.gz",
      "cd ./vhci-hcd-1.15",
      "patch -p1 < /tmp/PackerBuildFiles/HorizonAgent/${replace(var.hv_agent_tar, ".tar.gz", "")}/resources/vhci/patch/vhci.patch",
    "make clean"]
  }
  #Install VHCI driver via dkms
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/VHCIBuild-dkms-p2.sh"
  }

  #Install the V4L2Loopback Driver for Real Time Audio Video https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstalltheV4L2LoopbackDriveronaLinuxMachine.html#install_v4l2loopback_on_a_rhel_or_rocky_linux_machine
  #Requires that v4l2loopback-0.12.5.tar.gz is placed in the SoftwareDownloads folder
  #Build the V4L2Loopback driver
  provisioner "shell" {
    inline = ["cd /tmp/PackerBuildFiles/SoftwareDownloads/",
      "tar -xzf ./v4l2loopback-0.12.5.tar.gz",
      "cd ./v4l2loopback-0.12.5",
      "patch -p1 < /tmp/PackerBuildFiles/HorizonAgent/${replace(var.hv_agent_tar, ".tar.gz", "")}/resources/v4l2loopback/v4l2loopback.patch",
    "make clean & make"]
  }
  #Install the V4L2Loopback driver
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cd /tmp/PackerBuildFiles/SoftwareDownloads/v4l2loopback-0.12.5",
      "make install",
      "make install-utils",
    "depmod -A"]
  }

  #Install Horizon Agent, step 3 under Install Horizon Agent Using the Unsigned Tarball Installer, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/InstallHorizonAgentonaLinuxMachine.html
  #Command-line Options found at https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/CommandlineOptionsforInstallingHorizonAgentforLinux.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cd /tmp/PackerBuildFiles/HorizonAgent",
      "cd ./${replace(var.hv_agent_tar, ".tar.gz", "")}",
    "./install_viewagent.sh -A yes -T yes -U yes --webcam -a yes"]
  }

  #Configure SSO and TrueSSO after agent install
  #add ad_gpo_map_interactive and ad_gpo_access_control values, steps 3, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureSSSDOfflineDomainJoinforLinuxDesktops.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["sed -E '/\\[domain\\/${replace(var.ad_domain_name, ".", "\\.")}\\]/ a ad_gpo_map_interactive = +gdm-vmwcred'  /etc/sssd/sssd.conf -i",
    "sed -E '/\\[domain\\/${replace(var.ad_domain_name, ".", "\\.")}\\]/ a ad_gpo_access_control = permissive' /etc/sssd/sssd.conf -i"]
  }
  #Set NetbiosDomain, step 9, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureTrueSSOforRHELandRockyLinux9xand8xDesktops.html
  #Set OfflineJoinDomain to sssd, step 4, https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfigureSSSDOfflineDomainJoinforLinuxDesktops.html
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["sed -E 's/#NetbiosDomain=YOURDOMAIN/NetbiosDomain=${local.ad_netbios}/' /etc/vmware/viewagent-custom.conf -i",
    "sed -E 's/#OfflineJoinDomain=sssd/OfflineJoinDomain=sssd/' /etc/vmware/viewagent-custom.conf -i"]
  }

  #Enable Session Collaboration - https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/ConfiguringSessionCollaborationonLinuxDesktops.html#enabling_session_collaboration_on_a_rhel_or_rocky_linux_9x_desktop
  #requires that appindicatorsupportrgcjonas.gmail.com.v42.shell-extension.zip is placed in the SoftwareDownloads folder
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/SessionCollaboration.sh"
  }
#
  #Install Recording Agent
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#run_the_linux_tarball_installer_for_horizon_recording_agent
  #https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/UsingHorizonRecording.html#linux_installer_parameters_for_the_horizon_recording_agent
  #Extract the Horizon Recording Agent install files
  #Update the Horizon Recording Agent install.sh script so that the systemctl status command doesn't stop to wait for input
  provisioner "shell" {
    inline = ["cd /tmp/PackerBuildFiles/HorizonAgent",
      "tar -xz --one-top-level=Horizon.Recording.Linux.Agent -f ./${var.hv_recording_tar}",
      "cd ./Horizon.Recording.Linux.Agent"]
  }
  #Install Horizon Recording Agent
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cd /tmp/PackerBuildFiles/HorizonAgent",
      "cd ./Horizon.Recording.Linux.Agent",
    "./install.sh --uri ${var.hv_recording_server} --username ${var.hv_recording_user} --password ${var.hv_recording_pass} --trusted-ssl-certificate ${var.hv_recording_cert} --template"]
  }

  #Configure Horizon Agent
  #See https://docs.omnissa.com/bundle/Desktops-and-Applications-in-HorizonV2406/page/EditConfigurationFilesonaLinuxDesktop.html for details on avalible options
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/HorizonAgentConfig.sh"
  }

  #Enable desired debug logging
  #Edit DebugOptions.sh to uncomment the desired debug logs and log levels
  provisioner "shell" {
    execute_command = local.exec_command
    script          = "scripts/DebugOptions.sh"
  }

  #Setup for registering and unregistering with RHEL subscription on system start and start
  #See details at https://access.redhat.com/articles/simple-content-access, https://docs.redhat.com/en/documentation/red_hat_insights/1-latest/html-single/client_configuration_guide_for_red_hat_insights/index#assembly-client-cg-overview, and https://access.redhat.com/solutions/271643
  #Place the orgid and activation key into the register script
  provisioner "file" {
    content     = templatefile("./templates/rhel-register.sh.pkrtpl.hcl", { rhel_orgid = var.rhel_subscription_orgid, rhel_activation = var.rhel_subscription_activation })
    destination = "/tmp/PackerBuildFiles/OtherFiles/rhel-register.sh"
  }
  #Put the register and unregister scripts in place
  #Create the systemd service to start run the register and unregister scripts 
  #Set permissions to match other files in same/similar locations
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["cp /tmp/PackerBuildFiles/OtherFiles/rhel-register.sh /usr/local/sbin/rhel-register.sh",
      "cp /tmp/PackerBuildFiles/OtherFiles/rhel-unregister.sh /usr/local/sbin/rhel-unregister.sh",
      "cp /tmp/PackerBuildFiles/OtherFiles/hv-rhelregister.service /etc/systemd/system/hv-rhelregister.service",
      "chown root:root /usr/local/sbin/rhel-register.sh",
      "chown root:root /usr/local/sbin/rhel-unregister.sh",
      "chown root:root /etc/systemd/system/hv-rhelregister.service",
      "chmod 700 /usr/local/sbin/rhel-register.sh",
      "chmod 700 /usr/local/sbin/rhel-unregister.sh",
      "chmod 644 /etc/systemd/system/hv-rhelregister.service",
    "systemctl enable hv-rhelregister"]
  }

  #Install dconf-editor assist with building future customizations
  #Install vim to have prefered editor
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["dnf install dconf-editor vim-enhanced --assumeyes"]
  }

  #Prevent initial gnome welcome message, and setup wizard
  #https://blog.centos.org/2013/12/preventing-gnome3s-initial-setup/
  provisioner "shell" {
    execute_command = local.exec_command
    inline = ["mkdir -p /etc/skel/.config",
      "touch /etc/skel/.config/gnome-initial-setup-done",
    "echo \"yes\" > /etc/skel/.config/gnome-initial-setup-done"]
  }

  #Remove Red Hat registration prior to future cloning, per https://access.redhat.com/solutions/271643
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["systemctl start hv-rhelregister"]
  }
  provisioner "shell" {
    execute_command = local.exec_command
    inline          = ["systemctl stop hv-rhelregister"]
    pause_before    = "60s"
  }

  #Remove items from tmp folder at end of build
  provisioner "shell" {
    inline = ["rm -rf /tmp/PackerBuildFiles"]
  }
}
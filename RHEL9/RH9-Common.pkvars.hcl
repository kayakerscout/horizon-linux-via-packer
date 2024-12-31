#Horizon Settings
hv_recording_server = "RECORDING SERVER URI"
hv_recording_user   = "RECORDING SERVER USER"
hv_recording_pass   = "RECORDING SERVER PASSWORD"
hv_recording_cert   = "RECORDING SERVER CERT THUMBPRINT"
#hv_agent_tar       = "VMware-horizonagent-linux-x86_64-2406-8.13.0-10030307256.tar.gz"
#hv_recording_tar   = "Horizon.Recording.Linux.Agent-1.11.0.0.tar.gz"

#Boot Media Settings
iso_datastore = "ISO DATASTORE"
iso_path      = "ISO PATH"
iso_name      = "ISO NAME"

#vSphere Settings
vm_vcenter      = "VCENTER FQDN"
vm_vcenter_user = "VCENTER USER"
vm_vcenter_pass = "VCENTER PASSWORD"
vm_datacenter   = "VCENTER DATACENTER"
vm_cluster      = "VCENTER CLUSTER"
vm_host         = "ESXI HOST"
vm_datastore    = "VM DATASTORE"
vm_vm_folder    = "VM AND TEMPLATE FOLDER PATH"
vm_network_name = "VM NETWORK NAME"

#AD Settings
ad_domain_name    = "AD DOMAIN NAME"
ad_domain_user    = "AD JOIN USER"
ad_domain_pass    = "AD JOIN PASS"
ad_netbios_string = "AD NETBIOS NAME"
ad_kdc_name       = "AD SERVER NAME"
ad_orgunit        = "CN=Computers,DC=lab,DC=jley,DC=net"
ad_fqdn_domain    = "VM DNS DOMAIN"

#TargetVM Settings
ssh_user         = "VM LOCAL USER"
ssh_pass         = "VM LOCAL PASSWORD"
ssh_escaped_pass = "VM EXCAPED PASSWORD"
ssh_timezone     = "America/Chicago"
ssh_ntpservers   = ["pool.ntp.org"]
#ssh_ntpservers  = ["0.pool.ntp.org", "1.pool.ntp.org"]

#RHEL Settings
rhel_subscription_orgid      = "RED HAT ORG ID"
rhel_subscription_activation = "RED HAT ACTIVATION KEY"
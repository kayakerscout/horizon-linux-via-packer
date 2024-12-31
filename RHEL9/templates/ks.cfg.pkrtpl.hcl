graphical
network --hostname ${ks_hostname}
lang en_US.UTF-8
keyboard us
rootpw --lock 12345
user --name ${ssh_user} --password ${ssh_pass} --plaintext --groups=wheel
timezone ${ks_timezone}
%{ for ntptarget in ks_ntpservers ~}
timesource --ntp-server ${ntptarget}
%{ endfor ~}
zerombr
clearpart --all --initlabel
autopart --type=plain --nohome
eula --agreed
syspurpose --role="${rhel_sys_role}" --sla="${rhel_sys_sla}" --usage="${rhel_sys_usage}"
rhsm --organization="${rhel_orgid}" --activation-key="${rhel_activation}" --connect-to-insights
firewall --enabled --ssh
reboot
%packages
%end
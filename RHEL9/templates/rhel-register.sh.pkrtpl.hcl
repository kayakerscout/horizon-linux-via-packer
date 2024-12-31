#!/usr/bin/env bash
systemctl restart rhsmcertd
insights-client --unregister
subscription-manager remove --all
subscription-manager unregister
subscription-manager clean
systemctl restart rhsmcertd
subscription-manager register --org ${rhel_orgid} --activationkey "${rhel_activation}" --name `hostname --fqdn`
insights-client --register --display-name `hostname --fqdn`
systemctl restart rhsmcertd

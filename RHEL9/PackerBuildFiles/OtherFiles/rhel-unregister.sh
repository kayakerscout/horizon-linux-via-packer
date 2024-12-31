#!/usr/bin/env bash
systemctl restart rhsmcertd
insights-client --unregister
subscription-manager remove --all
subscription-manager unregister
subscription-manager clean

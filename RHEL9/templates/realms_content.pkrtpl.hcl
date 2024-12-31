     ${ad_realm_name} = {
          kdc = ${ad_kdc_name}
          admin_server = ${ad_kdc_name}
          pkinit_anchors = DIR:/etc/pki/ca-trust/source/anchors
          pkinit_kdc_hostname = ${ad_kdc_name}
          pkinit_eku_checking = kpServerAuth
     }


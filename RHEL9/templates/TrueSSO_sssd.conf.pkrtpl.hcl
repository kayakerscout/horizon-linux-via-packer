
[pam]
pam_cert_auth = True
pam_p11_allowed_services = +gdm-vmwcred

[certmap/${domain_name}/truesso]
matchrule = <EKU>msScLogin
maprule = (|(userPrincipal={subject_principal})(samAccountName={subject_principal.short_name}))
domains = ${domain_name}
priority = 10

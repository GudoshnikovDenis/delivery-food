#!/bin/bash
set -euo pipefail

# Include our Kerberos SSO drop-in into Bitnami Apache config once at startup
CONF_MAIN="/opt/bitnami/apache/conf/bitnami/bitnami.conf"
DROPIN="/opt/bitnami/apache/conf/bitnami/extra/kerberos-sso.conf"

if ! grep -q "kerberos-sso.conf" "$CONF_MAIN"; then
	echo "Including Kerberos SSO drop-in into bitnami.conf"
	echo "Include \"$DROPIN\"" >> "$CONF_MAIN"
fi

# Provide krb5.conf from template if none mounted
if [ ! -f /etc/krb5.conf ] && [ -f /etc/krb5.conf.template ]; then
	cp /etc/krb5.conf.template /etc/krb5.conf
fi
FROM bitnami/moodle:latest

# Kerberos client utilities (for keytab testing) and basic tooling
USER root
RUN install_packages krb5-user && rm -rf /var/lib/apt/lists/*

# Apache drop-in and init script to wire it into Bitnami layout
COPY apache/kerberos-sso.conf /opt/bitnami/apache/conf/bitnami/extra/kerberos-sso.conf
COPY docker-entrypoint-init.d/10-kerberos-include.sh /docker-entrypoint-init.d/10-kerberos-include.sh
COPY krb5/krb5.conf.template /etc/krb5.conf.template
RUN chmod +x /docker-entrypoint-init.d/10-kerberos-include.sh

# Runtime will run as non-root per Bitnami conventions
USER 1001


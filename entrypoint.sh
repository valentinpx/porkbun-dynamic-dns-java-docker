#!/bin/bash

# Create config file
echo "{\"endpoint\":\"https://api.porkbun.com/api/json/v3\",\"secretapikey\":\"${SECRET_API_KEY}\",\"apikey\":\"${API_KEY}\"}" > config.json

# Build the jar file
make
make jar

# Run the jar file
java -jar porkbun-ddns.jar ${DOMAIN} ${SUBDOMAIN} A

# Set the cron job if CRON_SCHEDULE is set
if [ -n "${CRON_SCHEDULE}" ]; then
  service cron start
  touch /var/log/porkbun-ddns.log
  echo "${CRON_SCHEDULE} /usr/local/openjdk-17/bin/java -jar /app/porkbun-ddns.jar ${DOMAIN} ${SUBDOMAIN} A >> /var/log/porkbun-ddns.log 2>&1" > /etc/cron.d/porkbun-ddns
  chmod 0644 /etc/cron.d/porkbun-ddns
  crontab /etc/cron.d/porkbun-ddns

  tail -f /var/log/porkbun-ddns.log
fi

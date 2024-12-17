#!/bin/bash

# Create config file
echo "{\"endpoint\":\"https://porkbun.com/api/json/v3\",\"secretapikey\":\"${SECRET_API_KEY}\",\"apikey\":\"${API_KEY}\"}" > config.json

# Build the jar file
javac -cp "./libs/httpcomponents-client-5.0.3/lib/httpclient5-5.0.3.jar:./libs/httpcomponents-client-5.0.3/lib/httpcore5-5.0.2.jar:./libs/httpcomponents-client-5.0.3/lib/slf4j-api-1.7.25.jar:./libs/json.jar" -d . PorkbunDynDNSClient.java
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

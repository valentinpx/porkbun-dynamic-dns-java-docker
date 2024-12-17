#!/bin/bash

# Create config file
echo "{\"endpoint\":\"https://porkbun.com/api/json/v3\",\"secretapikey\":\"${SECRET_API_KEY}\",\"apikey\":\"${API_KEY}\"}" > config.json

# Build the jar file
javac -cp "./libs/httpcomponents-client-5.0.3/lib/httpclient5-5.0.3.jar:./libs/httpcomponents-client-5.0.3/lib/httpcore5-5.0.2.jar:./libs/httpcomponents-client-5.0.3/lib/slf4j-api-1.7.25.jar:./libs/json.jar" -d . PorkbunDynDNSClient.java
make jar

echo "---" && pwd && ls && cat config.json && echo "---"

# Run the jar file
java -jar porkbun-ddns.jar ${DOMAIN} ${SUB_DOMAIN} A

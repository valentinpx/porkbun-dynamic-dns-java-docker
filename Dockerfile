# Base image with Java and tools needed
FROM openjdk:17-jdk-slim

# Install dependencies (git, make, cron)
RUN apt-get update && apt-get install -y \
    git \
    make \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/porkbundomains/porkbun-dynamic-dns-java.git .

# Build the JAR file
COPY config.json /app/config.json
RUN javac -cp "./libs/httpcomponents-client-5.0.3/lib/httpclient5-5.0.3.jar:./libs/httpcomponents-client-5.0.3/lib/httpcore5-5.0.2.jar:./libs/httpcomponents-client-5.0.3/lib/slf4j-api-1.7.25.jar:./libs/json.jar" -d . PorkbunDynDNSClient.java
RUN make jar

# Copy the built JAR file to a known location
RUN cp porkbun-ddns.jar /app/app.jar

# Create a cron job to run the JAR every hour
#RUN echo "0 * * * * java -jar /app/app.jar ${DOMAIN} ${SUB_DOMAIN} A >> /var/log/app.log 2>&1" > /etc/cron.d/app-cron

# Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/app-cron

# Apply the cron job
#RUN crontab /etc/cron.d/app-cron

# Expose log file
#VOLUME /var/log

# Start cron in the foreground
#CMD ["cron", "-f"]
ARG DOMAIN
ARG SUB_DOMAIN
ENTRYPOINT ["sh", "-c", "java -jar /app/app.jar ${DOMAIN} ${SUB_DOMAIN} A"]

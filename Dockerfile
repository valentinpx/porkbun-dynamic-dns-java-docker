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

# Copy entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Build and run the JAR file
ENTRYPOINT ["sh", "-c", "./entrypoint.sh"]

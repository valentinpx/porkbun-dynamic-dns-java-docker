# Porkbun Dynamic DNS Java Docker
This project provides a Dockerized Java application to update DNS records on Porkbun dynamically.

## Prerequisites
- Docker
- Porkbun API Key and Secret
- A Porkbun record to update 🤡

## Configuration
### Required environment variables
Set the following environment variables in a `.env` file (you can also pass them as arguments to the `docker run` command):
- `DOMAIN`: The Porkbun domain name you want to update.
- `SUBDOMAIN`: The Porkbun subdomain you want to update.
- `API_KEY`: Your Porkbun API Key.
- `SECRET_API_KEY`: Your Porkbun API Secret.

### CRON schedule
By default, the application runs only once. To run it periodically, specify a CRON schedule in the `CRON_SCHEDULE` environment variable. For example, to run the application every 5 minutes:
- `CRON_SCHEDULE=*/5 * * * *`

## Getting started
### Clone the repository
```sh
git clone https://github.com/valentinpx/porkbun-dynamic-dns-java-docker.git
cd porkbun-dynamic-dns-java-docker
```

### Docker image
#### Build
```sh
docker build -t porkbun-ddns .
```

#### Docker registry
You can also pull the image from the Docker registry:
```sh
docker pull valentinpx/porkbun-ddns
```

### Run the Docker container
```sh
docker run --env-file .env porkbun-ddns
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## Contact
For any questions or support, please open an issue on the GitHub repository.

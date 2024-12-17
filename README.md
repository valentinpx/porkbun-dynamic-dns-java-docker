# Porkbun Dynamic DNS Java Docker
This project provides a Dockerized Java application to update DNS records on Porkbun dynamically.

## Prerequisites
- Docker
- Porkbun API Key and Secret
- A Porkbun record to update 🤡

## Configuration
### Configuration File
Copy the `config.json.example` file to `config.json` and set the `secretapikey` and `apikey` values to your Porkbun API Key and Secret.

### Environment Variables
Set the following environment variables in a `.env` file (you can also pass them as arguments to the `docker run` command):
- `DOMAIN`: The Porkbun domain name you want to update.
- `SUBDOMAIN`: The Porkbun subdomain you want to update.


## Getting Started
### Clone the Repository
```sh
git clone https://github.com/valentinpx/porkbun-dynamic-dns-java-docker.git
cd porkbun-dynamic-dns-java-docker
```

### Build the Docker Image
```sh
docker build -t porkbun-ddns .
```

### Run the Docker Container
```sh
docker run --env-file .env jar-scheduler
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## Contact
For any questions or support, please open an issue on the GitHub repository.

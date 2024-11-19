# Crypto Miner

This project sets up a Docker container for cryptocurrency mining using `cgminer`.

## Prerequisites

- Docker installed on your machine

## Building the Docker Image


## remove the build folder
- docker rm -f crypto-miner

## create a new build folder
- docker build -t crypto-miner .

## Running the Docker Container
To run the Docker container, execute the following command:
```sh
docker run -it --name crypto-miner -p 8080:8080 crypto-miner
```

## Rebuild the image with the --no-cache flag to ensure a fresh build:
```sh
docker build --no-cache -t crypto-miner .
```

## Run the container with additional required flags for mining:
```sh
docker run -it --name crypto-miner --privileged -p 8080:8080 crypto-miner
```

## Run the container with additional required flags for mining
```sh
docker run -it --name crypto-miner --privileged -p 8080:8080 crypto-miner
```

## If you're still experiencing issues, we can check the logs:
```sh
docker logs crypto-miner
```

Navigate to the project directory and run:

```sh
docker build -t crypto-miner .
```

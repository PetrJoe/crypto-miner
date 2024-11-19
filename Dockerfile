# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set the working directory
WORKDIR /crypto-miner

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages with specific versions
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    libcurl4-openssl-dev \
    libjansson-dev \
    libudev-dev \
    libusb-1.0-0-dev \
    libncurses5-dev \
    pkg-config \
    git \
    wget \
    gcc-9 \
    && rm -rf /var/lib/apt/lists/*

# Set gcc-9 as default compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100

# Download and install cgminer with additional configure flags
RUN wget https://github.com/ckolivas/cgminer/archive/refs/tags/v4.11.1.tar.gz \
    && tar xf v4.11.1.tar.gz \
    && cd cgminer-4.11.1 \
    && ./autogen.sh \
    && ./configure --enable-scrypt --enable-icarus --enable-avalon --enable-bitforce --disable-werror \
    && make CFLAGS="-Wno-format-truncation -Wno-format-overflow" \
    && make install \
    && cd .. \
    && rm -rf cgminer-4.11.1 v4.11.1.tar.gz

# Copy the entrypoint script
COPY entrypoint.sh /crypto-miner/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /crypto-miner/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/crypto-miner/entrypoint.sh"]

# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set the working directory
WORKDIR /usr/src/app

# Install necessary packages
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
    && rm -rf /var/lib/apt/lists/*

# Download and install cgminer
RUN git clone https://github.com/ckolivas/cgminer.git /usr/src/cgminer \
    && cd /usr/src/cgminer \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install

# Copy the entrypoint script
COPY entrypoint.sh /usr/src/app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/src/app/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

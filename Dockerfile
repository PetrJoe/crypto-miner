# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set the working directory
WORKDIR /crypto-miner

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set mining pool credentials as environment variables
ENV POOL="stratum2+tcp://v2.stratum.braiins.com/u95GEReVMjK6k5YqiSFNqqTnKU4ypU2Wm8awa6tmbmDmk1bWt"
ENV USER="PetrJoe.workerName"
ENV PASSWORD="anything123"

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
    python3 \
    python3-pip \
    supervisor \
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

# Copy application files
COPY requirements.txt .
COPY app.py .
COPY supervisord.conf /etc/supervisor/conf.d/

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose ports
EXPOSE 8080

# Use supervisor to manage processes
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

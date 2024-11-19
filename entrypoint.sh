#!/bin/bash

# Set the mining pool and credentials
POOL="stratum2+tcp://v2.stratum.braiins.com/u95GEReVMjK6k5YqiSFNqqTnKU4ypU2Wm8awa6tmbmDmk1bWt"
USER="PetrJoe.workerName"
PASSWORD="anything123"

# Start the miner
cgminer -o $POOL -u $USER -p $PASSWORD

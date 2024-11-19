import subprocess
import threading
from flask import Flask

app = Flask(__name__)

def start_miner():
    subprocess.run(["cgminer", "-o", "stratum2+tcp://v2.stratum.braiins.com/u95GEReVMjK6k5YqiSFNqqTnKU4ypU2Wm8awa6tmbmDmk1bWt", "-u", "PetrJoe.workerName", "-p", "anything123"])

@app.route('/')
def home():
    return "Crypto Miner Service Running"

if __name__ == '__main__':
    miner_thread = threading.Thread(target=start_miner)
    miner_thread.start()
    app.run(host='0.0.0.0', port=8080)
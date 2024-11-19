from flask import Flask, jsonify
import subprocess
import threading
import os

app = Flask(__name__)

def start_miner():
    pool = os.getenv('POOL', 'stratum2+tcp://v2.stratum.braiins.com/u95GEReVMjK6k5YqiSFNqqTnKU4ypU2Wm8awa6tmbmDmk1bWt')
    user = os.getenv('USER', 'PetrJoe.workerName')
    password = os.getenv('PASSWORD', 'anything123')
    
    try:
        miner_process = subprocess.Popen([
            "cgminer",
            "-o", pool,
            "-u", user,
            "-p", password
        ])
        return miner_process
    except Exception as e:
        print(f"Miner error: {str(e)}")


def get_cgminer_status():
    try:
        result = subprocess.check_output(["cgminer-api", "summary"]).decode()
        return result
    except Exception as e:
        return str(e)

@app.route('/')
def home():
    return jsonify({
        "cgminer_status": get_cgminer_status()
    })



# @app.route('/')
# def home():
#     return jsonify({
#         "status": "running",
#         "miner": "active",
#         "message": "Crypto miner is operational"
#     })

if __name__ == '__main__':
    miner_thread = threading.Thread(target=start_miner)
    miner_thread.daemon = True
    miner_thread.start()
    app.run(host='0.0.0.0', port=8080, debug=False)

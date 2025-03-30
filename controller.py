import subprocess
import time

def start_script():
    return subprocess.Popen(["python3", "read_write_serial.py"])

while True:
    process = start_script()
    time.sleep(10)
    process.terminate()

    time.sleep(1)

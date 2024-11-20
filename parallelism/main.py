import threading
import os
import subprocess
import fileinput

def run_process(command):
    print(f"Running command: {command}")

if __name__ == "__main__":

    url = input("Enter the url: ")

    filename = 'raft-small-directories.txt'

    for line in fileinput.input(files=filename):
        command = f"ffuf -u {url}/FUZZ -w {line.strip()} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 1.txt"
        os.system(command)

        command = f"ffuf -u {url}/FUZZ -w {line.strip()} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 3.txt"
        os.system(command)

        command = f"ffuf -u {url}/FUZZ -w {line.strip()} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 5.txt"
        os.system(command)

    threads = []
    for command in command:
        thread = threading.Thread(target=run_process, args=(command,))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


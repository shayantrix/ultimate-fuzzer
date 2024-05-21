import threading
import os
import subprocess

def run_process(command):
    print(f"Running command: {command}")

if __name__ == "__main__":

    dict = open("raft-small-directories.txt", "rt")
    for each in dict:
        url = input("Enter the url: ")
        commands = [os.system("ffuf -u {url}/FUZZ -w {each} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 1.txt"), 
                     os.system("ffuf -u {url}/FUZZ -w {each} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 3.txt"), 
                     os.system("ffuf -u {url}/FUZZ -w {each} -x http://itpimksd:y7hd9x2a1nu4@104.239.38.110:6643 -t 100 -p 60 -v -c > 5.txt")]

    threads = []
    for command in commands:
        thread = threading.Thread(target=run_process, args=(command,))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


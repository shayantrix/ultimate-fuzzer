import threading

def run_process(command):
    # Replace this with your actual command execution logic (e.g., using subprocess)
    print(f"Running command: {command}")
    # ... your command execution code here ...

if __name__ == "__main__":
    # Define your command-line calls
    commands = ["command1", "command2", "command3"]

    # Create and start threads for each command
    threads = []
    for command in commands:
        thread = threading.Thread(target=run_process, args=(command,))
        thread.start()
        threads.append(thread)

    # Wait for all threads to finish
    for thread in threads:
        thread.join()

# This will run all commands defined in the 'commands' list concurrently.


# commands for cmd
#read -p "Enter the URL: " url
#echo -e "Do you like to add your own dictionary?\n"
#read -p "Enter the Dictionary: " dict
#read -p "Enter proxy (examples: itpimksd:y7hd9x2a1nu4@104.239.38.110:6643)" proxy1
#read -p "Enter proxy (examples: itpimksd:y7hd9x2a1nu4@104.239.38.110:6643)" proxy2
#read -p "Enter proxy (examples: itpimksd:y7hd9x2a1nu4@104.239.38.110:6643)" proxy3

#ffuf -u $url/FUZZ -w $dict -x http://$proxy1 -t 100 -p 60 -v -c > 1.txt &&
#cat 1.txt  | cut -d "[" -f2 |cut -b 3-100 > 2.txt

#ffuf -u $url/FUZZ -w $dict -x http://$proxy2 -t 100 -p 60 -v -c > 3.txt &&
#cat 3.txt  | cut -d "[" -f2 |cut -b 3-100 > 4.txt

#ffuf -u $url/FUZZ -w $dict -x http://$proxy3 -t 100 -p 60 -v -c > 5.txt &&
#cat 5.txt  | cut -d "[" -f2 |cut -b 3-100 > 6.txt

#cat 2.txt 4.txt 6.txt > results
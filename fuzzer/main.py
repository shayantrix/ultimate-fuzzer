import requests

url = input("Enter the URL: ")
wordlist = input("Enter the directory wordlist: ")

lines = open(wordlist, "r",encoding="utf8").readlines()

for i in range(0, 10):
    enum_word = lines[i].replace("\n", "")
    r = requests.get(url+enum_word)

    if r.status_code != 404:
        print(url+enum_word+"----------->"+str(r.status_code))

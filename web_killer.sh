#!/bin/bash

echo " 						  NO!                          MNO!
     						 MNO!!         [NBK]          MNNOO!
   					       MMNO!                           MNNOO!!
 					     MNOONNOO!   MMMMMMMMMMPPPOII!   MNNO!!!!
					      !O! NNO! MMMMMMMMMMMMMPPPOOOII!! NO!
						    ! MMMMMMMMMMMMMPPPPOOOOIII! !
        					     MMMMMMMMMMMMPPPPPOOOOOOII!!
        					     MMMMMOOOOOOPPPPPPPPOOOOMII!
        					     MMMMM..    OPPMMP    .,OMI!
        					     MMMM::   o.,OPMP,.o   ::I!!
          				               NNM:::.,,OOPM!P,.::::!!
         					      MMNNNNNOOOOPMO!!IIPPO!!O!
         					      MMMMMNNNNOO:!!:!!IPPPPOO!
          					        MMMMMNNOOMMNNIIIPPPOO!!
             					 	   MMMONNMMNNNIIIOO!
           						 MN MOMMMNNNIIIIIO! OO
          						MNO! IiiiiiiiiiiiI OOOO
	     					   NNN.MNO!   O!!!!!!!!!O   OONO NO!
    						  MNNNNNO!    OOOOOOOOOOO    MMNNON!
      						    MNNNNO!    PPPPPPPPP    MMNON!
  						       		OO!                   ON!								
											VORTEX
"
> wpscan2.txt
echo -e "you need these programs installed on your machine : gobuster, ffuf, dirb, wpscan\n"
echo -e "Welcome\n"
echo -e "is your site based on wordpress or not?\n"
read -p "for wordpress press [1]: " wordpress_confirm
read -p "Enter the URL: " url
echo -e "Do you like to add your own dictionary?\n"
read -p "yes?  [1]: " dict_confirm

if [ $dict_confirm -eq 1 ]
then
	read -p "Enter the Dictionary: " dict
	gobuster dir -u $url -w $dict -s "204,301,302,307,401,403" -b "" -o 5.txt
	cat 5.txt | grep -Eo "http://.*|https://.*" | cut -d "/" -f 4 > 6.txt
	ffuf -u $url/FUZZ -w $dict -e .php,.html,.txt > 7.txt
	cat 7.txt  | cut -d "[" -f2 |cut -b 3-100 > 8.txt 
	dirb $url $dict -r -a "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36" -w -z 200 > dirb3.txt
	cat dirb3.txt | grep -Eo "DIRECTORY: https://.*|DIRECTORY: http://.*" | cut -d "/" -f 4 > dirb4.txt

	if [ $wordpress_confirm -eq [yY] ]
	then
		wpscan --url $url --enumerate t --random-user-agent > wpscan.txt
		cat wpscan.txt | grep -Eo "https://.*|http://.*" | cut -d "/" -f 4,5,6 > wpscan2.txt
	fi
	cat 6.txt 8.txt dirb4.txt wpscan2.txt > result.txt
	exit 0
elif [ ! $dict_confirm -eq 1 ]
then
	gobuster dir -u $url -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -s "204,301,302,307,401,403" -b "" -o 5.txt
	cat 5.txt | grep -Eo "http://.*|https://.*" | cut -d "/" -f 4 > 6.txt
	ffuf -u $url/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -e .php,.html,.txt > 7.txt
	cat 7.txt  | cut -d "[" -f2 |cut -b 3-100 > 8.txt 
	dirb $url /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -r -a "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36" -w -z 200 > dirb3.txt
	cat dirb3.txt | grep -Eo "DIRECTORY: https://.*|DIRECTORY: http://.*" | cut -d "/" -f 4 > dirb4.txt
	if [ $wordpress_confirm -eq [yY] ]
	then
		wpscan --url $url --enumerate t --random-user-agent > wpscan.txt
		cat wpscan.txt | grep -Eo "https://.*|http://.*" | cut -d "/" -f 4,5,6 > wpscan2.txt
		cat 6.txt 8.txt dirb4.txt wpscan2.txt > result.txt
	fi
	exit 0
fi

if [ $wordpress_confirm -eq 1 ]
then
	gobuster dir -u $url -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -s "204,301,302,307,401,403" -b "" -o 5.txt
	cat 5.txt | grep -Eo "http://.*|https://.*" | cut -d "/" -f 4 > 6.txt
	ffuf -u $url/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -e .php,.html,.txt > 7.txt
	cat 7.txt  | cut -d "[" -f2 |cut -b 3-100 > 8.txt 
	dirb $url /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -r -a "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36" -w -z 200 > dirb3.txt
	cat dirb3.txt | grep -Eo "DIRECTORY: https://.*|DIRECTORY: http://.*" | cut -d "/" -f 4 > dirb4.txt
	wpscan --url $url --enumerate t --random-user-agent > wpscan.txt
	cat wpscan.txt | grep -Eo "https://.*|http://.*" | cut -d "/" -f 4,5,6 > wpscan2.txt

	cat 6.txt 8.txt dirb4.txt wpscan2.txt > result.txt
	exit 0
else 
	exit 0
fi

#!/bin/bash

# REMEMBER TO MODIFY THE SPEFIC INFORMATION ON THE SCRIPT "config.sh" AND THE DOCKERFILE TOO

if [ $(whoami) == "root" ]; then 
    if [ "$1" = "start" ]; then 
        sudo docker build -t kalinovnc .
        sudo docker run --rm -itd -p 9021:5900 -p 9020:8080 kalinovnc 

        if [ $? -eq 0 ]; then 
            echo "[+] access: http://127.0.0.1:9020/vnc.html"
            echo "NOVNC Password: $(grep "VNCPWD" dockerfile | cut -d " " -f 3)"

        else 
            echo "[-] Something don't works, please execute the script on the same dir who has the dockerfile"

        fi
    elif [ "$1" = "stop" ]; then 
        sudo docker stop $(docker ps -a | cut -d " " -f1 | head -n2 | grep -v "CONTAINER") 2> /dev/null
        sudo docker remove $(docker ps -a | cut -d " " -f1 | head -n2 | grep -v "CONTAINER") 2> /dev/null
        sudo docker rmi kalinovnc 2> /dev/null  

        if [ $? -eq 0 ]; then 
            echo "[+] Container deleted."

        else 
            echo "[-] Something don't works"

        fi
    else 
        echo "[-] Pleasey use or 'start' or 'stop': ./deploy start|stop"

    fi
else
   echo "[-] Please, execute this script using root user."

fi

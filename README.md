# Docker-Hub

kali-linux-core: docker tag kalinovnc:latest ophigeni/kalinovnc:latest

# Docker Build

git clone https://github.com/ophigeni/kalinovnc

cd kali-linux && chmod +x deploy.sh && sudo ./deploy.sh start

# Docker Run

docker run -ti kalinovnc:latest

# Tips

Novnc port: 9020

User: KALI

Pass: 12345678

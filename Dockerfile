FROM kalilinux/kali-rolling:latest 

ARG KALI_VERSION=headless
ENV DEBIAN_FRONTEND nointeractive 
RUN apt update 
RUN apt upgrade -y 
RUN apt install -y kali-linux-${KALI_VERSION}
#RUN apt install -y kali-linux-core
#RUN apt install -y kali-tools-top10
#RUN apt install -y kali-linux-default
#RUN apt install -y kali-linux-large
RUN apt install -y dbus dbus-x11 novnc net-tools nano tightvncserver
RUN apt clean 

ARG KALI_GUI=xfce
RUN apt install -y kali-desktop-${KALI_GUI}
RUN apt remove -y xfce4-power-manager -y 
RUN apt clean
ENV USER root 

RUN useradd -rm -d /home/KALI -s /bin/zsh -g root -G sudo -u 1001 KALI
RUN echo 'KALI:12345678'| chpasswd 
RUN apt install nano autocutsel inetutils-ping htop -y
RUN apt clean 
RUN apt autoremove -y
WORKDIR /home/KALI

# VNC Enviroment
ENV VNCEXPOSE 0
ENV VNCPORT 5900
# Only password of 8 oflength
ENV VNCPWD 12345678
ENV VNCDISPLAY 1920x1080
ENV VNCDEPTH 16
ENV NOVNCPORT 8080

COPY config.sh /config.sh 
RUN chmod 755 /config.sh 
ENTRYPOINT [ "/config.sh" ]

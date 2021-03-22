
FROM ubuntu:20.04


# Paketliste aktualisieren
RUN apt-get update


# GDM - Gnome-Desktop-Manager
RUN DEBIAN_FRONTEND=nointeractive apt-get install -y gdm3


# VNC-Server
RUN DEBIAN_FRONTEND=nointeractive apt-get install -y tightvncserver xfonts-base \
	&& cd /root \
	&& touch .Xresources \
	&& touch .Xauthority \
	&& mkdir .vnc \
	&& echo "USER=root" >> .bashrc \
	&& echo "export USER" >> .bashrc
	
# Startskript fuer den GDM
COPY xstartup /root/.vnc/
RUN chmod 777 /root/.vnc/xstartup


# VNC-Password
RUN printf "linaxepad\nlinaxepad\nn\n" | vncpasswd

# VNC-Server-User
ENV USER root


# 32-Bit-Architektur aktivieren
# notwendige 32-Bit-Bibliotheken installieren
RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& DEBIAN_FRONTEND=nointeractive apt-get install -y libgtk2.0-0:i386 libcairo2:i386 libpango1.0-0:i386 libgdk-pixbuf2.0-0:i386 libstdc++6:i386
	

# LinAXEpad
RUN mkdir -p /home/picaxe
COPY linaxepad.tar.gz /home/picaxe
RUN set -x \
	&& cd /home/picaxe \
	&& gunzip linaxepad.tar.gz \
	&& tar xvf linaxepad.tar \
	&& rm -f linaxepad.tar


# Docker-Start-Skript
# - removes Lock files
# - start tightvncserver
# - start linaxepad
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh" ]


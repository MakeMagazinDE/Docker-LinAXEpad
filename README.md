# Docker-LinAXEpad
PICAXE unter Ubuntu 20.04

Make-Leser Udo Adel hatte beim Lesen unseres Docker-Artikel in Ausgabe 1/21 folgende Idee:

"Beim Lesen ist mir ein älteres Problem in den Sinn gekommen. Ich hatte versucht, für den PICAXE 08M2 aus dem Sonderheft 'PICAXE SPEZIAL' von 2020, die Linux-basierte AXEPad-Software 'LinAXEpad' auf meinem Ubuntu 20.04 System zu installieren, was aufgrund der notwendigen alten 32-bit-Bibliotheken misslang und zu einem instabilen System führte. Nach der Neuinstallation von Ubuntu habe ich dann eine VM mit einem alten Windows-XP-Image für die Programmierung des 08M2 benutzen müssen.

Der Artikel hat mich nun inspiriert, zu versuchen, die LinAXEpad-Software in einem Docker zu integrieren, wo dann die 32-bit-Bibliotheken vom System isoliert sind. Als Grundlage habe ich das Docker-Image Ubuntu 20.04 verwendet. In diesem Docker kommt der Gnome-Desktop-Manager 'gdm3' zur Anwendung, weil die Oberfläche von 'LinAXEpad' GTK-basiert ist. Für den VNC-Zugang habe ich dann auch den 'TightVNC' benutzt. Desweiteren werden noch die 32-Bit-Bibliotheken, welche von 'LinAXEpad' benötigt werden, installiert. Das Softwarearchiv 'linaxepad.tar.gz' muss von der Herstellerseite (https://picaxe.com/software/picaxe/axepad/) heruntergeladen und in dasselbe Verzeichnis, in dem sich auch das 'Dockerfile' befindet, abgelegt werden. Das Archiv wird in den Docker-Container kopiert und dort entpackt. 

Die beiden Skript-Dateien 'xstartup' und 'entrypoint.sh' habe ich entsprechend meinem Docker angepasst. Mit dem Kommando 

````
docker build -t linaxepad . 
````

kann dann das Docker-Image mit dem Namen 'linaxepad' gebaut werden. Mittels des Kommandos 

````
docker run -p 5900:5900 -p 5901:5901 --name linaxepad -v /dev:/dev --privileged -v ${HOME}/workspace:/root/workspace -d linaxepad 
````

kann der Docker gestartet werden. Das Verzeichnis ${HOME}/workspace muss der eigenen Umgebung angepasst werden. Es dient als Arbeitsverzeichnis und der Speicherung der eigenen Programmdateien. Dieses Verzeichnis wird in den Docker beim Starten gemounted.
Im VNC-Client 'Remmina' habe ich mir eine Verbindung, localhost:5901, Password: linaxepad, eingerichtet und kann nun auch unter Linux mittels 'LinAXEpad' meinen PICAXE 08M2 programmieren."


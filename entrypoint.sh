#!/bin/bash

if test -f "/tmp/.X1-lock"; then
	  rm /tmp/.X1-lock
  	  rm /tmp/.X11-unix/X1
fi

/usr/bin/tightvncserver -geometry 1280x800 -depth 24

export DISPLAY=0:1

/home/picaxe/LinAXEpad &

while [ 1 ]
do
  n=1
done



#!/bin/bash


xhost +local:root

docker run -it --rm --net=host\
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.packettracer:/root/pt \
  -v $HOME/packettracer:/root/SaveData \
  somatorio/packet-tracer

xhost -local:root

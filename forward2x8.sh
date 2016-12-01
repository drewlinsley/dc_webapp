#!/bin/bash
while sleep 1; do ssh -L 7777:localhost:7777 -N x8.clps.brown.edu; done
#while sleep 1; do autossh -M 20000 -f -L 7777:localhost:7777 -N x8.clps.brown.edu; done

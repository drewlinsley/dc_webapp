#!/bin/bash
while sleep 1
do
	ssh -N -R 7777:localhost:7777 yvm3 
	echo "Reopening guess tunnel..."
done

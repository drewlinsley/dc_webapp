#!/bin/bash
while sleep 1
do
	ssh -R 7777:localhost:7777 yvm3 sleep 3600
done

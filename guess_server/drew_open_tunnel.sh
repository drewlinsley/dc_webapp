#!/bin/bash
while sleep 1
do
	ssh -R 7777:localhost:7777 youssef@pclpslabserrecit3.services.brown.edu sleep 3600
done

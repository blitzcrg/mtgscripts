#!/bin/bash
while read p; do
 wget http://www.mtggoldfish.com/deck/download/$p
done < $1

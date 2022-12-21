#!/bin/bash

#Script para ilustrar el funcionamiento del for


for A in $*
do 
	((itera=itera+1))
	echo "$itera ... $A"
done
itera=0
for A 
do 
	((itera=itera+1))
	echo "$itera ... $A"
done


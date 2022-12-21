#!/bin/bash

#Script para ilustrar el funcionamiento del for

declare -i itera=0
for A in lunes martes miércoles jueves
do 
	((itera=itera+1))
	echo "$itera ... $A"
done

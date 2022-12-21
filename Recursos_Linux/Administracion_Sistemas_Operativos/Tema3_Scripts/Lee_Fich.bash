#!/bin/bash
#Este script usa read para leer de un fichero
declare linea
while (( $# > 0 ))
do
        exec 3<$1
	while read -u 3 linea
	do
		if [[ -n $linea ]] 
        	then
			echo OK
		else
			echo NO
		fi
	done 
        shift
done

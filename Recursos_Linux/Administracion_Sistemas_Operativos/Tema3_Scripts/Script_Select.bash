#!/bin/bash

#Ejemplo de select

select A in lunes martes fin
do

	echo "$REPLY $A"
	if [[ $A = fin ]]
	then
		break
	fi
done

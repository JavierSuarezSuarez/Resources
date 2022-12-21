#!/bin/bash

# Comprobación de invocación correcta

if [[ $# -lt 1 ]]
then
	echo "Invocación incorrecta" 1>&2
	exit 1
fi



# Procesar cada argumento (usuario)
while (( $# != 0 ))
do
# Comprobar la existencia del usuario y si su intérprete es el bash
	declare flag=0
	IFS=:
	while read c1 c2 c3 c4 c5 c6 c7
	do
		if [[ $c1 = $1 ]]
		then
			echo "$c1 ... $c4 ... $c6" >> fileinfousuario
			flag=1
			break
		fi
	done <passwd

	if [[ $flag = 0 ]]
	then
		echo "El usuario $1 no existe"
	fi
	shift
done 

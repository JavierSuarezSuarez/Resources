#!/bin/bash

#Script2A: Se añade la posibilidad de que si no se pasa rango, lo establezca a partir 
# de los parametros UID_MIN y UID_MAX del fichero /etc/login.defs

# Control de parametros: Se deben pasar como maximo 2 argumentos
if [[ $# -gt 2 ]]
then
	echo "Invocación Incorrecta"
	exit 1
fi

# Control de parametros: Se deben pasar 0 o 2 argumentos
if [[ $# -eq 1 ]]
then
	echo "Invocación Incorrecta: Solo se ha pasado un argumento"
	exit 3
fi

# Si tiene argumentos ...
if [[ $# -eq 2 ]]
then
	#El primer parametro debe ser menor al segundo
	if [[ $1 -ge $2 ]]
	then
		echo "Error: El primer argumento debe ser menor que el segundo"
		exit 2
	fi

	# Lectura del fichero passwd
	IFS=:
	while read username c2 uid c4 c5 c6 c7
		do
		if (( uid >= $1 && uid <= $2 ))
		then
			echo "El usuario $username se encuentra en el rango con uid $uid"
		fi

	done < passwd

	exit 0
else
# Si no tiene argumentos ...

	#Variables para almacenar el valor de UID_MIN Y UID_MAX de /etc/login.defs
	declare uidMin=$(grep "^UID_MIN" /etc/login.defs | tr -s " " ":" | cut -d: -f2)
	declare uidMax=$(grep "^UID_MAX" /etc/login.defs | tr -s " " ":" | cut -d: -f2)

	# Lectura del fichero passwd
	IFS=:
	while read username c2 uid c4 c5 c6 c7
		do
		if (( uid >= uidMin && uid <= uidMax ))
		then
			echo "El usuario $username se encuentra en el rango con uid $uid"
		fi

	done < passwd

	exit 0
fi




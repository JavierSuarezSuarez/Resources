#!/bin/bash

#Script2 verison generica: Se buscan los UIDs en un rango pasado por argumentos
# Control de parametros: Deben ser 2, Min y Max
if [[ $# -ne 2 ]]
then
	echo "Invocación Incorrecta"
	exit 1
fi

#Si Min es >= Max no se puede determinar el rango
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



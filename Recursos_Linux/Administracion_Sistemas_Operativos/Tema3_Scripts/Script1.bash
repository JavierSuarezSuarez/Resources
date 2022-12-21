#! /bin/bash

#Script 1 genérico
declare itera=0  # Variable para controlar si estamos en linea par o impar

#Control de parámetros, si hay menos de 1 no se le ha pasado fichero
if [[ $# -lt 1 ]]
then
	echo "Invocacion incorrecta"
fi

#Mientras se lea del fichero pasado, guardamos en linea lo que vamos leyendo
#y si itera es impar imprimimimos la linea con su numero de itera
while read linea
do
	if (( itera%2!=0 ))
	then
		echo "$itera $linea"
	fi
	(( itera=itera+1 ))
done <$1

#! /bin/bash

#Control de parametros
if [[ $# -ne 1 ]]
then
	echo "Error: Se necesita un parametros solo" 1>&2
	exit 1
fi


#Tratamiento de datos
declare direc=$(mount -l | grep ext4 | cut -d" " -f3)
declare tmp
for linea in $direc
do
	tmp=$(find $linea | wc -l)
	if (( $tmp>$1 ))
	then
		echo "El directorio $linea tiene $tmp archivos. Se pasa de $1"
	else
		echo "El directorio $linea tiene $tmp archivos. NO se pasa de $1"
	fi
done
exit 0

#! /bin/bash

#Control de parámetros
if [[ $# -eq 0 ]]
then
	echo "Error: Se debe pasar al menos 1 nombre de usuario" 1>&2
	exit 1
fi

declare min=$(find / -user $1 -type f 2>/dev/null | wc -l)
declare minname
#Tratamiento de los parámetros
while (( $#>0 ))
do
	username=$1
	count=$(find / -user $username -type f 2>/dev/null | wc -l)
	echo "El usuario $username tiene $count archivos"
	if (( $count<$min ))
	then
		min=$count
		minname=$username
	fi
	shift
done
echo "El usuario $minname tiene el menor nº de archivos, con una cantidad de $min archivos"
exit 0

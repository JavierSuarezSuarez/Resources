#! /bin/bash

#Control de parámetros
if [[ $# -gt 1 ]]
then

	echo "Error: Solo se puede pasar 1 argumento como maximo" 1>&2
	exit 1
fi


if [[ $# -eq 0 ]]
then

	#Tratamiento de datos
	declare -A mapa
	declare valor
	IFS=:
	while read c1 c2 c3 c4 c5 c6 shell
	do
		if [[ ${mapa[$shell]} -ge 1 ]]
        	then	
       			valor=${mapa[$shell]}
                	(( valorinc=$valor+1 ))
                	mapa[$shell]=$valorinc

        	else
                	mapa+=([$shell]=1)
        	fi

	done < /etc/passwd


	#Salida
	declare shellname=""
	declare max=0
	declare value=0

	for i in ${!mapa[@]}
	do
      		value=${mapa[$i]}

      		if (( $value > $max ))
      		then
			max=$value
			shellname=$i
      		fi
	done

	echo "El shell $shellname tiene el mayor número de apariciones con $max apariciones"

	exit 0
else









fi

exit 0


























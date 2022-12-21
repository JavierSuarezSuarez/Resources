#! /bin/bash

#Control de parámetros
if [[ $# -gt 0 ]]
then

	echo "Error: No se pueden pasar argumentos" 1>&2
	exit 1
fi



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


























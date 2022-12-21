#! /bin/bash

#Control de parámetros
if [[ $# -gt 0 ]]
then
	echo "Error: No se le puede pasar argumentos" 1>&2
	exit 1
fi

if [[ !(-f ./passwd) ]]
then
	cp /etc/passwd ./passwd
fi

#Tratamiento del fichero y salida por pantalla
declare i=0
declare -a nombreusuarios
IFS=:
while read username c2 c3 c4 c5 dirhome c7 
do
	while read username2 c22 c33 c44 c55 dirhome2 c77
	do
		if [[ $username != $username2 ]]
		then
			if [[ $dirhome = $dirhome2 ]]
			then
				IFS=" "
				if (( i==0 ))
				then
					nombreusuarios[i]=$username
				        (( i=$i+1 ))
				fi
				nombreusuarios[i]=$username2
				(( i=$i+1 ))
				IFS=:
			fi
		fi

	done <./passwd 

	if (( ${#nombreusuarios[*]}>0 ))
	then
		IFS=" "
		echo "El directorio $dirhome es compartido por: ${nombreusuarios[*]}"
		IFS=:
		unset nombreusuarios
		declare -a nombreusuarios
		i=0
	fi
	

done < ./passwd

exit 0 

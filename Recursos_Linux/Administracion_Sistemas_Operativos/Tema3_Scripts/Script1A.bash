#! /bin/bash

#Script1 versión A: Se cambia el orden de argumentos para poner las opciones como $1
declare itera=0

#Control de parametros: Se tienen que pasar  1 o 2 parametros
if [[ $# -lt 1 ]]
then
	echo "Invocacion incorrecta"
fi

#Si se le pasa el fichero con alguna opcion ...
if [[ $# -eq 2 ]]
then
	#Bucle de lectura del fichero
	while read linea
	do
		#Si en el primer argumento se pasa la opcion --impar
		if [[ ($1 == "--impar") ]]
		then
			if (( itera%2!=0 ))
			then
				echo "$itera $linea"
			fi
		#Si en el primer argumento se pasa la opcion --par
		elif [[ $1 == "--par" ]]
		then
			if (( itera%2==0 ))
			then
				echo "$itera $linea"
			fi
		fi
		(( itera=itera+1 ))
	done <$2
	exit 0
fi

# Si solo se le pasa el fichero ...
if [[ $# -eq 1 ]]
then
	#Bucle de lectura del fichero
	while read linea
	do
		if (( itera%2!=0 ))
		then
			echo "$itera $linea"
		fi
		(( itera=itera+1 ))
	done <$1
	exit 0
fi






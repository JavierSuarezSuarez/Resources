#! /bin/bash

#Script1 versión B: Se añade variable para guardar opcion si la hay y se añade posibilidad
# de leer de varios archivos
declare itera=0

#Control de parametros: Se tienen que pasar  1 o más parametros
if [[ $# -lt 1 ]]
then
	echo "Invocacion incorrecta"
fi

#Si se le pasa el fichero con alguna opcion ...
if [[ ($# -gt 1) && (($1 == "--par") || ($1 == "--impar")) ]]
then

	#Variable para guardar la opción para que no se pierda a medida que se mueven argumentos
	declare opcion=$1
	shift                            #Descartamos primer argumento

	while (( $# != 0 ))
	do 
		#Bucle de lectura del fichero
		while read linea
		do
			#Si en el primer argumento se pasa la opcion --impar
			if [[ $opcion == "--impar" ]]
			then
				if (( itera%2!=0 ))
				then
					echo "$itera $linea"
				fi
			#Si en el primer argumento se pasa la opcion --par
			elif [[ $opcion == "--par" ]]
			then
				if (( itera%2==0 ))
				then
					echo "$itera $linea"
				fi
			fi
			(( itera=itera+1 ))
		done <$1
		itera=0
		shift
	done
	exit 0
fi

# Si solo se le pasa los ficheros ...
if [[ ($# -eq 1) || (($# -gt 1) && (($1 != "--impar") || ($1 != "--par"))) ]]
then
	while (( $# != 0 ))
	do
		#Bucle de lectura del fichero
		while read linea
		do
			if (( itera%2!=0 ))
			then
				echo "$itera $linea"
			fi
			(( itera=itera+1 ))
		done <$1
		itera=0
		shift
	done
	exit 0
fi






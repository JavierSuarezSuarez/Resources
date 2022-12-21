#! /bin/bash

#Script 6: Lee de dos ficheros e imprime sus líneas de forma entrelazada, imprimiendo,
#si son de tamaño diferente, el resto de líneas del más largo

#Control de parámetros:Se deben pasar los dos ficheros
if [[ $# -lt 2 ]]
then
	echo "Invocación incorrecta: Se deben pasar dos argumentos" 1>&2
	exit 1
fi
#Variables para comprobar tamaño de ficheros basándose en el nº de líneas
declare cant1=$(cat $1 | wc -l)
declare cant2=$(cat $2 | wc -l)
#Variables para imprimir las líneas pertinentes
declare i=0
declare j=1
declare max # Variable para guardar el tamaño del fichero más grande e iterar

#Asignamos a max el tamaño mayor
if(( cant1 > cant2 ))
then
	max=cant1
else
	max=cant2
fi

#Mientras no se llegue al maximo de iteraciones
while (( i<=max ))  
do
	#Dependiendo de la linea, usamos head y tail con indice auxiliar para imprimirla
	if(( cant1-i>0 ))
	then
		echo $(cat $1 | head -$j | tail -1)
	fi

	if(( cant2-i>0 ))
	then
		echo $(cat $2 | head -$j | tail -1)
	fi
	(( j++ ))
	(( i++ ))
done 
exit 0



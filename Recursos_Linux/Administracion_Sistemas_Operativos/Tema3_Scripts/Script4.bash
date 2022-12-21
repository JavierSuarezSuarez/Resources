#! /bin/bash

#Script 4: Buscar archivos con extension .cpp y renombrarlos como .cc. Busqueda recursiva a partir
# de ruta inicial R pasada como argumento. si se omite R, se hace desde directorio actual

#Control de parametros: Se pueden pasar o 0 o 1 parámetros
if [[ $# -gt 1 ]]
then
	echo "Invocación incorrecta: Demasiados argumentos"
	exit 1
fi

#Variable donde almacenar las busquedas del find
declare busqueda=""
#Si se pasa la ruta como argumento y esta corresponde a un directorio  ...
if [[ ($# -eq 1) && (-d $1) ]]
then
	#Realizamos busqueda en directorio pasado como argumento
	busqueda=$(find $1 -type f -regex ".*\.cpp")

	#Para cada linea de la busqueda, renombramos con rename
	for linea in $busqueda
	do
 		rename   ".cpp" ".cc" "$linea"
	done	
	exit 0
fi


#Si no se pasa la ruta como argumento ...
if [[ $# -eq 0 ]]
then
	#Realizamos busqueda en directorio actual
	busqueda=$(find . -type f -regex ".*\.cpp")

	#Para cada linea de la busqueda, renombramos con rename
	for linea in $busqueda
	do
 		rename   ".cpp" ".cc" "$linea"
	done	
	exit 0
fi








#! /bin/bash

#Script3: Para un numero entero pasado como argumento, se debe obtener la relación de usuarios
#del sistema que son propietarios de un numero de archivos mayor o igual que ese numero

#Control de parámetros
if [[ $# -ne 1 ]]
then
	echo "Invocación incorrecta: Se debe pasar un argumento"
	exit 1
fi

declare numfiles=0 # Variable para guardar el numero de archivos encontrados

#Leemos de una copia del fichero /etc/passwd ya que aquí estan los usuarios del sistema 
IFS=:
while read username c2 c3 c4 c5 c6 c7
do

	#Hacemos la búsqueda de los archivos usando find y su nombre de usuario y contamos con wc -l
	numfiles=$(find / -user $username 2>/dev/null | wc -l)

	#Si el número de archivos es >= que el argumento, lo imprimimos
	if [[ $numfiles -ge $1 ]]
	then
		echo "El usuario $username es propietario de $numfiles archivos"
	fi

done < /etc/passwd

exit 0

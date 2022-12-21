#! /bin/bash

#Script que comprueba que usuarios se han pasado de un límite de intentos fallidos de acceso al sistema
#escribiendo sus nombres en /var/log/login_unsuccessful

#Control de parámetros: Solo se puede pasar 1 argumento o ninguno
if [[ $# -gt 1 ]]
then
	echo "Error: Demasdiados argumentos" 1>&2
	exit 1
fi

#Elección del límite (por defecto o pasado por argumentos)
declare limite
if [[ $# -eq 1 ]]
then
	limite=$1
else
	limite=3
fi


#Array asociativo donde la clave es el nombre del usuario y el valor su nº de accesos fallidos
declare -A nombreusuarios
#Cadena que sirve como comprobante para contabilizar nº de accesos fallidos de los usuarios 
declare comprobante="password|check|failed|for|user" 

#Lectura fichero /var/log/secure
IFS=" "
while read linea
do
        lineamod=$(echo "$linea" | tr -s ' ' '|') #Cambiamos espacios por |
	campos=$(echo "$lineamod" | cut -d'|' -f6,7,8,9,10,11) #Nos quedamos con ultimos campos
	camposredu=$(echo "$campos" | cut -d'|' -f1,2,3,4,5) #Nos quedamos con campos de comprobante
	username=$(echo "$campos" | cut -d'|' -f6 | tr -d '('| tr -d ')') #Guardamos nombre usuario sin ()
        
        #Si la eleccion de campos es equivalente a comprobante
	if [[ $camposredu = $comprobante ]]
	then
		#Si el nombre del usuario esta contenido en el array asociativo
		if [[ ${nombreusuarios[$username]+si} = "si" ]]
		then
			value=${nombreusuarios[$username]} #Sacamos su Value
			(( valueinc=$value+1 )) #Lo incrementamos en 1
			nombreusuarios[$username]=$valueinc #Asignamos valor incrementado
		else
			nombreusuarios+=([$username]=1) #Si no esta contenido, lo inicializamos en array
		fi
		
	fi
done  < /var/log/secure

declare -A listausuarios #Array asociativo para posteriormente escribir los usuarios

#Recorremos el array asociativo
#$j es el username y ${nombreusuarios[$j]} el nº de accesos fallidos
for j in ${!nombreusuarios[@]}
do
	valor=${nombreusuarios[$j]}
	#Si el value supera el limite lo añadimos a listausuarios
	if (( $valor>=$limite ))
	then
		listausuarios[$j]=${nombreusuarios[$j]}
	fi
done

#Creación y escritura en fichero /var/log/login_unsuccessful
declare i=0 #Indice para listausuarios

#Recorremos el array asociativo
for i in ${!listausuarios[@]}
do
      #Si la key no esta vacia
      if [[ !(-z $i) ]]
      then
      	echo " $i Nº de intentos = ${listausuarios[$i]} " >> ./fichlogin #>> /var/log/login_unsuccessful
      fi
      (( i++ ))
done
exit 0








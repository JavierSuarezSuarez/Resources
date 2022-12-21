#! /bin/bash

#Control de parámetros
if [[ $# != 1 ]]
then
	echo "Error: No se ha pasado el límite de accesos fallidos a comprobar" 1>&2
	exit 1
fi

#Lectura fichero /var/log/secure
declare limite=$1
declare -a listausuarios
declare -A nombreusuarios
declare cadena="password|check|failed|for|user" 
IFS=" "
while read linea
do
	#echo "$linea"
        lineamod=$(echo "$linea" | tr -s ' ' '|')
        #echo "$lineamod"
	campos=$(echo "$lineamod" | cut -d'|' -f6,7,8,9,10,11)
	#echo "$campos"
	camposredu=$(echo "$campos" | cut -d'|' -f1,2,3,4,5)
	usernameaux=$(echo "$campos" | cut -d'|' -f6)
	usernameaux2=$(echo "$usernameaux" | tr -d '(')
	username=$(echo "$usernameaux2" | tr -d ')')
	
	if [[ $camposredu = $cadena ]]
	then
		if [[ ${nombreusuarios[$username]+si} = "si" ]]
		then
			value=${nombreusuarios[$username]}
			(( valueinc=$value+1 ))
			nombreusuarios[$username]=$valueinc
		else
			nombreusuarios+=([$username]=1)
		fi
		
	fi
done  < /var/log/secure

declare i=0
for j in ${nombreusuarios[*]}
do
	if (( nombreusuarios.get(j) >= $limite ))
	then
		listausuarios[i] = $nombreusuario
 		(( i++ ))
	fi
done
#echo "Key=${!nombreusuarios[$j]} Value=$j"
#Creación y escritura en fichero /var/log/login_unsuccessful
#i = 0
#while (( i <= ${#listausuarios[*]} ))
#do
#      echo "${listausuarios[i]} Nº de intentos = " >> /var/log/login_unsuccessful
#      (( i++ ))
#done
exit 0

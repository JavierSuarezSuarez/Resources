#! /bin/bash

#Script que comprueba que usuarios se han pasado de un límite de intentos fallidos de acceso al sistema
#escribiendo sus nombres (y en opcion adicional, marcas en caso de caducidad de cuenta y/o contraseña)
#en /var/log/login_unsuccessful 

#Control de parámetros: Solo se puede pasar 1 argumento o ninguno
if [[ $# -gt 1 ]]
then
	echo "Error: Demasiados argumentos" 1>&2
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
        username=$(echo "$campos" | cut -d'|' -f6 | tr -d '('| tr -d ')') #Guardamos username sin ()
        
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
done  <  /var/log/secure

declare -A listausuarios #Array asociativo para posteriormente escribir los usuarios

#Recorremos el array asociativo nombreusuarios
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
declare cadena
#Recorremos el array asociativo listausuarios
for i in ${!listausuarios[@]}
do
      cuenta=$(grep -E "^$i.*" /etc/shadow | cut -d: -f8)   #Campo 8 de /etc/shadow
      password=$(grep -E "^$i.*" /etc/shadow | cut -d: -f5) #Campo 5 de /etc/shadow 

      #Si la key no esta vacia
      if [[ !(-z $i) ]]
      then
	#Opcion adicional: Diferenciamos casos en los que los usuarios tienen o no caducidad de cuenta 
        #y/o contraseña y escribimos o no en el fichero en cada caso una marca para indicarlo
        if [[ !(-z $cuenta) && !(-z $password) ]]
        then
              cadena="$i Nº de intentos = ${listausuarios[$i]}"
        elif [[ !(-z $cuenta) && -z $password ]]
	then
              cadena="$i Nº de intentos = ${listausuarios[$i]} NoCadPwd"
	elif [[ -z $cuenta && !(-z $password) ]]
	then
              cadena="$i Nº de intentos = ${listausuarios[$i]} NoCadCuenta"
	else
	      cadena="$i Nº de intentos = ${listausuarios[$i]} NoCadPwd NoCadCuenta"
	fi
      	echo "$cadena" >> /var/log/login_unsuccessful
      fi
      (( i++ ))
done
exit 0








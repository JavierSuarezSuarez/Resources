#! /bin/bash

#Script 4.1: Crea 40 cuentas de usuario, con las politicas de contraseña del apartado 2 del guion, añadiendolas a un mismo grupo myusers donde hay un usuario administrador poweruser. 
#Las 40 cuentas tienen como directorio personal /Users y todas comparten una carpeta de rw en
#/Users/ denominada myusers 

#Si el directorio /Usersno no existía, lo creamos
if [[ !(-d /Users) ]]
then
	mkdir /Users
fi

#Creamos la carpeta compartida con permisos rw para propietario y grupo
mkdir --mode=660 /Users/myusers
#Creamos el grupo myusers
groupadd myusers
#Creamos usuario poweruser teniendo como grupo principal myusers(-g) y sin directorio personal(-M)
useradd -g myusers -M poweruser
#Hacemos que poweruser sea administrador del grupo myusers
gpasswd -A poweruser myusers

#Hacemos que poweruser sea propietario de carpeta compartida y que esta sea del grupo myusers
chown poweruser /Users/myusers
chgrp myusers /Users/myusers


declare i=1 #Indice iterativo para ir creando las cuentas
#Mientras no superemos 40 iteraciones...
while (( i<=40 ))
do
	#Si estamos en las 10 primeras cuentas, hay que añadir un 0 a su nombre
	if (( i<10 ))
	then
		#Creamos cada cuenta de usuario con grupo principal myusers (-g)
		#definiendo su directorio personal y copiando contenido de /etc/skel (-md)
		useradd -g myusers -md /Users/user0$i user0$i
		chage -M 30 -m 15 -W 7 -I 7 user0$i #Politica contraseñas apartado 2 del guion
	else
		useradd -g myusers -md /Users/user$i  user$i
                chage -M 30 -m 15 -W 7 -I 7 user$i
	fi
        
	
	(( i=i+1 ))
done
exit 0




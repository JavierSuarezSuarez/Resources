#!/bin/bash

#Control de parámetros
if [[ $# -ne 1 ]]
then
	echo "Error: Se debe pasar solo 1 argumento" 1>&2
	exit 1
fi

if [[ !(-d ./Backups) ]] 
then
	mkdir ./Backups
fi

declare direc=./Backups
declare fecha=$(date +"%Y%m%d")
declare tag=$1


#Tratamiento de datos
if [[ $1 -eq 0 ]]
then

    #Primera forma
    #touch ./Backups/snapshot.txt
    #find /home -not -user root 2>/dev/null | tar -czf  $direc/backup-$tag-$fecha.tgz -T -

    #Segunda forma
    #find /home -not -user root 2>/dev/null | tar -cvzf  $direc/backup-tar-$tag-$fecha.tgz -g $direc/snapshot.txt --level=0 -T -

    #Tercera forma
    touch ./Backups/flag.txt
    find /home -not -user root 2>/dev/null | cpio -ov | gzip > $direc/backup-$tag-$fecha.cpio.gz

else

    #Primera Forma
    #touch ./Backups/snapshot.txt
    #(( tag=$1-1 ))
    #find /home -not -user root -newer $direc/snapshot.txt 2>/dev/null | tar -czf  $direc/backup-$1-$fecha.tgz -T -

    #Segunda Forma 
    #find /home -not -user root 2>/dev/null | tar -cvzf  $direc/backup-tar-$tag-$fecha.tgz -g $direc/snapshot.txt --level=$1 -T -

    #Tercera Forma
    find /home -not -user root -newer $direc/flag.cpio 2>/dev/null | cpio -ov | gzip > $direc/backup-$tag-$fecha.cpio.gz
    touch ./Backups/flag.txt

fi

exit 0





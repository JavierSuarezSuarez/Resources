#! /bin/bash
#Script CopiaCompleta.bash: Crea el directorio /backups en caso de que no exista y realiza una copia completa de los archivos bajo /home que no son de root
if [[ !(-d /backups) ]]
then
	mkdir /backups
fi

find /home -not -user root 2>/dev/null | tar -czf /backups/backup-home-completa-$(date +"%Y%m%d").tgz --level=0 -g snapshot.txt -T -

exit 0

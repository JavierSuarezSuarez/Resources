#! /bin/bash
#Script CopiaNivel1.bash: Se crea la copia de Nivel 1 con referencia del fichero testigo snapshot.txt
find /home -not -user root | tar czf /backups/backup-home-nivel1-$(date +"%Y%m%d").tgz --level=1 -g snapshot.txt -T -

exit 0

#! /bin/bash
#Script CopiaNivel2.bash: Se crea la copia de Nivel 2 con referencia del fichero testigo snapshot.txt
find /home -not -user root | tar czf /backups/backup-home-nivel2-$(date +"%Y%m%d").tgz --level=2 -g snapshot.txt -T -

exit 0

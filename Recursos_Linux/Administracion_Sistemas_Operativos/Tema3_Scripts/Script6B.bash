#! /bin/bash


if [[ $# -lt 2 ]]
then
	echo "Invocación incorrecta: Se deben pasar dos argumentos" 1>&2
	exit 1
fi
IFS=:
declare numlin
declare cant1=$(cat $1 | wc -l)
declare cant2=$(cat $2 | wc -l)

declare i=0
declare j=1
declare max
declare -A ficheros
declare params=$#
echo $params
while (( $i<=$params ))
do
	if (( $(cat $1 | wc -l) > max ))
	then
		max=$(cat $1 | wc -l) 
	fi 
	ficheros[i]=$(cat $1)
	(( i++ ))
	echo $i
	shift
done
i=0
while (( i<=max ))  
do
	for k in ${ficheros[@]}
	do
		if(( $(wc -l ${ficheros[k]})>0 ))
		then
			echo $(cat ${ficheros[k]} | head -$j | tail -1)
		fi
	done
	(( j++ ))
	(( i++ ))

done 
exit 0



#! /bin/bash

rm -rf /Users
userdel -r poweruser
declare i=1
while (( i<=40 ))
do
	if (( i<10 ))
	then
			userdel -r user0$i
	else
	 		userdel -r user$i
	fi
        (( i=i+1 ))
done
groupdel myusers
exit 0

#!/bin/bash

#Script para ilustrar el funcionamiento del switch/case combinado con For
shopt -s extglob

for A in $*
do
	case $A in
	A) echo "la variable A contiene el valor A";;
	B) echo "la variabe A contiene el valor  B";;
   +([0-9])) echo "la variable A contiene solo digitos";;
	*) echo "la variable A contiene otra cosa";;
	
	esac
done

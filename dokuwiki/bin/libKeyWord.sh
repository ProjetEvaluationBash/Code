#!/bin/bash

nb =0 
keyWords [100]
nbKeyWords= 0

#Parcours des 7 chapitres
for i in 7
	#On recupere le nombre de keywords dans chaque chapitre
	nbKeyWords = $nbKeyWords + `wc -w ../Modules/systemiutaubiere/lesson/keywords$i.txt
	for j in $nbKeyWords
		#Pour chaque keyword on le recupère et on le met dans le tableau keyWords
		keyword= `cut -f $j -d`
		keyWords[$nb] = $keyword
	done
done 

		 

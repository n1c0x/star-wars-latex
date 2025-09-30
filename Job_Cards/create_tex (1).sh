#!/bin/bash
input="contents-test.csv"
i=1
while read -r var
do
#	test $i -eq 1 && ((i=i+1)) && continue
	id=$(echo $var | awk -F';' '{printf "%s", $1}' | tr -d '"')
	title=$(echo $var | awk -F';' '{printf "%s", $2}' | tr -d '"')
	description=$(echo $var | awk -F';' '{printf "%s", $3}' | tr -d '"')
	cible=$(echo $var | awk -F';' '{printf "%s", $4}' | tr -d '"')
	difficulte=$(echo $var | awk -F';' '{printf "%s", $5}' | tr -d '"')
	difficulte1=$(echo $difficulte | awk -F',' '{printf "%s", $1}')
	difficulte2=$(echo $difficulte | awk -F',' '{printf "%s", $2}')
	types=$(echo $var | awk -F';' '{printf "%s", $6}' | tr -d '"')
	type1=$(echo $types | awk -F',' '{printf "%s", $1}')
	type2=$(echo $types | awk -F',' '{printf "%s", $2}')
	competences=$(echo $var | awk -F';' '{printf "%s", $7}' | tr -d '"')
	competences1=$(echo $competences | awk -F',' '{printf "%s", $1}')
	competences2=$(echo $competences | awk -F',' '{printf "%s", $2}')
	recompense=$(echo $var | awk -F';' '{printf "%s", $8}' | tr -d '"')
	recompense1=$(echo $recompense | awk -F',' '{printf "%s", $1}')
	recompense2=$(echo $recompense | awk -F',' '{printf "%s", $2}')

#	echo "id :"$id
#	echo "title :"$title
#	echo "description :"$description
#	echo "cible :"$cible
#8	echo "difficulte :"$difficulte1" et "$difficulte2
	nb_violet=${difficulte1:0:1}
	nb_rouge=${difficulte2:0:1}
#	[ -z $nb_violet ] && echo "Il n'y a pas de dés violets" || echo "Il y a $nb_violet dés violets"
#	[ -z $nb_rouge ] && echo "Il n'y a pas de dés rouges" || echo "Il y a $nb_rouge dés rouges"
	#echo "Il y a $nb_rouge dés rouges"
#	echo "type :"$type1" et "$type2
#	echo "competences :"$competences1" et "$competences2
#	echo "recompenses :"$recompense1" et "$recompense2

	# mission_id.tex file
#	for i in {1..60};do printf "#";done && printf "\n"
#	for i in {1..20};do printf "#";done
	printf "mission_%d.tex file\n" "$id"
#	for i in {1..20};do printf "#";done && printf "\n"
#	for i in {1..60};do printf "#";done && printf "\n"
#	for i in {1..100};do printf "-";done && printf "\n"
	
	for i in $(seq 1 3 30); do
		if (( $i == $id )); then
			printf "\\\newcommand{\\cardtypeMissionOne}{\\cardtype{DarkGreen}{{%s}}}\n" "$title" > test_deck/mission_$id.tex
			printf "\\\begin{tikzpicture}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardborder\n" >> test_deck/mission_$id.tex
			printf "\t\\cardbackground{./test_deck/background-1.jpg}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardtypeMissionOne\n" >> test_deck/mission_$id.tex
		fi
	done
	for i in $(seq 2 3 30); do
		if (( $i == $id )); then
			printf "\\\newcommand{\\cardtypeMissionTwo}{\\cardtype{DarkRed}{{%s}}}\n" "$title" > test_deck/mission_$id.tex
			printf "\\\begin{tikzpicture}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardborder\n" >> test_deck/mission_$id.tex
			printf "\t\\cardbackground{./test_deck/background-1.jpg}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardtypeMissionTwo\n" >> test_deck/mission_$id.tex
		fi
	done
	for i in $(seq 3 3 30); do
		if (( $i == $id )); then
			printf "\\\newcommand{\\cardtypeMissionThree}{\\cardtype{DarkGold}{{%s}}}\n" "$title" > test_deck/mission_$id.tex
			printf "\\\begin{tikzpicture}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardborder\n" >> test_deck/mission_$id.tex
			printf "\t\\cardbackground{./test_deck/background-1.jpg}\n" >> test_deck/mission_$id.tex
			printf "\t\\cardtypeMissionThree\n" >> test_deck/mission_$id.tex
		fi
	done
	[ -z "$recompense2" ] && printf "\t\\cardtitle{%s Cr}\n" "$recompense1" >> test_deck/mission_$id.tex || printf "\t\\cardtitle{%s --- %s Cr}\n" "$recompense1" "$recompense2" >> test_deck/mission_$id.tex
	printf "\t\cardcontent{Mission}{%s\n" "$description" >> test_deck/mission_$id.tex
	printf "\t\t\\\vspace{3ex} \\\\\ \n" >> test_deck/mission_$id.tex
	printf "\t\t\\\textbf{Cible} \\\textit{%s}\n" "$cible" >> test_deck/mission_$id.tex
	printf "\t\t\\\vspace{1ex} \\\\\ \n" >> test_deck/mission_$id.tex
	printf "\t\t\\\textbf{Difficult\\\'{e} } " >> test_deck/mission_$id.tex
	if [ ! -z $nb_violet ]
	then
       		for i in `seq 1 $nb_violet`;
		do
			printf "\includegraphics[width=0.05\linewidth]{./test_deck/dice_purple} " >> test_deck/mission_$id.tex
		done
	fi
	if [ ! -z $nb_rouge ]
	then
       		for i in `seq 1 $nb_rouge`;
		do
			printf "\includegraphics[width=0.05\linewidth]{./test_deck/dice_red} " >> test_deck/mission_$id.tex
		done
	fi
	printf "\n" >> test_deck/mission_$id.tex
	printf "\t\t\\\vspace{1ex} \\\\\ \n" >> test_deck/mission_$id.tex
	[ -z "$type2" ] && printf "\t\t\\\textbf{Type} %s\n" "$type1"  >> test_deck/mission_$id.tex || printf " \t\t\\\textbf{Type} %s, %s \n" "$type1" "$type2" >> test_deck/mission_$id.tex
	printf "\t\t\\\vspace{1ex} \\\\\ \n" >> test_deck/mission_$id.tex
	[ -z "$competences2" ] && printf "\t\t\\\textbf{Comp\\\'{e}tences} %s}\n" "$competences1" >> test_deck/mission_$id.tex || printf "\t\t\\\textbf{Comp\\\'{e}tences} %s, %s}\n" "$competences1" "$competences2" >> test_deck/mission_$id.tex
	printf "\\\end{tikzpicture}\n" >> test_deck/mission_$id.tex
	printf "Done\n"
done < "$input"

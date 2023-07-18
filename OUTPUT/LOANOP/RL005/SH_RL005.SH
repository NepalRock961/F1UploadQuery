#!/bin/hash

echo "-------------------RL005 generate file solewise-----------------";

rm -r solwise_RL005
mkdir solwise_RL005
cut -c20-25 RL005.txt | sort | uniq > branch_currency

for line in `cat branch_currency` ;
	
	do
		br=$(cut -c4-6 <<< "$line")
		cr=$(cut -c-3 <<< "$line")
		grep $line RL005.txt >> "solwise_RL005/"$br'_RL005_'$cr.txt;

done







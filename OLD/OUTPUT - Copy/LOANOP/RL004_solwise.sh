 #!/bin/hash

echo "-------------------RL004 generate file solewise-----------------";
rm -r RL004_sol
mkdir RL004_sol

cut -c20-25 RL004.txt | uniq > branch_currency
#DESTDIR="CAA_bal";
#FILENAME="CS004_CAA";

for line in `cat branch_currency` ;
	
	do
		br=$(cut -c4-6 <<< "$line")
		cr=$(cut -c-3 <<< "$line")
		grep $line RL004.txt >> "RL004_sol/"$br'_DISB_'$cr.txt;

done



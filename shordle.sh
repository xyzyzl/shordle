# colors
RED='\033[1;31m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RES='\033[0m'

# pick the random word
KEY=$(sort -R words.txt | awk 'NR <= 1 { print $1 }')
echo $KEY

echo "we have a cool word. it's guaranteed to be 5 letters long. you have six tries. now guess."
right=0
#STR=$(echo ^\($(paste -sd'|' words.txt)\)$)
for i in {1..6}
do
	while true
	do
		echo "attempt $i: input a line"
		read word
		#if [[ "$word" =~ $(echo ^\($(paste -sd'|' words.txt)\)$) ]]; then
		#echo $STR
		if grep -Fxq "$word" words.txt; then
			resu=""
			for j in {0..4}
			do
				ch1=${word:$j:1}
				ch2=${KEY:$j:1}
				if [ $ch1 == $ch2 ]; then
					export resu=$resu${GRN}$ch1${RES}
				elif [[ $KEY == *$ch1* ]]; then # this part needs to be somewhat changed
					export resu=$resu${YEL}$ch1${RES}
				else
					export resu=$resu${RED}$ch1${RES}
				fi
			done
			echo $resu
			if [ $word == $KEY ]; then
				echo "${GRN}congrations${RES}"
				right=1
			fi
			break
		else
			echo "${YEL}word not found${RES}"
			continue
		fi
	done
	if [[ "$right" == "1" ]]; then
		break
	fi
done

if [[ "$right" == "0" ]]; then
	echo "${RED}ur bad lmao${RES}"
fi
echo "the word was \"$KEY\""

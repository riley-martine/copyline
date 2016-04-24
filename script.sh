#!/bin/bash
COUNT=1
LINES="$(perl -lne 'END { print $. }' lines.txt)" #get total number of lines in file

echo "./lines.txt being used"
touch lines.txt
touch temp.txt

while [ $LINES -ge $COUNT ]; do
	#read -n 1 -s                             #pause for keypress
         sleep 1                                  #other option, waits 1 second

	sed "${COUNT}q;d" lines.txt > temp.txt       #get line $COUNT from file
	xclip -in -selection c temp.txt           #copy to clipboard

	echo line $COUNT / $LINES -- `expr $LINES - $COUNT` left 
                                                 #say how many left
	echo "$(xclip -selection c -o)"          #show what has been copied

	rm temp.txt && touch temp.txt            #I'm an idiot I know
	let COUNT+=1                           #iterate to next line
done

echo success
echo exiting...

rm temp.txt                                      #cleanup


#!/bin/bash
COUNT=1
LINES="$(perl -lne 'END { print $. }' ~/hi.txt)" #get total number of lines in file

while [ $LINES -gt $COUNT ]; do
	read -n 1 -s                             #pause for keypress
       #sleep 2                                  #other option, waits 2 seconds

	sed "${COUNT}q;d" ~/hi.txt > ~/temp.txt  #get line $COUNT from file
	xclip -in -selection c ~/temp.txt        #copy to clipboard

	echo line $COUNT / $LINES -- `expr $LINES - $COUNT` left 
                                                 #say how many left
	echo "$(xclip -selection c -o)"          #show what has been copied

	rm temp.txt && touch temp.txt            #I'm an idiot I know
	let COUNT+=1                             #iterate to next line
done

rm temp.txt                                      #cleanup


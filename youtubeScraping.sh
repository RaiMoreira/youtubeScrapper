#!/bin/bash

function main(){
	grep views index.html | 
	while read line; do
		x=`expr "$line" : ".*<li>\(.*\) views</li>"`
		x=${x//,/}	#will remove all the commas from value in x
		echo "$x","" 
	done > views.txt

#note the format that users are listed is href="/user/latenight"

	grep user index.html |
	while read line; do
		username=`expr "$line" : ".*href=\"\/user/\\([^\"]*\)\".*"`
		echo "$username","" 
	done > user.txt

	grep "\- Duration: \(.*\).</span>" index.html |
	while read line; do
		time=`expr "$line" : ".*Duration: \(.*\).</span></h3>"`
		echo "$time","" 
	done > duration.txt


	grep "title=\"\(.*\) aria-describedby" index.html | grep -v \&# |
	while read line; do
		title=`expr "$line" : ".*title=\(.*\) aria-describedby"`
					
		echo "$title" 
		
	done > title.txt
	
	`sed 's/,/MY_COMMA/g' title.txt > titlenew.txt`
	`paste views.txt user.txt duration.txt titlenew.txt > mytable.csv
`

	printf "%-30s | %-30s | %-30s |  %-30s" "$time" "$title" "$username" "$x"
	
	
}

main


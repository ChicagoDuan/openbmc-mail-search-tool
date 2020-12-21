#!/bin/bash

#Author: ChicagoDuan(duanzhijia01@inspur.com)

searchContent=$1

currentYear=`date +%Y`
currentMonth=`date +%B`

arrayMonth=("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")

mkdir openbmc_mail_log 2>> log.txt
cd openbmc_mail_log

echo "Start downloading all mails, please wait patiently"

for((i=2015;i<=currentYear;i++))
do
	for j in {0..11};do
	
		if [[ $i == 2015 && $j -lt 8 ]]
		then
			continue
		fi
		
		if [ -f "$i-${arrayMonth[$j]}.txt" ]; then
			if [ "$i-${arrayMonth[$j]}.txt" != "$currentYear-$currentMonth.txt" ]; then
				continue	
			fi
		fi

		wget https://lists.ozlabs.org/pipermail/openbmc/$i-${arrayMonth[$j]}.txt.gz 2>> log.txt
		gzip -df $i-${arrayMonth[$j]}.txt.gz 2>> log.txt
			
		if [ "$i-${arrayMonth[$j]}.txt" == "$currentYear-$currentMonth.txt" ]; then
			break	
		fi
	done

done

grep -riwn "$searchContent" *

exit

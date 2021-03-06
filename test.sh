#!/bin/bash

echo Listening to large files
error=false
limit=50k

for d in */ ; do
d=${d%/}
if [ "$d" != "build" -a "$d" != "import" ]
then
	files=$(find "$d/" -type f -size +$limit -iregex '.*\.\(png\|jpg\|jpeg\)')
	echo $files | grep -q .
	if [ $? -ne 0 ]
	then
		echo $d is okay
	else
		echo $d is faulty
		echo Offending Files:
		echo $files
		error=true
	fi
fi
done

if [ $error == true ]
then
exit 1
fi


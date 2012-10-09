#!/bin/bash

artist="Joe Test" #get these from Spinitron
song="Testing"
notes="(cart 1234)"

cart=`echo "$notes" | sed "s/[^0-9.]*\([0-9.]*\).*/\1/"`

if [ -z "$cart" ];
then
    echo "No cart number found"
    #Show error message in popup box
fi

sched_code="CLEAN" #get this from Rivendell SQL

if [ "$sched_code" = "CLEAN" ] || [ "$sched_code" = "EXPLICIT" ];
then
    message=`echo "Rivendell thinks" $song "by" $artist "is" $sched_code".\n"`
else
    message=`echo "Rivendell doesn't know if" $song "by" $artist "is clean.\n"`
fi

#Use $message in dialog box.
#Options: Mark as CLEAN, Mark as EXPLICIT, Mark as mislabeled, Cancel

#!/bin/bash
echo "Type all you want, or type STOP to stop script"
x="Go"
while [ $x != "STOP" ]
do
read x
echo $x
done


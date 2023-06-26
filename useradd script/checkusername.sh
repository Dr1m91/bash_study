#!/bin/bash
echo 'Check username'
read u
i=1
while cut -d: -f1 /etc/passwd | grep ^$u$ >> /dev/null
	do
	u=$u$i
	((i++))
echo $u не занят
done

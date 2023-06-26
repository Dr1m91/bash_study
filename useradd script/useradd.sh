#!/bin/bash
if [ "$(id -u)" != 0 ];
then
echo 'You  dont have permissions'
exit
fi

echo "Username"
read u
echo "User group"
read g
# read -p "Username: " u
# read -p "Group: " g



if grep $g /etc/group >> /dev/null ;
then
echo 'Group '$g' is already exists'
else
groupadd $g
fi


cp /etc/sudoers /root/sudoers_backup.txt


#if [ "$g"  = "admins" -o "$g" = "security" ];
if [ "$g"  = "admins" ] || [ "$g" = "security" ];
then
echo "$u" 'ALL=(ALL) ALL' >> /etc/sudoers
else
echo ''$u' is not  admin'
fi

if ls /home | grep $g >> /dev/null;
then
useradd $u -g $g -b /home/$g -s /bin/bash
echo 'P@ssw0rd' | passwd "$u" --stdin
passwd --expire "$u"
else
mkdir /home/$g
useradd $u -g $g -b /home/$g -s /bin/bash
echo 'P@ssw0rd' | passwd "$u" --stdin
passwd --expire "$u"
fi



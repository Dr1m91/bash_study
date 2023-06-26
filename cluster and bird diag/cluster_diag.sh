#!/bin/bash


t=`date "+%d_%m_%Y"`;
id=`hwserial`;


function get_config_cgw() {
        echo {} | fastcgicli -p 8082 -m POST -j -c -u /api-v1-server/config/active/get-config/$id
}

function cluster_diag() {

echo '============= CLUSTER SERVICES STATUS ==========='  > /tmp/diag_$t.txt
echo '=================================================' >> /tmp/diag_$t.txt
echo '=================================================' >> /tmp/diag_$t.txt
echo '=================================================' >> /tmp/diag_$t.txt



service pacemaker status >> /tmp/diag_$t.txt
service corosync status >> /tmp/diag_$t.txt
service postgresql status >> /tmp/diag_$t.txt
service djdbcgw status >> /tmp/diag_$t.txt
service monit status >> /tmp/diag_$t.txt
service nginx status >> /tmp/diag_$t.txt
get_config_cgw | grep "version" >>/tmp/diag_$t.txt

echo '================= PCS STATUS =============' >> /tmp/diag_$t.txt
echo '==========================================' >> /tmp/diag_$t.txt
echo '==========================================' >> /tmp/diag_$t.txt
echo '==========================================' >> /tmp/diag_$t.txt
pcs status >>/tmp/diag_$t.txt



mkdir /tmp/diagdir
cp -r /var/log /tmp/diagdir
cp /tmp/diag_$t.txt /tmp/diagdir
tar -zcf backup_$t.tar.gz diagdir 
rm -r /tmp/diagdir
}
#rm /tmp/diag_$t.txt

function bird_diag() {
cat bird.conf > /tmp/bird_diag_$t.txt
cat /var/log/messages | grep bird >> /tmp/bird_diag_$t.txt
}

select comand in cluster_diag bird_diag stop
do case $comand in 
	cluster_diag) cluster_diag ;;
	bird_diag) bird_diag ;;
	stop) break ;;
	*) echo 'Unknown comand' ;;
esac
done

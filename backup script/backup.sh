#!/bin/bash
#backup /root/ass to  zabbix-server

t=`date "+%d_%m_%Y"`

echo 'Выберите нужный пункт: '
echo '1)tar- создаст tar.gz архив'
echo '2)scp- отправит бекап до заббикс сервера'
echo '3)rm- удалит созданный архив на локальном сервере'
echo '4)stop- завершение скрипта'

echo '========================================================='
echo '========================================================='
echo '========================================================='
echo '========================================================='
echo '========================================================='

select comand in tar scp rm stop
do case $comand in
	tar) tar -zvcf /tmp/backup_$t.tar.gz /root/ass ;;
	scp) scp /tmp/backup_$t.tar.gz dr@172.18.45.141:/home/dr ;;
	rm) rm -v /tmp/backup_$t.tar.gz ;;
        stop) break ;;
	*) echo 'Такой команды не существует' ;;
esac
done

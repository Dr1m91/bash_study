#!/bin/bash

select number in Grafana Htop Uptime stop
do case $number in
	Grafana) systemctl status grafana-server ;;
	Htop) htop ;;
	Uptime) uptime ;;
	stop) break ;;
	*) echo Такой команды не существует ;;
esac
done


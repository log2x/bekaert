#!/bin/bash

CURRENTTIME=`date +%Y-%m-%d-%X`

URL1="products-applications/basic-materials/textile/conductive-fibers-and-yarns-for-smart-textiles/born-gmbh?source=fromwechat"
URL2="products-applications/basic-materials/textile/conductive-fibers-and-yarns-for-smart-textiles/texible?source=fromwechat"

echo "现在的时间是： ${CURRENTTIME}" >> ~/URL1_IP_Count.txt
echo "PV总计:" >> ~/URL1_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL1} |awk '{print $1}' |wc -l >> ~/URL1_IP_Count.txt
echo "UV总计:" >> ~/URL1_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL1} |awk '{print $1}' |uniq -c |wc -l >> ~/URL1_IP_Count.txt
echo "------------------------------------------------------------" >> ~/URL1_IP_Count.txt

echo "现在的时间是： ${CURRENTTIME}" >> ~/URL2_IP_Count.txt
echo "PV总计:" >> ~/URL2_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL2} |awk '{print $1}' |wc -l >> ~/URL2_IP_Count.txt
echo "UV总计:" >> ~/URL2_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL2} |awk '{print $1}' | uniq -c |wc -l >> ~/URL2_IP_Count.txt
echo "------------------------------------------------------------" >> ~/URL2_IP_Count.txt


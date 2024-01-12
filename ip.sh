#!/bin/bash

CURRENTTIME=`date +%Y-%m-%d-%X`

URL1 = "products-applications/basic-materials/textile/conductive-fibers-and-yarns-for-smart-textiles/born-gmbh?source=fromwechat"
URL2 = "products-applications/basic-materials/textile/conductive-fibers-and-yarns-for-smart-textiles/texible?source=fromwechat"

echo "现在的时间是： ${CURRENTTIME}" >> ~/tmp/URL1_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL1} |awk '{print $1}' >> ~/tmp/URL1_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL1} |wc -l >> ~/tmp/URL1_Access_Count.txt
echo "------------------------------------------------------------" >> ~/tmp/URL1_IP_Count.txt

echo "现在的时间是： ${CURRENTTIME}" >> ~/tmp/URL2_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL2} |awk '{print $1}' >> ~/tmp/URL2_IP_Count.txt
sudo cat /var/log/nginx/bekaert.cn.log |grep ${URL2} |wc -l >> ~/tmp/URL2_Access_Count.txt
echo "------------------------------------------------------------" >> ~/tmp/URL1_IP_Count.txt


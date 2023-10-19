#!/usr/bin/env bash

#####################################################################
# Deployment for vue-storefront frontend
#
# Usage:
# ~/scripts/deployment/shell/deploy_vsf.sh <branch> <ENV>
#
# e.g:
# ~/scripts/deployment/shell/deploy_vue_storefront.sh master
# curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
# sudo apt-get install -y nodejs
#####################################################################
# Load necessary functions 

BRANCH="master";
if [ ! -z "$1" ]; then
        BRANCH="$1";
fi

ENV="dev";
if [ ! -z "$2" ]; then
        ENV="$2";
fi

case  $ENV  in
      dev)       
        WORKSPACE="/usr/share/nginx/html/dev.bekaert.cn"
      ;;
      uat)
        WORKSPACE="/usr/share/nginx/html/uat.bekaert.cn"
      ;;            
      prod)       
        WORKSPACE="/usr/share/nginx/html/prod.bekaert.cn"
      ;;
      *)              
esac 

cd $WORKSPACE
echo "kill node"
pm2 stop all
sleep 5

echo "git checkout -- ."
sudo -u ubuntu -H git checkout -- .
echo  "git fetch origin"
sudo -u ubuntu -H git fetch origin
echo  "git checkout -B ${BRANCH} origin/${BRANCH}"
git checkout -B ${BRANCH} origin/${BRANCH}

echo "rm -rf .nuxt/ node_modules/"
rm -rf .nuxt/ node_modules/  
echo "yarn install"
/usr/bin/yarn install

echo "yarn build"
/usr/bin/yarn build
sleep 5

echo "sudo -u ubuntu -H pm2 start"
pm2 start "yarn start"

# clean cache
echo "clean redis cache and varnish cache"
sudo redis-cli -n 0 FLUSHALL
sudo varnishadm ban "obj.http.X-Magento-Tags ~ .*"

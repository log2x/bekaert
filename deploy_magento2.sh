#!/usr/bin/env bash

#####################################################################
# Deployment for magento2.4.6 Backend
#
# Usage:
# ~/scripts/deployment/shell/deploy_magento2.sh <branch> <ENV>
#
# e.g:
# ~/scripts/deployment/shell/deploy_magento2.sh develop dev
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
        WORKSPACE="/usr/share/nginx/html/admin.dev.bekaert.cn"
      ;;
      uat)
        WORKSPACE="/usr/share/nginx/html/qa-api.bekaert.cn"
      ;;            
      prod)       
        WORKSPACE="/usr/share/nginx/html/api.bekaert.cn"
      ;;
      *)              
esac 

cd $WORKSPACE
sudo service cron stop
sleep 10

echo "git checkout -- ."
git checkout -- .
echo  "git fetch origin ${BRANCH}"
git fetch origin ${BRANCH}
echo  "git checkout -B ${BRANCH} origin/${BRANCH}"
git checkout -B ${BRANCH} origin/${BRANCH}
 
echo "Prebuilding"
echo "composer install --no-dev"
/usr/local/bin/composer install --no-dev
 
echo "sudo rm -rf var/cache/* var/page_cache/* var/view_preprocessed/* generated/metadata/* generated/code/* pub/static/adminhtml/* pub/static/frontend/* pub/static/_cache/* pub/static/_requirejs/*"
sudo rm -rf var/cache/* var/page_cache/* var/view_preprocessed/* generated/metadata/* generated/code/* pub/static/adminhtml/* pub/static/frontend/* pub/static/_cache/* pub/static/_requirejs/*

echo "www-data -H php bin/magento maintenance:enable"
sudo -u www-data -H php bin/magento maintenance:enable

echo "sudo -u www-data -H php bin/magento setup:upgrade"
sudo -u www-data -H php bin/magento setup:upgrade
 
echo "sudo -u www-data -H php bin/magento setup:di:compile"
sudo -u www-data -H php bin/magento setup:di:compile
 
echo "sudo -u www-data -H php bin/magento setup:static-content:deploy --theme=Magento/luma en_US"
sudo -u www-data -H php bin/magento setup:static-content:deploy -f
 
echo "sudo setfacl -R -m u:www-data:rwX -m u:\`whoami\`:rwX -m u:root:rwX app/etc var generated pub/media pub/static"
sudo setfacl -R -m  u:www-data:rwX -m u:`whoami`:rwX -m u:root:rwX app/etc var generated pub/media pub/static
echo "sudo setfacl -dR -m u:www-data:rwX -m u:\`whoami\`:rwX -m u:root:rwX app/etc var generated pub/media pub/static"
sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX -m u:root:rwX app/etc var generated pub/media pub/static

# clean cache 
echo "sudo -u www-data -H php bin/magento cache:enable"
sudo -u www-data -H php bin/magento cache:enable
sudo -u www-data -H php bin/magento cache:clean

echo "sudo service php8.1-fpm reload"
sudo service php8.1-fpm reload

# clean cache
echo "clean redis cache and varnish cache"
sudo redis-cli FLUSHALL
sudo varnishadm ban "obj.http.X-Magento-Tags ~ .*"

echo "www-data -H php bin/magento maintenance:disable"
sudo -u www-data -H php bin/magento maintenance:disable

sudo service cron start
#cp sitemap.xml
#cp -f pub/media/sitemap/sitemap.xml $(frontendWorkspace)/static/sitemap.xml

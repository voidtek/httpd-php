#!bin/bash
set -e
set -x
apt-get update
apt-get install -y wget unzip mysql-client git patch

# Install composer
wget https://getcomposer.org/installer -O /tmp/composer-install

php /tmp/composer-install --install-dir=/usr/bin --filename=composer

# Install drush
wget https://github.com/drush-ops/drush/releases/download/$(wget -O - https://api.github.com/repos/drush-ops/drush/releases 2>/dev/null | grep tag_name | awk -F '"' '{print $4}' | grep -m 1 "^8")/drush.phar -O /usr/bin/drush

# Touch up
ln -s /usr/bin/composer /usr/local/bin/composer
ln -s /usr/bin/drush /usr/local/bin/drush
chmod +x /usr/bin/composer /usr/bin/drush

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -Rf /root/.composer/cache

# docker-lamp-stack
Docker LAMP stack for PHP development

Prerequisites:

- [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [PHP-CLI](http://packages.ubuntu.com/xenial/php7.0-cli)
- [Composer](https://getcomposer.org/download/)

## 1. Add your user to docker group
- `sudo gpasswd -a {your_username} docker`
- `sudo service docker restart`

## 2. Add credentials
Copy default credentials by copying file `.env.sample` to `.evn` in root
    
    cp ./.env.sample ./.env

## 3. Run containers
Run init script in root: `./start.sh`

## 4. Add record to /etc/hosts file

- Get nginx container IP address by executing commands:
    - `docker ps | grep nginx`
    - `docker inspect --format '{{ NetworkSettings.IPAddress }}' CONTAINER_ID` where CONTAINER_ID is string found in previous command
- Add container IP to /etc/hosts file:
    e.g.: `app.local 172.17.0.2`

## 5. Add required permissions for folders (Symfony related)

Run commands on host:

    sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX public/var
    sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX public/var

More information about Symfony permissions can be found here: [Setting up or Fixing File Permissions](http://symfony.com/doc/current/setup/file_permissions.html)

## 6. Install dependencies
    cd public && composer install

## 7. Test in browser

http://app.local/app_dev.php

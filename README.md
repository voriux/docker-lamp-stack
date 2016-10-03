# docker-lamp-stack
Docker LAMP stack for PHP development

Prerequisites:

- [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
- [Docker compose](https://docs.docker.com/compose/install/)

## 1. Add your user to docker group
- `sudo gpasswd -a {your_username} docker`
- `sudo service docker restart`

## 2. Add bash functions to .bashrc

These functions allow easier and faster access to `php` and `composer` binaries

    function docker-php() {
        appname=$(basename `pwd -P`)
        appname="${appname/-/}"
        imagename='php:cli'
        output=$(docker images | grep "${appname}_phpserver")
        if [ "$?" = "0" ]; then
            imagename="${appname}_phpserver"
        fi
        docker run -ti --rm -v $(pwd):/app -w /app $imagename php $*
    }

    function docker-composer() {
        appname=$(basename `pwd -P`)
        appname="${appname/-/}"
        imagename='composer/composer'
        output=$(docker images | grep "${appname}_composer")
        if [ "$?" = "0" ]; then
            imagename="${appname}_composer"
        fi
        docker run --rm -v ~/.composer:/root/.composer -v $(pwd):/app -v ~/.ssh:/root/.ssh $imagename $*
    }

## 3. Run containers
Run command in project root: `docker-compose up -d`

## 4. Add record to /etc/hosts file

- Get nginx container IP address by executing commands:
    - `docker ps | grep nginx`
    - `docker inspect --format '{{ .NetworkSettings.IPAddress }}' CONTAINER_ID` where CONTAINER_ID is string found in previous command
- Add container IP to /etc/hosts file:
    e.g.: `app.local 172.17.0.2`

## 5. Add required permissions for folders (Symfony related)

Run commands on host:

    sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX PROJECT_ROOT/public/var
    sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX PROJECT_ROOT/public/var

More information about Symfony permissions can be found here: [Setting up or Fixing File Permissions](http://symfony.com/doc/current/setup/file_permissions.html)

## 5. Install dependencies
    docker-composer install

## 6. Test in browser

http://app.local
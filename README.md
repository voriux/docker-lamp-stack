# docker-lamp-stack
Docker LAMP stack for PHP development

## Installing docker with required permissions
- `sudo gpasswd -a {your_username} docker`
- `sudo service docker restart`

## Add bash functions to .bashrc

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

## Add record to /etc/hosts file


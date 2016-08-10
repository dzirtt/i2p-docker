#!/bin/bash

#docker entrypint script
#for sync uid:gid host<->container

#usage
#add to build script ENV USER, ENV GROUP point to user from who start app in container
#docker run -e "HOSTUID=`id -u USERNAME`" -e "HOSTGID=`id -g GROUP`" where user and group its host user:group

set -e
changeFlag=0

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	
    #change container  UID:GID to HOST UID:GID
    #to save right permissions
    
    test -z $HOSTUID && { echo -e "set HOSTUID ENV var, script not work properly \nEXIT"; exit 1; }
    test -z $HOSTGID && { echo -e "set HOSTGID ENV var, script not work properly \nEXIT"; exit 1; }
    id -u $USER &> /dev/null || { echo -e "user $USER not exist in container, script not work properly \nEXIT"; exit 1; }
    id -g $GROUP &> /dev/null || { echo -e "group $GROUP not exist in container, script not work properly \nEXIT"; exit 1; }
   
    if [ $HOSTUID -ne `id -u $USER` ]; then
        usermod -o -u $HOSTUID $USER
        echo -e "set $USER -uid-> $HOSTUID"
        changeFlag=$((changeFlag+1))
    fi
    
    if [ $HOSTGID -ne `id -g $GROUP` ]; then
        groupmod -o -g $HOSTGID $GROUP
        echo -e "set $GROUP -gid-> $HOSTGID"
        changeFlag=$((changeFlag+1))
    fi

    test $changeFlag -eq 0 && echo -e "nothing to be done \n$USER=`id -u $USER` $GROUP=`id -g $GROUP`"

    exec gosu $USER "$0" "$@"
    exit 0
fi

exec "$0" "$@"
exit 0
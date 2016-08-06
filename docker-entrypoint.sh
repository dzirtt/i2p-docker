#!/bin/bash

#run procces in docker from specific user 
#set permissions to bind folders to current user

set -e
#set this through docker run -e "HOSTUID=${id -u USERNAME}" -e "{HOSTGID=${id -g GROUP}"
#hostUID=$HOSTUID
#hostGID=$HOSTGID

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	
    #change container  UID:GID to HOST UID:GID
    #to save right permissions
    echo -e "set $HOSTUID:$HOSTGID to $USER:$GROUP \n"
    
    test -z $HOSTUID && echo -e "set HOSTUID ENV var, script not work properly"
    test -z $HOSTGID && echo -e "set HOSTGID ENV var, script not work properly"
    
    usermod -u $HOSTUID $USER
    groupmod -g $HOSTGID $GROUP
    
    exec gosu $USER "$0" "$@"
fi

#just run if exec app not $APPNAME
exec "$@"
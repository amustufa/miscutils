#!/bin/bash

if [ "$1" == "" ]; then
    echo "Please enter ip of remote database"
    exit
fi

if [ "$2" == "" ]; then
    echo "Please enter port of remote database"
    exit
fi

remoteHost=$1
remotePort=$2
localDb='bykea-dev'

collections=("settings" "admins" "admin_permissions")

echo "**************Using local database '$localDb'**************"

mongo --eval "db = db.getSiblingDB('$localDb');"

echo "**************Dropping local database '$localDb'**************"

mongo --eval "db.dropDatabase();" $localDb

echo "**************Creating local database '$localDb'**************"

echo "Beginning collection cloning process....."

for i in ${collections[@]}; do
    echo "Cloning collection **************'$i'**************"
    mongo --eval "db.cloneCollection('$remoteHost:$remotePort','$i');" $localDb
done

echo "**************Database cloning process ended successfully**************"

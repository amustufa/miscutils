#!/bin/bash

if [ "$1" == "" ]; then
    echo "Please enter project name"
    exit
fi

if [ "$2" == "" ]; then
    echo "Please enter git repository"
    exit
fi

if [ "$3" == "" ]; then
    echo "Please enter branch name"
    exit
fi

gitUser="<your git username>"
gitPswd="<your git password>"
project=$1
branch=$3
baseDir=$HOME
cloneURL="https://$gitUser:$gitPswd@github.com/$gitUser/$2.git"

if [ ! -d "$baseDir/$project" ]; then
  echo "*********************************Creating directory for project $project*********************************"
  mkdir -p "$baseDir/$project"
fi

echo "*********************************Warping into $baseDir/$project directory*********************************"

cd "$baseDir/$project"

git init

git remote add origin $cloneURL

git fetch

git checkout $branch

git pull

npm install

#!/bin/bash

basedir=`pwd`
repoDir=$basedir/tempoStore
logFile=$basedir/gitWorks.log
githubRepo=$basedir/STORAGE

[[ $# -ne 1 ]] && echo "loadRepos : ERROR : unspecified project!" >>$logFile && exit

echo "$githubRepo/$1/ace.tar" >>$logFile
mkdir -p $repoDir
rm -rf $repoDir/*
cd $repoDir
tar xf $githubRepo/$1.tar &>>$logFile
cd - &>/dev/null




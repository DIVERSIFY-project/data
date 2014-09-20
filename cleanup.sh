#!/bin/bash

basedir=`pwd`
repoDir=$basedir/tempoStore
logFile=$basedir/gitWorks.log

[[ $# -ne 1 ]] && echo "cleanup : ERROR : unspecified project!" >>$logFile && exit

rm -rf $basedir/$1.git
rm -rf $repoDir/*


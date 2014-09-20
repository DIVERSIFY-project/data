#!/bin/bash

export DISPLAY=:0.0

basedir=`pwd`
bin=$basedir/bin # where are the binaries
lib=$basedir/lib/*
resultDir=$basedir/gdata

####### github projects ########
gitPath=$basedir # path for the git to be created/analyzed
repoPath=$basedir/tempoStore # path to the git repos to be imported
pRoot='ajaxorg/ace'
outPath=$basedir # where the output tree is to be written
################################

rm -f $basedir/gitMotifs.log
mkdir -p $resultDir
mkdir -p $repoPath

gitWorks_cmdLine="java -cp GitWorks.jar:lib/*:. gitworks.GitWorks" # "java -Xmx1536M -cp $lib:$bin gitworks.GitWorks"
gitWorks_params="none $repoPath $gitPath $outPath $pRoot"
if [ $# -lt 1 ] ; then
  eval $gitWorks_cmdLine $gitWorks_params
else
  eval $gitWorks_cmdLine $@
fi

rm -rf $repoPath

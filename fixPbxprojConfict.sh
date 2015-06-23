#!/bin/sh
#Author:Bruce http://www.heyuan110.com
#Update Date:2015.06.23

projectfile=`find -d . -name 'project.pbxproj'`
projectdir=`echo *.xcodeproj`
projectfile="${projectdir}/project.pbxproj"
tempfile="${projectdir}/project.pbxproj.out"
savefile="${projectdir}/project.pbxproj.mergesave"

cat $projectfile | grep -v "<<<<<<< HEAD" | grep -v "=======" | grep -v "^>>>>>>> " > $tempfile
cp $projectfile $savefile
mv $tempfile $projectfile
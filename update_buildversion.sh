#!/bin/sh
#Author:Bruce http://www.heyuan110.com
#Update Date:2015.06.23

complieInfoPlist="./PatPat/Info.plist"
version=`git rev-list HEAD | wc -l | awk '{print $1}'`
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" $complieInfoPlist
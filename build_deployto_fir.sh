#! bin/bash
#Author:Bruce http://www.heyuan110.com
#Update Date:2015.06.23
#Use:命令行进入目录直接执行sh Build+DeployToFir.sh即可完成打包发布到fir.im

export LC_ALL=zh_CN.GB2312;
export LANG=zh_CN.GB2312

###############设置需编译的项目配置名称
buildConfig="Release" #编译的方式,有Release,Debug，自定义的AdHoc等

##########################################################################################
##############################以下部分为自动生产部分，不需要手动修改############################
##########################################################################################
projectName=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'` #项目名称
projectDir=`pwd` #项目所在目录的绝对路径
wwwIPADir=~/Desktop/$projectName-IPA #ipa，icon最后所在的目录绝对路径
isWorkSpace=true  #判断是用的workspace还是直接project，workspace设置为true，否则设置为false

echo "~~~~~~~~~~~~~~~~~~~开始编译~~~~~~~~~~~~~~~~~~~"
if [ -d "$wwwIPADir" ]; then
    echo $wwwIPADir
	echo "文件目录存在" 
else 
	echo "文件目录不存在" 
    mkdir -pv $wwwIPADir
	echo "创建${wwwIPADir}目录成功"
fi

###############进入项目目录
cd $projectDir
rm -rf ./build
buildAppToDir=$projectDir/build #编译打包完成后.app文件存放的目录

###############获取版本号,bundleID
infoPlist="$projectName/Info.plist"
bundleVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $infoPlist`
bundleIdentifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $infoPlist`
bundleBuildVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $infoPlist`

###############开始编译app
if $isWorkSpace ; then  #判断编译方式
    echo  "开始编译workspace...." 
    xcodebuild  -workspace $projectName.xcworkspace -scheme $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
else
    echo  "开始编译target...."
    xcodebuild  -target  $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
fi
#判断编译结果
if test $? -eq 0
then
echo "~~~~~~~~~~~~~~~~~~~编译成功~~~~~~~~~~~~~~~~~~~"
else
echo "~~~~~~~~~~~~~~~~~~~编译失败~~~~~~~~~~~~~~~~~~~"
exit 1
fi

###############开始打包成.ipa
ipaName=`echo $projectName | tr "[:upper:]" "[:lower:]"` #将项目名转小写
findFolderName=`find . -name "$buildConfig-*" -type d |xargs basename` #查找目录
appDir=$buildAppToDir/$findFolderName/  #app所在路径
echo "开始打包$projectName.app成$projectName.ipa....."
xcrun -sdk iphoneos PackageApplication -v $appDir/$projectName.app -o $appDir/$ipaName.ipa #将app打包成ipa

###############开始拷贝到目标下载目录
#检查文件是否存在
if [ -f "$appDir/$ipaName.ipa" ]
then
echo "打包$ipaName.ipa成功."
else
echo "打包$ipaName.ipa失败."
exit 1
fi

path=$wwwIPADir/$projectName$(date +%Y%m%d%H%M%S).ipa
cp -f -p $appDir/$ipaName.ipa $path   #拷贝ipa文件
echo "复制$ipaName.ipa到${wwwIPADir}成功"
echo "~~~~~~~~~~~~~~~~~~~结束编译，处理成功~~~~~~~~~~~~~~~~~~~"
#open $wwwIPADir

#####开始上传，如果只需要打ipa包出来不需要上传，可以删除下面的代码
export LANG=en_US
export LC_ALL=en_US;
echo "正在上传到fir.im...."
fir p $path
changelog=`cat $projectDir/README`
curl -X PUT --data "changelog=$changelog" http://fir.im/api/v2/app/54c0a98d627b6443070000cb?token=tokenvalue
echo "\n打包上传更新成功！"
rm -rf $buildAppToDir
rm -rf $projectDir/tmp

##简介

#### build_install.sh

1.xcode命令行编译生成ipa包，打包相关的Log都输出到~/xcodebuild目录

2.生成plist文件和html下载页面

配置好工程路径，url就可一键打包啦 ~_~

#### build_deployto_fir.sh

和XcodeBuild+Install.sh相比，Build+DeployToFir.sh不需要手动配置那么多东西了，修正优化了部分地方。
打包后上传到fir.im，会更新记录,注意更新记录读取自项目根目录下的README里
如果你项目下面没得README这个文件，加上或改84行吧,
还有记得修改`curl -X PUT --data "changelog=$changelog" http://fir.im/api/v2/app/54c0a98d627b6443070000cb?token=tokenvalue`里的tokenvalue，去fir申请一个

#### sendemail目录

发邮件用的python，mac自带就装好了python环境的，在目录sendemail里，已经做了脱敏处理，所以你要使用请按下面的说明修改。

build_send.sh: 调打包和发邮件的脚本，注意修改第7行`path=~/work/projectname/
`路径.我是放在~/xcodebuild/sendemail下的，如果不是，自己注意改脚本里的路径。

myconfig：修改username和passwd，如果你也是qq企业邮箱smtp等就不用改了，否则修改。

toEmailAddress：要发给哪些人，一行一个

update.txt：发邮件的时候邮件里的内容

#### fix_InfoPlist_confict.sh

解决Info.plist冲突,注意Info.plist文件的路径

#### fix_Pbxproj_confict.sh

解决工程文件冲突project.pbxproj

#### update_buildversion.sh

提取git提交号作为build version，并更新

#### delete_deriveddata.sh

清理DerivedData数据

#### delete_archives.sh

清理Archives数据


#### date.sh

此文件是和date相关的函数

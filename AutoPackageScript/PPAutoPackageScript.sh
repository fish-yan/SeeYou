# !/bin/bash
# 使用方法:
# step1 : 将PPAutoPackageScript整个文件夹拖入到项目主目录,项目主目录,项目主目录~~~(重要的事情说3遍!😊😊😊)
# step2 : 打开PPAutoPackageScript.sh文件,修改 "项目自定义部分" 配置好项目参数
# step3 : 打开终端, cd到PPAutoPackageScript文件夹 (ps:在终端中先输入cd ,直接拖入PPAutoPackageScript文件夹,回车)
# step4 : 输入 sh PPAutoPackageScript.sh 命令,回车,开始执行此打包脚本

# ===============================项目自定义部分(自定义好下列参数后再执行该脚本)============================= #
# 计时
SECONDS=0
# 是否编译工作空间 (例:若是用Cocopods管理的.xcworkspace项目,赋值true;用Xcode默认创建的.xcodeproj,赋值false)
is_workspace="true"
# 指定项目的scheme名称
# (注意: 因为shell定义变量时,=号两边不能留空格,若scheme_name与info_plist_name有空格,脚本运行会失败,暂时还没有解决方法,知道的还请指教!)
scheme_name="SeeYou"
# 工程中Target对应的配置plist文件名称, Xcode默认的配置文件为Info.plist
info_plist_name="Info"
# 指定要打包编译的方式 : Release,Debug...
build_configuration="Release"


# ===============================Git============================= #
# # 分支
# branch_name="development"

# git checkout $branch_name
# if [ $? -ne 0 ]; then
#     exit 1
# fi

# # git pull 
# #pod update --verbose --no-repo-update
# if [ $? -ne 0 ]; then
#      exit 1
# fi



# ===============================自动打包路径名称等配置============================= #

# 导出ipa所需要的plist文件路径 (默认为AdHocExportOptionsPlist.plist)
ExportOptionsPlistPath="./AutoPackageScript/AdHocExportOptionsPlist.plist"
# 返回上一级目录,进入项目工程目录
cd ..
# 获取项目名称
project_name=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`
# 获取版本号,内部版本号,bundleID
info_plist_path="$project_name/$info_plist_name.plist"
bundle_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $info_plist_path`
bundle_build_version=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $info_plist_path`
bundle_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $info_plist_path`


# 指定输出ipa路径
now_date=`date '+%Y%m%d%H%M'`
export_path=~/Desktop/$scheme_name/$now_date
# 指定输出ipa名称 : scheme_name
ipa_name="$scheme_name"


# 删除旧.xcarchive文件
#rm -rf $export_path/$scheme_name.xcarchive

# 指定输出归档文件地址
export_archive_path="$export_path/$scheme_name.xcarchive"

# AdHoc,AppStore,Enterprise三种打包方式的区别: http://blog.csdn.net/lwjok2007/article/details/46379945
echo "\033[36;1m请选择打包方式(输入序号,按回车即可) \033[0m"
echo "\033[33;1m1. AdHoc       \033[0m"
echo "\033[33;1m2. AppStore    \033[0m"
echo "\033[33;1m3. Enterprise  \033[0m"

# 读取用户输入并存到变量里
read parameter
sleep 0.5
method="$parameter"

# 判读用户是否有输入
if [ -n "$method" ]
then
    if [ "$method" = "1" ] ; then
    ExportOptionsPlistPath="./AutoPackageScript/AdHocExportOptionsPlist.plist"
    elif [ "$method" = "2" ] ; then
    ExportOptionsPlistPath="./AutoPackageScript/AppStoreExportOptionsPlist.plist"
    elif [ "$method" = "3" ] ; then
    ExportOptionsPlistPath="./AutoPackageScript/EnterpriseExportOptionsPlist.plist"
    elif [ "$method" = "4" ] ; then
    ExportOptionsPlistPath="./AutoPackageScript/DevelopmentExportOptionsPlist.plist"
    else
    echo "输入的参数无效!!!"
    exit 1
    fi
fi

echo "\033[32m*************************  开始构建项目  *************************  \033[0m"
# 指定输出文件目录不存在则创建
if [ -d "$export_path" ] ; then
echo $export_path
else
mkdir -pv $export_path
fi


# 判断编译的项目类型是workspace还是project
if $is_workspace ; then
# 编译前清理工程
xcodebuild clean -workspace ${project_name}.xcworkspace \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}

xcodebuild archive -workspace ${project_name}.xcworkspace \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
else
# 编译前清理工程
xcodebuild clean -project ${project_name}.xcodeproj \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}

xcodebuild archive -project ${project_name}.xcodeproj \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
fi

#  检查是否构建成功
#  xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if [ -d "$export_archive_path" ] ; then
echo "\033[32;1m项目构建成功 🚀 🚀 🚀  \033[0m"
else
echo "\033[31;1m项目构建失败 😢 😢 😢  \033[0m"
exit 1
fi

echo "\033[32m*************************  开始导出ipa文件  *************************  \033[0m"
xcodebuild  -exportArchive \
            -archivePath ${export_archive_path} \
            -exportPath ${export_path} \
            -exportOptionsPlist ${ExportOptionsPlistPath}
# 修改ipa文件名称
mv $export_path/$scheme_name.ipa $export_path/$ipa_name.ipa

# 检查文件是否存在
if [ -f "$export_path/$ipa_name.ipa" ] ; then
echo "\033[32;1m导出 ${ipa_name}.ipa 包成功 🎉  🎉  🎉   \033[0m"
echo "\033[32;1m路径为:${export_path}  \033[0m"


# echo "\033[32m*************************  开始上传到fir中  *************************  \033[0m"

# # 设置fir Api Token
# fir_token=""
# if [ "$method" = "1" ] ; then
# fir_token="ca1a0b142035ad7fb12f63914c5470e7"
# elif [ "$method" == "2"] ; then
# fir_token="ca1a0b142035ad7fb12f63914c5470e7"
# elif [ "$method" == "3"] ; then
# fir_token="ca1a0b142035ad7fb12f63914c5470e7"
# else
# fir_token=""
# fi

up_load_path="$export_path/$scheme_name.ipa"
# log_path="$export_path"

# fir publish "$up_load_path" -T "$fir_token"
# # fir publish "$up_load_path" -T "$fir_token" >> $log_path
# # open $export_path
echo "\033[32m*************************  开始上传到蒲公英  *************************  \033[0m"
#蒲公英aipKey
api_key="62a44340f7bdd5c7f818cfd8f925154c"
#蒲公英uKey
user_key="223a488f3aaa4a50d007b0fdbe15b477"

curl -F "file=@$up_load_path" -F '_api_key=62a44340f7bdd5c7f818cfd8f925154c' https://www.pgyer.com/apiv2/app/upload


# curl -F "file=@$up_load_path" \
# -F "uKey={$user_key}" \
# -F "_api_key={$api_key}" \
# https://qiniu-storage.pgyer.com/apiv1/app/upload

else
echo "\033[31;1m导出 ${ipa_name}.ipa 包失败 😢 😢 😢     \033[0m"
exit 1
fi
# 输出打包总用时
echo "\033[36;1m打包结束, 总用时: ${SECONDS}s \033[0m"



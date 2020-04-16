# SDK集成 {#concept_drc_txx_pfb .concept}

本文介绍Android推流SDK的快速上手集成。

## 集成环境 {#section_slj_dxk_nfb .section}

 **硬性要求** 

|名称|要求|
|:-|:-|
|Android系统版本|\>= Android 4.3|
|最小Android API版本|Jelly Bean \(API 18\)|
|CPU架构支持|ARM64、ARMV7|
|集成工具|Android Studio|

**非硬性要求**

仅仅是开发此Demo时的开发环境, 目的是为了给编译运行源码的人员提供参考

|名称|要求|
|:-|:-|
|Android Studio版本|3.2.1|
|JRE:|1.8.0\_152-release-1136-b06 amd64|
|JVM:|OpenJDK 64-Bit|
|compileSdkVersion|26|
|buildToolsVersion|26.0.2|
|minSdkVersion|18|
|targetSdkVersion|26|
|gradle version|gradle-4.4-all|
|gradle plugin version|com.android.tools.build:gradle:3.0.1|

## 推流SDK下载 {#section_c4f_cyx_pfb .section}

阿里云官网Android版 [推流SDK下载](../../../../cn.zh-CN/SDK下载/SDK下载.md#section_sxd_wpk_nfb)，推流SDK包含在解压包的AlivcLivePusher文件夹中，如下图所示：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611739285_zh-CN.png)

上图中的文件内容作用如下：

|文件目录|文件名称|文件说明|
|:---|:---|:---|
|demo|AlivcLivePusherDemo|推流SDK演示Demo源代码工程|
|doc|api.zip|推流SDK API JavaDoc|
|sdk|AlivcLivePusherSDK|不带阿里云播放器的推流SDK|
|AlivcLivePusherSDK+AliyunPlayerSDK|带阿里云播放器的推流SDK|

上表中的sdk文件夹中的文件作用如下：

|文件目录|文件说明|
|:---|:---|
|aarlibs|推流SDK所包含的各个组件aar包|
|jnilibs|推流SDK所包含的所有动态库包，分为arm64-v8a、armeabi-v7a。|
|libs|推流SDK所包含的各个组件jar包|
|obj|推流SDK所包含的动态库，用于定位底层问题。|

**说明：** 

-   可根据SDK包中的文件选择集成方式，采用aar集成或采用jar包+so集成。
-   使用背景音乐功能时必须集成播放器sdk\(AlivcPlayer.aar\)。

## 运行推流Demo {#section_uld_dyx_pfb .section}

将AlivcLivePusherDemo工程导入到Android Studio中，如下图所示：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611739289_zh-CN.png)

导入工程成功后，即可直接运行工程查看Demo效果。效果如下：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611739290_zh-CN.png)

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611839291_zh-CN.png)

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611839292_zh-CN.png)

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611839293_zh-CN.png)

推流url中填入有效的推流rtmp地址，推流成功后，拉流观看的效果可以使用阿里云播放器SDK、ffplay、VLC等工具查看。

## 推流SDK集成 {#section_nhh_4cd_wgb .section}

1.  使用aar的集成方式

    将所有SDK目录下文件拷贝到自己工程对应lib目录下，并修改主模块\(一般是app \) 的build.gradle中的 dependencies，然后同步工程，代码如下：

    ```
    implementation fileTree(dir: 'libs', include: ['*.jar', '*.aar'])
    ```

2.  使用jar+so的集成方式

    将SDK包下的jnilibs中的包拷贝到工程目录libs目录下，再将SDK包下的libs中的包拷贝到工程目录下jnilibs目录下，并在build.gradle中添加上相关的依赖，类似aar集成方式，具体如下图所示：

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40381/156592611939305_zh-CN.png)

3.  添加请求权限

    在AndroidManifest文件下添加如下代码：

    ```
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.MOUNT_UNMOUNT_FILESYSTEMS"/>
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.BLUETOOTH" />
    ```

    **说明：** 请您记得添加录音权限和相机权限。

4.  添加混淆规则

    在proguard-rules.pro文件下添加如下代码：

    ```
    -keep class com.alibaba.livecloud.** { *;}
    -keep class com.alivc.** { *;}
    ```

5.  具体使用说明

    具体SDK的API使用请参考推流Android SDK的使用说明文档，API的详细注释说明请参考SDK包里的API JavaDoc文档。



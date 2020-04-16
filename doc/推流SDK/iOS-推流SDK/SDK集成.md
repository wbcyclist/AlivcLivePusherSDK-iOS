# SDK集成 {#concept_cbx_ysw_pfb .concept}

本文介绍iOS推流SDK的快速上手集成。

## 集成环境 {#section_slj_dxk_nfb .section}

 **硬性要求** 

|名称|要求|
|:-|:-|
|iOS系统版本|\>= 8.0|
|机器型号|iPhone 5S及以上|
|CPU架构支持|ARMv7、ARMv7s、ARM64|
|集成工具|Xcode 8.0及以上版本|
|bitcode|关闭|

## 推流SDK下载 {#section_c4f_cyx_pfb .section}

阿里云官网iOS版 [推流SDK下载](../../../../../cn.zh-CN/SDK下载/SDK下载.md#section_sxd_wpk_nfb)，推流SDK包含在解压包的AlivcLivePusher文件夹中，如下图所示：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121028_zh-CN.png)

上图中的文件内容作用如下：

|文件目录|文件名称|文件说明|
|:---|:---|:---|
|demo|AlivcLivePusherDemo|推流SDK演示Demo源代码工程|
|doc|html|推流SDK API 说明|
|lib|AlivcLivePusherSDK/arm|不带阿里云播放器的推流SDK，纯arm版本。|
|AlivcLivePusherSDK/arm&simulator|不带阿里云播放器的推流SDK，arm+模拟器版本。|
|AlivcLivePusherSDK+AliyunPlayerSDK/arm|带阿里云播放器的推流SDK，纯arm版本。|
|AlivcLivePusherSDK+AliyunPlayerSDK/arm&simulator|带阿里云播放器的推流SDK，arm+模拟器版本。|

上表中的sdk文件夹中的文件作用如下：

|库文件|文件说明|
|:--|:---|
|AlivcLivePusher.framework|推流SDK|
|AlivcLibRtmp.framework|RTMPSDK|
|AlivcLibBeauty.framework|美颜库|
|AlivcLibFace.framework|人脸检测库|
|AlivcLibFaceResource.bundle|人脸检测资源文件|
|AliyunPlayerSDK.framework|播放器库|
|AliThirdparty.framework|播放器依赖的第三方库|
|AliyunLanguageSource.bundle|播放器依赖的资源文件|

**说明：** 

-   推流SDK中包含背景音乐相关功能。如果您需要使用该功能，要使用依赖播放器SDK的版本；如果您不需要背景音乐功能，则使用不依赖播放器SDK的版本即可。
-   AlivcLibFaceResource.bundle是人脸识别资源文件，如果您需要使用美颜的人脸识别高级功能，则必须导入开发工程；反之则不需要。
-   每个版本均包含 arm 和 arm&simulator 两套SDK，arm仅支持真机调试。arm&simulator支持真机+模拟器调试。项目在release上线的时候必须使用arm版本。

## 运行推流Demo {#section_uld_dyx_pfb .section}

xcode打开AlivcLivePusherDemo工程，如下图所示：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121029_zh-CN.png)

即可直接运行工程查看Demo效果。效果如下：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121030_zh-CN.png)

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121031_zh-CN.png)

推流url中填入有效的推流rtmp地址，推流成功后，拉流观看的效果可以使用阿里云播放器SDK、ffplay、VLC等工具查看。

## 推流SDK集成 {#section_nhh_4cd_wgb .section}

1.  使用Cocoapods集成
    1.  修改Podfile
        1.  依赖播放器版本 添加如下语句至您的 Podfile文件中。

            ```
            pod 'AlivcLivePusherWithPlayer'
            ```

        2.  不依赖播放器版本 添加如下语句至您的 Podfile 文件中。

            ```
            pod 'AlivcLivePusher'
            ```

    2.  执行 pod install

        ```
        pod install :每次您编辑您的Podfile（添加、移除、更新）的时使用
        ```

2.  手动导入集成
    1.  新建SDK测试工程 Single View App \> DemoPush 。
    2.  导入SDK
        -   分别将以下文件拖入您的Xcode工程中：

            -   AlivcLibRtmp.framework
            -   AlivcLivePusher.framework
            -   AlivcLibBeauty.framework
            -   AlivcLibFace.framework
            -   AlivcLibFaceResource.bundle
            -   AliyunPlayerSDK.framework
            -   AliThirdparty.framework
            -   AliyunLanguageSource.bundle
            ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121032_zh-CN.png)

        -   如果您不需要依赖播放器SDK的版本，则只需要将以下文件：

            -   AlivcLibRtmp.framework
            -   AlivcLivePusher.framework
            -   AlivcLibBeauty.framework
            -   AlivcLibFace.framework
            -   AlivcLibFaceResource.bundle
            ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121033_zh-CN.png)

        -   按图示勾选 Copy items if needed：

            ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684121034_zh-CN.png)

        -   导入SDK成功之后，在 Xcode \> General \> Embedded Binaries中添加SDK依赖：

            ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684221035_zh-CN.png)

        -   添加依赖成功后如图所示：

            ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684221037_zh-CN.png)

3.  添加请求权限

    在 Info.plist 文件中添加麦克风和摄像头权限`Privacy - Microphone Usage Description`、`Privacy - Camera Usage Description`。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684221038_zh-CN.png)

    如果需要App在后台继续推流，需要打开后台音频采集模式。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684221040_zh-CN.png)

    **说明：** 请您记得添加录音权限和相机权限。

4.  关闭bitcode

    由于SDK不支持bitcode，所以需要在工程中关闭bitcode选项。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40318/155106684221041_zh-CN.png)

5.  具体使用说明

    具体SDK的API使用请参考推流iOS SDK的使用说明文档，API的详细注释说明请参考SDK包里的API 文档。



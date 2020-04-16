# SDK 发布历史 {#concept_mk2_ft1_pfb .concept}

本文介绍SDK的发布历史。

## 推流SDK {#section_wdb_jt1_pfb .section}

iOS推流SDK

|日期|版本|修改内容|SDK下载|
|:-|:-|:---|:----|
|2018-05-08|V3.3.5|更新播放器SDK3.4.4。|[iOS-V3.3.5](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.5_iOS_20180508.zip)|
|2018-04-25|V3.3.4| -   添加预览显示三种模式。
-   添加推流状态获取接口。
-   支持自定义输入CMSampleBufferRef视频数据。
-   修复iOS推流采集音量偏弱问题。
-   修复推流转录m3u8偶现黑屏问题。
-   修复高级美颜模式下，分辨率为360p时出现推流画面变形的问题。
-   优化水印显示清晰度。
-   修复横屏模式下键盘竖屏显示问题。

 |[iOS-V3.3.4](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.4_iOS_20180425.zip)|
|2018-04-04|V3.3.3| -   添加自定义推流音视频格式。
-   更新日志埋点组件。
-   修复了应用在切换到后台运行，停止推流时出现崩溃的问题。
-   修复SDK背景图片路径写死问题。
-   修复SDK底层日志无法打开问题。

 |[iOS-V3.3.3](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.3_iOS_20180404.zip)|
|2018-03-13|V3.3.2| -   支持replayKit录屏直播。
-   修复埋点日志问题。

 |[iOS-V3.3.2](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.2_iOS_20180313.zip)|
|2018-02-27|V3.3.1| -   修复IPv6推流问题。
-   修复因plist文件引起的无法上传到AppStore的问题。

 |[iOS-V3.3.1](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.1_iOS_20180227.zip)|
|2018-02-10|V3.3.0| -   新增动态水印。
-   新增对highProfile适配。
-   支持输入外部音视频流推流。
-   支持音频硬编。
-   支持后台推图片。
-   新增鉴权过期回调。
-   支持动态分辨率。
-   剥离对美颜库的依赖，统一外部美颜库输入。

 |[iOS-V3.3.0](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.0_iOS_20180210.zip)|
|2018-01-25|V3.2.1|增加在直播流里面插入SEI信息，实现直播答题功能。|[iOS-V3.2.1](http://paas-static.oss-cn-hangzhou.aliyuncs.com/ali-liveSDK/AlivcLivePusher_v3.2.1_iOS_20180125.zip)|
|2018-1-12|V3.2.0| -   优化码控，增加三种码控模式选择。
-   优化美颜，增加高级美颜功能（含瘦脸、大眼、小脸、腮红等）。
-   新增DebugView方便用户调试。
-   剥离SDK对播放器的强依赖，不使用背景音乐可不集成播放器。
-   新增对x86架构支持。

 |[iOS-V3.2.0](http://paas-static.oss-cn-hangzhou.aliyuncs.com/ali-liveSDK/AlivcLivePusher_v3.2.0_iOS_20180112.zip)|
|2017-12-19|V3.1.0| -   优化弱网码率控制策略。
-   新增背景音乐混音功能。
-   新增耳返功能。
-   新增降噪功能。

 |[iOS-V3.1.0](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1513698847532/AlivcLivePusher_v3.1.0_iOS_20171219.zip)|
|2017-12-08|V3.0.3| -   优化码率控制策略。
-   添加日志控制。
-   优化重连。

 |[iOS-V3.0.3](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1512746478218/AlivcLivePusher_v3.0.3_iOS_20171208.zip)|
|2017-11-22|V3.0.1| -   优化onReconnectStart&onReconnectSuccess回调。
-   修复断网时快速频繁上报的问题。

 |[iOS-V3.0.1](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1511352980103/AlivcLivePusher_v3.0.1_iOS_20171122.zip)|
|2017-11-20|V3.0.0| -   统一Android和iOS接口。
-   支持多水印。
-   纯音频推流。
-   支持推流镜像。
-   支持推流软编。
-   美颜优化，支持更多美颜参数调整。
-   支持蓝牙耳机。
-   性能优化。

 |[iOS-V3.0](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1511183494833/AlivcLivePusher_v3.0.0_iOS_20171120.zip)|
|2017-06-06|V1.3.0|iOS 1.3.0 更新内容：**bug 修复：**

修复初始推流失败后主线程卡死 bug。

**拓展功能：**

-   添加美颜度调节接口。

AlivcLiveSession 添加美颜度调节接口： \(void\)alivcLiveVideoChangeSkinValue:\(CGFloat\)value。

调节范围：0~1，初始默认：1。

-   添加相机曝光度调节接口。

AlivcLiveSession添加美颜度调节接口：\(void\)alivcLiveVideoChangeExposureValue:\(CGFloat\)value。

调节范围：-10~10，初始默认：0。

-   重连超时回调接口添加NSError：\(void\)alivcLiveVideoReconnectTimeout:\(AlivcLiveSession \)session error:\(NSError \)error。

|[iOS-1.3](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50101/cn_zh/1496746944080/ALivcLiveVideo_v1.3.0_iOS%282017-06-06%29.zip)|
|2017-03-29|V1.2| -   添加静音功能。
-   添加水印功能。
-   添加自动重连机制。

 |[iOS-1.2](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50101/cn_zh/1493186602928/AliyunPullSDK-iOS.zip)|

Android推流SDK

|日期|版本|修改内容|SDK下载|
|:-|:-|:---|:----|
|2018-05-08|V3.3.5|更新播放器3.4.3。|[Android-V3.3.5](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.5_Android_20180508.zip)|
|2018-04-25|V3.3.4| -   添加预览显示三种模式。
-   添加推流状态获取接口。
-   修复android部分机型连续对焦bug。

 |[Android-V3.3.4](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.4_Android_20180425.zip)|
|2018-04-04|V3.3.3| -   修复SDK背景图片写死问题。
-   添加麦克风权限禁止后失败通知。
-   移除无效日志。
-   修复断网恢复重连失败问题。

 |[Android-V3.3.3](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.3_Android_20180404.zip)|
|2018-03-13|V3.3.2| -   支持录屏直播。
-   修复埋点日志问题。

 |[Android-V3.3.2](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.2_Android_20180313.zip)|
|2018-02-10|V3.3.0| -   新增动态水印。
-   新增对highProfile适配。
-   支持输入外部音视频流推流。
-   支持音频硬编。
-   支持后台推图片。
-   新增鉴权过期回调。
-   支持动态分辨率。
-   剥离对美颜的依赖，统一外部美颜输入。

 |[Android-V3.3.0](http://vod-download.cn-shanghai.aliyuncs.com/sdk/pusher/AlivcLivePusher_v3.3.0_Android_20180210.zip)|
|2018-01-25|V3.2.1|增加在直播流里面插入SEI信息，实现直播答题功能。|[Android-V3.2.1](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1516886485562/AlivcLivePusher_v3.2.1_Android_20180125.zip)|
|2018-01-12|V3.2.0| -   优化码控，增加三种码控模式选择。
-   优化美颜，增加高级美颜功能（含瘦脸、大眼、小脸、腮红等）。
-   新增DebugView方便用户调试。
-   剥离SDK对播放器的强依赖，不使用背景音乐可不集成播放器。
-   兼容硬编profile。
-   支持半透明水印。

 |[Android-V3.2.0](http://paas-static.oss-cn-hangzhou.aliyuncs.com/ali-liveSDK/AlivcLivePusher_v3.2.0_Android_20180116.zip)|
|2017-12-19|V3.1.0| -   优化弱网码率控制策略。
-   新增背景音乐混音功能。
-   新增耳返功能。
-   新增降噪功能。

 |[Android-V3.1.0](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1513699074785/AlivcLivePusher_v3.1.0_Android_20171219.zip)|
|2017-12-08|V3.0.3| -   优化码率控制策略。
-   添加日志控制。
-   优化重连。

 |[Android-V3.0.3](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1512739482313/AlivcLivePusher_v3.0.3_Android_20171208.zip)|
|2017-11-28|V3.0.2|修复推流v1.3总返回一个错误提示的问题。|[Android-V3.0.2](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1511835489210/AlivcLivePusher_v3.0.2_Android.zip)|
|2017-11-22|V3.0.1| -   优化onReconnectStart&onReconnectSucceed回调。
-   修复断网时快速频繁上报onReconnectFail回调。
-   修改startPushAsync时返回错误，状态问题。
-   切后台音频继续采集并推送，如需控制可调用静音接口。

 |[Android-V3.0.1](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1511353395933/AlivcLivePusher_v3.0.1_Android_20171122.zip)|
|2017-11-20|V3.0.0| -   统一Android和iOS接口。
-   支持多水印。
-   纯音频推流。
-   支持推流镜像。
-   支持推流软编。
-   美颜优化，支持更多美颜参数调整。
-   支持蓝牙耳机。
-   性能优化。

 |[Android-V3.0.0](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45270/cn_zh/1511183423120/AlivcLivePusher_v3.0.0_Android_20171120.zip)|
|2017-06-06|V1.3.0|Android 1.3.0更新内容：**bug修复**

**拓展功能**

-   增加了美颜级别可动态调整的功能。
-   增加了自定义输出分辨率的功能。
-   增加了前置摄像头镜像开关。
-   修复了部分机型无法后台推流的Bug。

|[Android-V1.3](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50101/cn_zh/1496747045609/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%B4%E6%92%AD%E6%8E%A8%E6%B5%81SDK_Android_v1.3.0.zip)|
|2016-11-09|V1.2|**bug修复**

修复编码输出帧率无法按照设置的参数输出。**接口调整**

-   AlivcMediaRecorder\#setZoom\(float scaleFactor, CaptureRequest.OnCaptureRequestResultListener listner\) 替换成　AlivcMediaRecorder\#setZoom\(float scaleFactor\)。
-   OnNetworkStatusListener\#onNetworkReconnect\(\)去掉，增加onNetworkReconnectFailed\(\)回调接口。

**扩展功能**

-   增加静音推流的支持。
-   增加SDK自动重连机制，这里也涉及到重连回调的调整。
-   增加水印功能。
-   AlivcMediaRecorder增加获取版本号的接口。

**接入方式调整**

-   SDK接入由原先的AAR导入变成jar包和.so导入。
-   点赞组件由原先的AAR包依赖变成了直接提供了工程module依赖，即demo工程中的bubblinganimationview这个module。

|[Android- V1.2](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50101/cn_zh/1496747143385/AlivcLiveRecord-v1.2.0-android.zip)|

## 播放器SDK {#section_brt_pz1_pfb .section}

[播放器SDK发布历史](https://www.alibabacloud.com/help/zh/doc-detail/94328.htm?spm=a2c63.l28256.b99.171.4afb7ad7Yb2X8S)

**说明：** 直播播放器已和点播放器合并，老用户升级可以直接使用基础播放器。


# SDK使用 {#concept_wx4_lvw_pfb .concept}

本文详细说明如何使用iOS推流SDK API以及相关功能。本文介绍SDK的基本使用流程。

## 推流SDK功能列表 {#section_fpb_zyx_pfb .section}

-   支持RTMP推流协议
-   使用视频H.264编码以及音频AAC编码
-   支持码控、分辨率、显示模式等自定义配置
-   支持多种摄像头相关操作
-   支持实时美颜和自定义美颜效果调节
-   支持增删动态贴纸实现动态水印效果
-   支持录屏直播
-   支持自定义YUV、PCM等外部音视频输入
-   支持多路混流功能
-   支持纯音视频推流以及后台推流
-   支持背景音乐及其相关操作
-   支持直播答题功能
-   支持视频截图功能
-   支持自动重连、异常处理

## 直播主要接口类列表 {#section_hp1_2b3_wgb .section}

|类|说明|
|:-|:-|
|AlivcLivePushConfig|推流初始设置|
|AlivcLivePusher|推流功能类|
|AlivcLivePusherErrorDelegate|错误回调|
|AlivcLivePusherNetworkDelegate|网络相关通知回调|
|AlivcLivePusherInfoDelegate|推流相关信息回调|
|AlivcLivePusherBGMDelegate|背景音乐回调|
|AlivcLivePusherCustomFilterDelegate|自定义滤镜回调|
|AlivcLivePusherCustomDetectorDelegate|自定义人脸检测回调|
|AlivcLivePusherSnapshotDelegate|截图回调|

## 引入头文件 {#section_kgd_kjk_wgb .section}

在代码中引入以下头文件便可使用直播推流的所有API和类对象。

```
#import <AlivcLivePusher/AlivcLivePusherHeader.h>
```

## 初始化 {#section_qsb_zyx_pfb .section}

SDK 初始化主要包括以下几个步骤：

1.  创建AlivcLivePushConfig对象，并设置相关参数。

    AlivcLivePushConfig类用于推流的初始化设置，设置参数有：

    |参数|说明|默认|
    |:-|:-|:-|
    |resolution|推流分辨率|540P|
    |qualityMode|推流码率控制模式|分辨率优先模式|
    |enableAutoBitrate|是否开启码率自适应模式|开启|
    |enableAutoResolution|是否开启动态分辨率模式|关闭|
    |fps|视频帧率|20fps|
    |minFps|最小视频帧率|8fps|
    |targetVideoBitrate|目标视频编码码率|800kbps|
    |minVideoBitrate|最小视频编码码率|200kbps|
    |initialVideoBitrate|初始视频编码码率|800kbps|
    |audioBitrate|音频编码码率|64kbps|
    |audioSampleRate|音频采样率|32000hz|
    |audioChannel|音频声道数|双声道|
    |videoEncodeGop|视频GOP大小|2秒|
    |connectRetryCount|推流断开自动重连次数|5次|
    |connectRetryInterval|推流断开自动重连间隔|1000毫秒|
    |sendDataTimeout|发送网络数据超时时间|3000毫秒|
    |orientation|横竖屏设定|竖屏|
    |cameraType|相机位置|前置|
    |pushMirror|是否推流镜像|关闭|
    |previewMirror|是否预览镜像|关闭|
    |audioOnly|是否纯音频推流|关闭|
    |videoOnly|是否纯视频推流|关闭|
    |autoFocus|相机是否自动对焦|打开|
    |beautyOn|是否打开美颜|打开|
    |pauseImg|暂停退后台图片|空|
    |networkPoorImg|弱网图片|空|
    |beautyMode|美颜模式|普通美颜|
    |beautyWhite|美白参数|70|
    |beautyBuffing|磨皮参数|40|
    |beautyRuddy|红润参数|40|
    |beautyCheekPink|腮红参数|15|
    |beautyThinFace|瘦脸参数|40|
    |beautyShortenFace|收下巴参数|50|
    |beautyBigEye|大眼参数|30|
    |flash|是否打开手电筒|关闭|
    |videoEncoderMode|视频编码器|硬编码|
    |audioEncoderProfile|音频编码格式|AAC LC|
    |audioEncoderMode|音频编码器|软编码|
    |externMainStream|自定义外部主流开关|关闭|
    |externVideoFormat|自定义外部视频数据格式|unknown|
    |externAudioFormat|自定义外部音频数据格式|unknown|
    |previewDisplayMode|预览窗口显示模式|ASPECT FIT模式|
    |addWatermarkWithPath|添加水印接口| |
    |removeWatermarkWithPath|移除水印接口| |
    |getAllWatermarks|获取所有水印信息| |
    |getPushResolution|获取推流分辨率| |

    1.  创建AlivcLivePushConfig对象

        ```
        self.pushConfig = [[AlivcLivePushConfig alloc]init];
        ```

    2.  分辨率设置

        ```
        self.pushConfig.resolution = AlivcLivePushResolution540P;
        ```

        SDK支持的主播推流分辨率如下：

        |分辨率定义|分辨率|
        |:----|:--|
        |AlivcLivePushResolution180P|192x320|
        |AlivcLivePushResolution240P|240x320|
        |AlivcLivePushResolution360P|368x640|
        |AlivcLivePushResolution480P|480x640|
        |AlivcLivePushResolution540P|544x960|
        |AlivcLivePushResolution720P|720x1280|
        |AlivcLivePushResolutionPassThrough|屏幕分辨率|

        **说明：** AlivcLivePushResolutionPassThrough只有在录屏直播模式下才有效，使用的是屏幕原始分辨率。

    3.  码率控制设置

        推流的码率控制有三种qualityMode模式可选：清晰度优先模式、流畅度优先模式和自定义模式。

        -   清晰度优先模式（AlivcQualityModeEnum.QM\_RESOLUTION\_FIRST）：SDK内部会对码率参数进行配置，优先保障推流视频的清晰度。
        -   流畅度优先模式（AlivcQualityModeEnum.QM\_FLUENCY\_FIRST）：SDK内部会对码率参数进行配置，优先保障推流视频的流畅度。
        -   自定义模式（AlivcQualityModeEnum.QM\_CUSTOM）：SDK会根据开发者设置的码率进行配置。
        其中，清晰度优先模式和流畅度优先模式是根据日常使用场景由SDK定义的一套比较适合该场景的推荐使用模式，这两种模式下帧率和编码码率都是由定义好的，不可以外部调节，所以使用的时候需要特别注意。由于不同模式下您可以设置的参数有限制，以下是具体的组合说明：

        |qualityMode 码率控制模式|fps 帧率|minVideoBitrate 视频最小码率|initialVideoBitrate 视频初始码率|targetVideoBitrate 视频目标码率|
        |:-----------------|:-----|:---------------------|:-------------------------|:------------------------|
        |清晰度优先模式（默认）|不可设置|不可设置|不可设置|不可设置|
        |流畅度优先模式|不可设置|不可设置|不可设置|不可设置|
        |自定义模式|可设置|可设置|可设置|可设置|

        从上表中可以看出只有自定义模式下才能设置视频的fps、目标码率、最小码率以及初始码率，而在清晰度模式和流畅度模式下这些值的设置并不生效，而是SDK内部自定义一套和不同分辨率对应的值，详细如下表。

        **清晰度优先模式各视频参数对应值：**

        |分辨率|fps|minVideoBitrate 视频最小码率kbps|initialVideoBitrate 视频初始码率kbps|targetVideoBitrate 视频目标码率kbps|
        |:--|:--|:-------------------------|:-----------------------------|:----------------------------|
        |AlivcLivePushResolution180P|20|120|300|550|
        |AlivcLivePushResolution240P|20|180|450|750|
        |AlivcLivePushResolution360P|20|300|600|1000|
        |AlivcLivePushResolution480P|20|300|800|1200|
        |AlivcLivePushResolution540P|20|600|1000|1400|
        |AlivcLivePushResolution720P|20|600|1500|2000|

        **流畅度优先模式各视频参数对应值：**

        |分辨率|fps|minVideoBitrate 视频最小码率kbps|initialVideoBitrate 视频初始码率kbps|targetVideoBitrate 视频目标码率kbps|
        |:--|:--|:-------------------------|:-----------------------------|:----------------------------|
        |AlivcLivePushResolution180P|25|80|200|250|
        |AlivcLivePushResolution240P|25|120|300|350|
        |AlivcLivePushResolution360P|25|200|400|600|
        |AlivcLivePushResolution480P|25|300|600|800|
        |AlivcLivePushResolution540P|25|300|800|1000|
        |AlivcLivePushResolution720P|25|300|1000|1200|

        **说明：** 如果觉得清晰度优先模式和流畅度优先模式下的视频参数设置不满足推流场景要求，必须使用自定义模式来设置自定义的参数值。

        **码率自适应**

        码率自适应是推流码率控制中的一种策略，其定义表示推流过程中是否根据当前实际网络代码动态调整视频的编码码率，调整范围就是由最小码率、初始码率和，目标码率来限定的。

        码率自适应打开时，推流过程中首先使用初始码率作为编码码率，当检测到当前上传带宽充足时，会慢慢上调编码码率，直至到目标码率就不再向上调整，而当检测到当前上传带宽不足时，开始下调视频编码码率，下调的最小值为最小码率，此时不再继续下调。

        当码率自适应关闭时，整个推流过程中始终使用初始编码码率，不会动态去调整编码码率。

        **动态分辨率**

        动态分辨率是在推流过程中，根据码率调整到一定的范围后，可以动态切换相应的分辨率，也就是说此设置是依赖码率自适应的开关的，如果码率自适应关闭，此设置无效，且动态分辨率目前只支持清晰度优先模式和流畅度优先模式，不支持自定义模式。当动态分辨率开关生效后，对应的分辨率切换范围为：

        |分辨率|最小码率kbps|最大码率kbps率|
        |:--|:-------|:--------|
        |AlivcLivePushResolution480P|无|1000|
        |AlivcLivePushResolution540P|1000|1200|
        |AlivcLivePushResolution720P|1200|无|

        目前只支持分辨率在480P、540P和720P中切换，当码率调整在相应的区间中时，会动态调整成相应的分辨率，注意分辨率调整只能由初始分辨率向下调整，也就是说如果初始设置分辨率为540P，那么动态分辨率只能最大调整到540P。

        **说明：** 动态分辨率在某些播放器上可能无法正常播放，阿里云播放器已支持。使用动态分辨率功能时，建议您使用阿里云播放器。

    4.  纯音视频推流设置

        SDK支持纯音频和纯视频推流设置，通过打开audioOnly，SDK就会只推纯音频流，如果打开videoOnly，SDK只推纯视频流。不可以同时打开这两种模式。

        示例代码如下：

        ```
        self.pushConfig.audioOnly = YES;//设置纯音频推流
        ```

        ```
        self.pushConfig.videoOnly = YES;//设置纯视频推流
        ```

    5.  推流图片设置

        为了更好的用户体验，SDK提供了后台图片推流和码率过低时进行图片推流的设置。当SDK在退后台时默认暂停推流视频，只推流音频，此时可以设置图片来进行图片推流和音频推流。例如，在图片上提醒用户“主播离开片刻，稍后回来”。示例代码如下：

        ```
        self.pushConfig.pauseImg = [UIImage imageNamed:@"图片.png"];//设置用户后台推流的图片
        ```

        另外，当网络较差时用户可以根据自己的需求设置推流一张静态图片。设置图片后，SDK检测到当前码率较低时，会推流此图片，避免视频流卡顿。示例代码如下：

        ```
        self.pushConfig.networkPoorImg = [UIImage imageNamed:@"图片.png"];//设置网络较差时推流的图片
        ```

        **说明：** 此处的图片只支持png格式，且在app资源文件中能够访问到的图片，不支持网络图片。

    6.  水印设置

        SDK提供了添加水印功能，并且最多支持添加多个水印，水印图片必须为png格式图片，目前最多支持3个水印。示例代码如下：

        ```
        NSString *watermarkBundlePath = [[NSBundle mainBundle] pathForResource:
                                         [NSString stringWithFormat:@"watermark"] 
                                         ofType:@"png"];//设置水印图片路径
        [self.pushConfig addWatermarkWithPath: watermarkBundlePath
                     watermarkCoordX:0.1
                     watermarkCoordY:0.1
                     watermarkWidth:0.3];//添加水印
        ```

        **说明：** 

        -   coordX、coordY、width为相对值，例如watermarkCoordX:0.1表示水印的x值为推流画面的10%位置，即推流分辨率为540\*960，则水印x值为54。
        -   水印图片的高度按照水印图片的真实宽高与输入的width值等比缩放。
        -   要实现文字水印，可以先将文字转换为图片，再使用此接口添加水印。
        -   为了保障水印显示的清晰度与边缘平滑，请您尽量使用和水印输出尺寸相同大小的水印源图片。如输出视频分辨率544\*940, 水印显示的w是0.1f，则尽量使用水印源图片宽度在544\*0.1f=54.4左右。
    7.  显示模式设置

        推流预览显示支持以下三种模式：

        -   ALIVC\_LIVE\_PUSHER\_PREVIEW\_SCALE\_FILL //铺满窗口，视频比例和窗口比例不一致时预览会有变形。
        -   ALIVC\_LIVE\_PUSHER\_PREVIEW\_ASPECT\_FIT //保持视频比例，视频比例和窗口比例不一致时有黑边（默认）。
        -   ALIVC\_LIVE\_PUSHER\_PREVIEW\_ASPECT\_FILL //剪切视频以适配窗口比例，视频比例和窗口比例不一致时会裁剪视频。
        这三种模式可以在AlivcLivePushConfig中设置，也可以在预览中和推流中通过API setpreviewDisplayMode 进行动态设置。

        **说明：** 本设置只对预览显示生效，实际推出的视频流的分辨率和AlivcLivePushConfig中预设置的分辨率一致，并不会因为更改预览显示模式而变化。预览显示模式是为了适配不同尺寸的手机，您可以自由选择预览效果。

2.  创建AlivcLivePusher对象

    当AlivcLivePushConfig对象创建成功并设置了初始化参数后，根据AlivcLivePushConfig对象来创建AlivcLivePusher对象。示例代码如下：

    ```
    self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.pushConfig];
    ```

3.  注册回调

    推流主要回调分为Info、Error、Network、背景音乐、截图、自定义滤镜和自定义人脸检测回调，注册delegate可接受对应的回调。示例代码如下：

    ```
    [self.livePusher setInfoDelegate:self];
    [self.livePusher setErrorDelegate:self];
    [self.livePusher setNetworkDelegate:self];
    [self.livePusher setBGMDelegate:self];
    [self.livePusher setSnapshotDelegate:self];
    [self.livePusher setCustomFilterDelegate:self];
    [self.livePusher setCustomDetectorDelegate:self];
    ```


## 预览 {#section_ovv_2zx_pfb .section}

1.  开始预览

    初始化成功之后，就是进入预览的环节，预览使用外部传入一个UIView，调用startPreview接口后SDK内部会自动打开相机采集，并将采集画面渲染到预览 UIView上。示例代码如下：

    ```
    [self.livePusher startPreview:self.view];
    ```

    **说明：** 如果APP没有打开过系统相机使用权限，这一步会要求打开系统相机权限，如果选择禁止打开相机，会导致预览失败。

2.  停止预览

    调用stopPreview可以停止预览，此时画面会停留在最后一帧。示例代码如下：

    ```
    [self.livePusher stopPreview];
    ```


## 推流 {#section_wcv_gzx_pfb .section}

1.  开始推流

    预览成功后，调用startPushWithURL接口开始推流，startPushWithURL接口需要传入有效的rtmp推流url地址，阿里云推流地址获取参见 快速开始。使用正确的推流地址开始推流后，可用播放器（阿里云播放器、ffplay、VLC等）进行拉流测试，拉流地址如何获取参见 快速开始。示例代码如下：

    ```
    [self.livePusher startPushWithURL:@"推流测试地址(rtmp://......)"];
    ```

2.  停止推流

    通过调用stopPush接口可以停止推流。示例代码如下：

    ```
    [self.livePusher stopPush];
    ```

3.  重新推流

    通过调用restartPush可以在推流中或者推流出错后，重新开始推流。示例代码如下：

    ```
    [self.livePusher restartPush];
    ```


## 暂停恢复 {#section_ttp_fdl_nfb .section}

在推流过程中，通过调用pause和resume接口来控制推流的暂停和恢复。

1.  暂停

    暂停是指推流过程中调用pause接口暂停相机的采集，此时的推流行为是只采集音频数据，视频数据不采集，所以此时推流只推音频数据，不推视频数据，但是如果用户设置了pauseImg，此时视频会推设置的图片数据。示例代码如下：

    ```
    [self.livePusher pause];
    ```

2.  恢复

    恢复就是通过调用resume接口恢复正常推流状态。示例代码如下：

    ```
    [self.livePusher resume];
    ```


## 前后台切换 {#section_qzx_1lk_wgb .section}

当应用受到其他系统行为的影响比如来电话等会导致应用出现前后台切换的操作，以及用户主动切换前后台操作都会影响推流的行为。

由于受到系统的限制，在应用退到后台时，相机采集会停止工作，此时用两种选择，是否需要退后台继续推流，就是在后台推流不中断。

1.  后台继续推流

    首先需要在app 的Capabilities中打开Background Modes 中的Audio，AirPlay，and Picture in Picture 模式，支持后台音频访问，保持app在后台工作。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40320/155418917921048_zh-CN.png)

    当app进入后台的时候，目前SDK已经侦听了该系统通知，并对推流做暂停处理，此时推流行为和暂停表现一致，也就是只推音频，不推视频，如果设置了背景图片的话视频推背景图片。App不用做任何处理，会自动在后台推流。

    回到前台时，SDK也会自动恢复推流，不需要app做任何处理。

2.  后台停止推流

    当app切换到后台需要停止推流时，需要在以下系统通知中做停止推流处理。示例代码如下：

    ```
    - (void)applicationWillResignActive:(NSNotification *)notification {
        // 如果退后台不需要继续推流，则停止推流
        if ([self.livePusher isPushing]) {
            [self.livePusher stopPush];
        }
    }
    ```

    注意此时推流已经中断，回到前台需要继续推流时，需要做以下操作。示例代码如下：

    ```
    - (void)applicationDidBecomeActive:(NSNotification *)notification {
    
        [self.livePusher startPushWithURLAsync:self.pushURL];
    }
    ```


## 重连 {#section_fzs_zdj_wgb .section}

重连操作包括自动重连和手动重连两种。

1.  自动重连

    在SDK内部检测到socket连接失败或者断开的时候，会有自动重连机制，在AlivcLivePushConfig中的connectRetryCount重连次数和connectRetryInterval重连间隔用来控制自动重连的次数和每次之间的间隔，当所有重连次数用完还没有重连成功时，会上报重连失败错误后不再继续重连。

2.  手动重连

    手动重连是外部调用SDK接口reconnectPushAsync接口进行手动重连。


## 美颜控制 {#section_fr2_g2j_wgb .section}

阿里云推流SDK提供两种美颜模式：基础美颜和高级美颜。

-   基础美颜支持美白、磨皮和红润。
-   高级美颜支持基于人脸识别的美白、磨皮、红润、大眼、小脸、瘦脸、腮红等功能。

目前SDK 美颜采用外置对接方式，也就是说APP 需要对接实现美颜的回调才能使用美颜功能。首先app需要加载美颜的库文件AlivcLibBeauty.framework、人脸检测库AlivcLibFace.framework以及人脸检测资源包AlivcLibFaceResource.bundle。

然后实现美颜和人脸检测的回调。示例代码如下：

```
/**
 外置美颜滤镜创建回调
 */
- (void)onCreate:(AlivcLivePusher *)pusher context:(void*)context
{
    [[AlivcLibBeautyManager shareManager] create:context];
}

/**
 外置美颜滤镜更新参数回调
 */
- (void)updateParam:(AlivcLivePusher *)pusher buffing:(float)buffing whiten:(float)whiten pink:(float)pink cheekpink:(float)cheekpink thinface:(float)thinface shortenface:(float)shortenface bigeye:(float)bigeye
{
    [[AlivcLibBeautyManager shareManager] setParam:buffing whiten:whiten pink:pink cheekpink:cheekpink thinface:thinface shortenface:shortenface bigeye:bigeye];
}

/**
 外置美颜滤镜开关回调
 */
- (void)switchOn:(AlivcLivePusher *)pusher on:(bool)on
{
    [[AlivcLibBeautyManager shareManager] switchOn:on];
}

/**
 外置美颜滤镜开关回调
 */
- (void)switchOn:(AlivcLivePusher *)pusher on:(bool)on
{
    [[AlivcLibBeautyManager shareManager] switchOn:on];
}

/**
 通知外置滤镜销毁回调
 */
- (void)onDestory:(AlivcLivePusher *)pusher
{
    [[AlivcLibBeautyManager shareManager] destroy];
}

/**
 外置人脸检测创建回调
 */
- (void)onCreateDetector:(AlivcLivePusher *)pusher
{
    [[AlivcLibFaceManager shareManager] create];
}

/**
 外置人脸检测处理回调
 */
- (long)onDetectorProcess:(AlivcLivePusher *)pusher data:(long)data w:(int)w h:(int)h rotation:(int)rotation format:(int)format extra:(long)extra
{
     return [[AlivcLibFaceManager shareManager] process:data width:w height:h rotation:rotation format:format extra:extra];
}

/**
 外置人脸检测销毁回调
 */
- (void)onDestoryDetector:(AlivcLivePusher *)pusher
{
    [[AlivcLibFaceManager shareManager] destroy];
}
```

通过设置AlivcLivePushConfig中的相关美颜参数，或者调用美颜相关接口都可以控制美颜开关、是否使用高级美颜以及调节美颜参数。

基本设置相关代码。示例代码如下：

```
self.pushConfig.beautyOn = true; // 开启美颜
self.pushConfig.beautyMode = AlivcLivePushBeautyModeProfessional；//设定为高级美颜
self.pushConfig.beautyWhite = 70; // 美白范围0-100
self.pushConfig.beautyBuffing = 40; // 磨皮范围0-100
self.pushConfig.beautyRuddy = 40;// 红润设置范围0-100
self.pushConfig.beautyBigEye = 30;// 大眼设置范围0-100
self.pushConfig.beautyThinFace = 40;// 瘦脸设置范围0-100
self.pushConfig.beautyShortenFace = 50;// 收下巴设置范围0-100
self.pushConfig.beautyCheekPink = 15;// 腮红设置范围0-100
```

动态更改可以通过接口setBeautyOn、setBeautyWhite、setBeautyBuffing、setBeautyRuddy、setBeautyCheekPink、setBeautyThinFace、setBeautyShortenFace和setBeautyBigEye来调节美颜相关设置。

**说明：** 由于美颜采用了外置对接方式，这样很方便app对接第三方的美颜和人脸检测的滤镜，只要在对应的回调处理中调用第三方滤镜的相关接口就能使SDK中完美对接第三方的美颜滤镜。

我们提供了丰富的美颜参数，建议您在UED同事配合下，调整出最符合自己应用风格的美颜参数。

以下几组美颜效果比较理想，您可参考下表：

|档位|磨皮|美白|红润|大眼|瘦脸|收下巴|腮红|
|:-|:-|:-|:-|:-|:-|:--|:-|
|一档|40|35|10|0|0|0|0|
|二挡|60|80|20|0|0|0|0|
|三挡|50|100|20|0|0|0|0|
|四挡|40|70|40|30|40|50|15|
|五档|70|100|10|30|40|50|0|

## 相机控制 {#section_pr2_g2j_wgb .section}

相机控制是包括切换相机、获取当前相机位置、对焦、缩放、曝光和手电筒操作。

1.  切换相机

    切换前置后置相机，预览和直播中都可以切换。

    ```
    [self.livePusher switchCamera];
    ```

2.  设置手电筒

    ```
    [self.livePusher setFlash:YES];
    ```

3.  自动对焦

    ```
    [self.livePusher setAutoFocus:YES];
    ```

4.  手动对焦

    ```
    [self.livePusher focusCameraAtPoint:point needAutoFocus:YES];
    ```

5.  设置缩放倍数

    缩放接口为增量设置，每次设置参数都是在当前基础上做增减，缩放倍数范围（1-3）。

    ```
    [self.livePusher setZoom:1.0];//当前的缩放倍数+1
    ```

6.  获取缩放倍数

    ```
    self.zoom = [self.livePusher getCurrentZoom];
    ```

7.  获取最大缩放倍数

    ```
    self.zoom = [self.livePusher getMaxZoom];
    ```

8.  设置曝光度

    ```
    self.zoom = [self.livePusher setExposure:self.exposure];
    ```

9.  获取相机最小曝光度值

    ```
    [self.livePusher getSupportedMinExposure];
    ```

10. 获取相机最大曝光度值

    ```
    [self.livePusher getSupportedMaxExposure];
    ```

11. 获取当前曝光度值

    ```
    [self.livePusher getCurrentExposure];
    ```


## 截图 {#section_sr2_g2j_wgb .section}

截图功能是在推流和预览中可以截取视频生成图片，通过调用接口snapshot来实现，snapshot中有两个参数count和interval， count 表示要截取图片的个数，interval表示每张图片的间隔，如果需要立刻截取当前一张视频图片，只要传递count为1，interval为0即可。示例代码如下：

```
[self.livePusher snapshot:self.count interval:self.interval];
```

截图是异步代理回调操作，截图结果通过代理AlivcLivePusherSnapshotDelegate回调给app，app必须实现代理中的onSnapshot方法。示例代码如下：

```
- (void)onSnapshot:(AlivcLivePusher *)pusher image:(UIImage *)image {
}
```

## 背景音乐 {#section_tr2_g2j_wgb .section}

该功能提供背景音乐播放、混音、降噪、耳返、静音等功能，通过AlivcLivePusher中的如下接口实现以上功能：

```
/*开始播放背景音乐。*/
[self.livePusher startBGMWithMusicPathAsync:musicPath];

/*停止播放背景音乐。若当前正在播放BGM，并且需要切换歌曲，只需要调用开始播放背景音乐接口即可，无需停止当前正在播放的背景音乐。*/
[self.livePusher stopBGMAsync];

/*暂停播放背景音乐，背景音乐开始播放后才可调用此接口。*/
[self.livePusher pauseBGM];

/*恢复播放背景音乐，背景音乐暂停状态下才可调用此接口。*/
[self.livePusher resumeBGM];

/*开启循环播放音乐*/
[self.livePusher setBGMLoop:true];

/*设置降噪开关。打开降噪后，将对采集到的声音中非人声的部分进行过滤处理。可能存在对人声稍微抑制作用，建议让用户自由选择是否开启降噪功能，默认不使用*/
[self.livePusher setAudioDenoise:true];

/*设置耳返开关。耳返功能主要应用于KTV场景。打开耳返后，插入耳机将在耳机中听到主播说话声音。关闭后，插入耳机无法听到人声。未插入耳机的情况下，耳返不起作用。*/
[self.livePusher setBGMEarsBack:true];

/*混音设置，提供背景音乐和人声采集音量调整。*/
[self.livePusher setBGMVolume:50];//设置背景音乐音量
[self.livePusher setCaptureVolume:50];//设置人声采集音量

/*设置静音。静音后音乐声音和人声输入都会静音。要单独设置音乐或人声静音可以通过混音音量设置接口来调整。*/
[self.livePusher setMute:isMute?true:false];
```

**说明：** 该功能只能在开始预览之后才可调用，目前只支持mp3格式音乐文件。

## 自定义音视频流输入 {#section_ur2_g2j_wgb .section}

该功能支持将外部的音视频源输入进行推流，比如推送一个音视频文件、第三方设备采集的音视频数据等。具体功能使用介绍如下：

1.  全局配置自定义音视频输入

    在推流配置AlivcLivePushConfig中配置使用自定义音视频输入，也可包括与自定义输入流相关的其他配置，具体配置如下：

    ```
    self.pushConfig.externMainStream = true;//开启允许外部流输入
    self.pushConfig.externVideoFormat = AlivcLivePushVideoFormatYUVNV21;//设置视频数据颜色格式定义，这里设置为YUVNV21，可根据需求设置为其他格式。
    self.pushConfig.externMainStream = AlivcLivePushAudioFormatS16;//设置音频数据位深度格式，这里设置为S16，可根据需求设置为其他格式。
    ```

    其中，视频图像格式目前支持：

    -   IMAGE\_FORMAT\_BGRA
    -   IMAGE\_FORMAT\_RGBA
    -   IMAGE\_FORMAT\_YUVNV12
    -   IMAGE\_FORMAT\_YUVNV21
    -   IMAGE\_FORMAT\_YUV420P
    音频帧格式目前只支持PCM 格式，且为SOUND\_FORMAT\_S16。

2.  插入自定义音视频数据
    -   插入yuv 或者rgba视频数据，使用sendVideoData接口。

        ```
        [self.livePusher sendVideoData:yuvData 
                                 width:720 
                                 height:1280 
                                 size:dataSize 
                                 pts:nowTime
                                 rotation:0];
        ```

    -   插入CMSampleBufferRef格式视频数据，使用sendVideoSampleBuffer接口。

        ```
        [self.livePusher sendVideoSampleBuffer:sampleBuffer]
        ```

    -   也可以将 CMSampleBufferRef格式转化为连续buffer后再传递给sendVideoData接口， 以下为转换的参考代码。

        ```
        //获取samplebuffer长度
        - (int) getVideoSampleBufferSize:(CMSampleBufferRef)sampleBuffer {
        if(!sampleBuffer) {
            return 0;
        }
        int size = 0;
        CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(pixelBuffer, 0);
        if(CVPixelBufferIsPlanar(pixelBuffer)) {
           int count = (int)CVPixelBufferGetPlaneCount(pixelBuffer);
           for(int i=0; i<count; i++) {
               int height = (int)CVPixelBufferGetHeightOfPlane(pixelBuffer,i);
               int stride =  (int)CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer,i);
               size += stride*height;
           }
        }else {
           int height = (int)CVPixelBufferGetHeight(pixelBuffer);
           int stride = (int)CVPixelBufferGetBytesPerRow(pixelBuffer);
           size += stride*height;
        }
        CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
        return size;
        }
        
        //将samplebuffer转化为连续buffer
        - (int) convertVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer toNativeBuffer:(void*)nativeBuffer {
        if(!sampleBuffer || !nativeBuffer) {
           return -1;
        }
        CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(pixelBuffer, 0);
        int size = 0;
        if(CVPixelBufferIsPlanar(pixelBuffer)) {
           int count = (int)CVPixelBufferGetPlaneCount(pixelBuffer);
           for(int i=0; i<count; i++) {
               int height = (int)CVPixelBufferGetHeightOfPlane(pixelBuffer,i);
               int stride = (int)CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer,i);
               void *buffer = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, i);
               int8_t *dstPos = (int8_t*)nativeBuffer + size;
               memcpy(dstPos, buffer, stride*height);
               size += stride*height;
           }
        }else {
           int height = (int)CVPixelBufferGetHeight(pixelBuffer);
           int stride = (int)CVPixelBufferGetBytesPerRow(pixelBuffer);
           void *buffer = CVPixelBufferGetBaseAddress(pixelBuffer);
           size += stride*height;
           memcpy(nativeBuffer, buffer, size);
        }
        CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
        return 0;
        }
        ```

    -   插入音频PCM数据

        ```
        [self.livePusher sendPCMData:pcmData size:size pts:nowTime];
        ```


## 混流功能 {#section_yr2_g2j_wgb .section}

混流顾名思义就是把一路或多路音视频流混合成单路流推到流媒体服务器。具体使用介绍如下：

1.  添加混流

    添加混流包括混流格式设置、旋转角度设置、混流位置、音频采样率设置等，添加后获取到的返回值用于标示这一路混流，假如返回-1则混流失败，具体代码调用示例如下：

    ```
    //添加视频混流
    int mixId = [self.livePusher addMixVideo:IMAGE_FORMAT_BGRA // 视频格式
                           width:720 //视频原始宽度
                          height:480 //视频原始高度
                        rotation:90  //旋转90度
                        displayX:0.5 //相对x坐标
                        displayY:0.5 //相对y坐标
                        displayW:0.5 //相对主视频的宽度
                        displayH:0.5 //相对主视频的高度
                    adjustHeight:NO];//不按照高度一致对齐（多路混流的场景） 
    
    //添加音频混流
    int mixId = [self.livePusher addMixAudio:2 //声道数
                                      format:SOUND_FORMAT_S16 //格式
                                 audioSample:44100]; //采样率
    ```

2.  更新混流位置

    已经添加过的视频混流可以修改其显示位置。

    ```
    [self.livePusher changeMixVideoPosition:mixId
                        displayX:0.5
                        displayY:0.5
                        displayW:0.5
                        displayH:0.5];
    ```

3.  输入混流数据

    确认添加好混流后，将已获得的混流返回值用于实际音视频流数据输入，具体示例如下：

    ```
    //输入视频混流数据
    [self.livePusher inputMixVideoData:mixId //混流id
                                  data:dataptr //数据指针
                                 width:width //长度
                                height:height //宽度
                                stride:stride //步幅
                                  size:size   //数据长度
                                   pts:pts    //pts
                              rotation:rotation]; //旋转角度
    
    //输入音频混流数据
     [self.livePusher inputMixAudioData:mixID //混流id
                                  data:dataptr //数据指针
                                  size:size //数据长度
                                   pts:pts]; //pts
    ```

4.  删除混流

    清理已有混流，包括移除音频和视频，具体示例如下：

    ```
    //移除已添加的一路视频混流
    [self.livePusher removeMixVideo:mixID];
    
    //移除已添加的一路音频混流
    [self.livePusher removeMixAudio:mixID];
    ```


## 直播答题 {#section_cs2_g2j_wgb .section}

该功能可以通过在直播流里面插入SEI信息并发送后阿里云播放器SDK可收到此SEI消息，解析后做具体展示。另外为了保证SEI不被丢帧，需设置重复次数，如设置100，则在接下去的100帧均插入此SEI消息，这个过程中播放器会对相同的SEI进行去重处理。示例代码如下：

```
/*
 * 推流端发送自定义消息
 *
 * @param info         需要插入流的SEI消息体，建议是json格式
 * @param repeatCount  发送的帧数
 * @param delayTime    延时多少毫秒发送
 * @param KeyFrameOnly 是否只发送关键帧
 */

[self.livePusher sendMessage:@"题目信息" repeatCount:100 delayTime:0 KeyFrameOnly:false];
```

**说明：** 只有在推流状态下，才能调用此接口。

## 录屏直播 {#section_ds2_g2j_wgb .section}

iOS 系统从iOS11版本开始的replaykit2中增加了系统录屏直播的功能，此功能可以录制手机的整个屏幕的音视频和麦克风采集内容并对接第三方扩展，而不受任何的限制，通过实现录屏的扩展对接阿里云直播SDK，可以非常方便地实现iOS手机的录屏直播功能。

**说明：** 手机需要升级到iOS11及以上系统。

1.  创建录屏扩展

    在APP中创建新的target，选择 Broadcast Upload Extension, 创建该App 对应的录屏直播扩展。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40320/155418917921049_zh-CN.png)

    创建成功后，会在工程项目中出现以下扩展相关内容。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40320/155418917921051_zh-CN.png)

    此时运行安装APP后，该扩展会一起和APP安装到手机上。

    如下图，打开系统录屏菜单，找到录屏按钮。如果找不到录屏按钮，请在设置 \> 控制中心 \> 自定控制中添加"屏幕录制"选项。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40320/155418917921052_zh-CN.png)

    长按录屏按钮后会跳出选项，刚刚创建的录屏扩展就在选项中，选中扩展，按下开始直播按钮，通过debug就会发现系统开始录屏并将录屏的音视频数据通过SampleHandler.m 中的接口processSampleBuffer回调给录屏扩展。

2.  录屏扩展对接阿里云推流SDK

    当录屏扩展能够接收到录屏的音视频数据后，下一步就是通过阿里云直播SDK就录屏数据直播出去，在扩展中加载直播SDK头文件并初始化 AlivcLivePushConfig 和AlivcLivePusher对象。注意因为录屏直播使用的是系统推送的音视频数据进行推流直播，所以在配置直播config时，需要打开外部数据推流设置。

    开启录屏直播示例代码如下：

    ```
    - (void)startLivePush {
        @synchronized(self) {
            _pushConfig = [[AlivcLivePushConfig alloc]init];
            
            //设置外部数据推流
            _pushConfig.externMainStream = true;
            
            //设置视频输入格式
            _pushConfig.externVideoFormat = AlivcLivePushVideoFormatYUVNV12;
            
            //设置输出分辨率
            _pushConfig.resolution = self.resolution;
            
            //设置音频输出
            _pushConfig.audioSampleRate = 44100;
            _pushConfig.audioChannel = 1;
            
            //设置输出横屏,默认竖屏
            _pushConfig.orientation =  self.orientation;
            
            //关闭美颜
            _pushConfig.beautyOn = false;
            
            //创建推流
            _livePusher = [[AlivcLivePusher alloc] initWithConfig:self.pushConfig];
            
            //设置推流地址，开始推流
            [_livePusher startPushWithURL:self.pushUrl];
    
        }
    }
    ```

    由于是系统回调的录屏音视频数据传递给录屏扩展，需要讲音视频数据输入给推流SDK，通过接口sendVideoSampleBuffer和sendAudioSampleBuffer可以讲音视频数据发送给SDK进行推流。示例代码如下：

    ```
    - (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
         @synchronized(self) {
            switch (sampleBufferType) {
                case RPSampleBufferTypeVideo:
                    // Handle video sample buffer
                    [self.livePusher sendVideoSampleBuffer:sampleBuffer];
                    break;
                case RPSampleBufferTypeAudioApp:
                    // Handle audio sample buffer for app audio
                    [self.livePusher sendAudioSampleBuffer:sampleBuffer withType:sampleBufferType];
                    break;
                case RPSampleBufferTypeAudioMic:
                    // Handle audio sample buffer for mic audio
                    [self.livePusher sendAudioSampleBuffer:sampleBuffer withType:sampleBufferType];
                    break;
                    
                default:
                    break;
            }
         }
    }
    ```

    停止录屏直播封装。示例代码如下：

    ```
    - (void)stopLivePush {
        
        if(self.livePusher) {
            [self.livePusher stopPush];
            [self.livePusher destory];
            self.livePusher = nil;
        }
    }
    ```

3.  录屏直播控制

    由于扩展和APP是两个独立进程运行，所以录屏直播的控制需要通过APP 和扩展之间进程间CFNotificationCenter通信才能完成，详细可以参考demo中的具体实现。

4.  问题说明
    -   由于iOS系统对扩展使用内存的限制，扩展的内存大小不能超过50M，所以在使用时建议录屏分辨率设置为passthrough模式，保持屏幕原始分辨率直播，因为SDK内部进行分辨率转换时会增加额外的内存开销，容易导致扩展内存超过最大限制的风险。
    -   系统的锁屏、来电等一些操作会强制中断录屏操作，此时推流也会一并中断，需要重新启动录屏直播才能继续。
    -   录屏时，一些APP前后台操作会影响APP声音的采集，就是当前有声音的APP在前台时录屏直播声音正常，但是此时其他APP切换到前台时，之前的APP的声音就会被禁音，这是iOS系统的录屏采集行为。

## 接口回调处理 {#section_b1t_y3j_wgb .section}

1.  错误回调处理

    当收到AlivcLivePusherErrorDelegate时：

    -   当出现onSystemError系统级错误时，您需要退出直播。
    -   当出现onSDKError错误（SDK错误）时，有两种处理方式，选择其一即可：销毁当前直播重新创建、调用`restartPush`/`restartPushAsync`重启`AlivcLivePusher`。
    -   您需要特别处理APP没有麦克风权限和没有摄像头权限的回调。
        -   APP没有麦克风权限错误描述为：capture camera open failed.
        -   APP没有摄像头权限错误描述为：capture mic open failed.
    AlivcLivePusherErrorDelegate接口回调如下：

    ```
    /**
     系统错误回调
    
     @param pusher 推流AlivcLivePusher
     @param error error
     */
    - (void)onSystemError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error;
    
    
    /**
     SDK错误回调
    
     @param pusher 推流AlivcLivePusher
     @param error error
     */
    - (void)onSDKError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error;
    ```

2.  网络监听回调处理

    当您收到AlivcLivePusherNetworkDelegate回调时：

    -   网速慢时，回调`onNetworkPoor`，当您收到此回调说明当前网络对于推流的支撑度不足，此时推流仍在继续并没有中断。网络恢复时，回调`onNetworkRecovery`。您可以在此处理自己的业务逻辑，比如UI提醒用户。
    -   网络出现相关错误时，回调`onConnectFail`、`onReconnectError` 或 `onSendDataTimeout`。有两种处理方式，您只需选择其一：销毁当前推流重新创建或调用 `reconnectAsync` 进行重连，建议您重连之前先进行网络检测和推流地址检测。
    -   SDK内部每次自动重连或者开发者主动调用 `reconnectAsync` 重连接口的情况下，会回调 `onReconnectStart`重连开始。每次重连都会对 RTMP 进行重连链接。

        **说明：** RTMP链接建立成功之后会回调 onReconnectSuccess此时只是链接建立成功，并不意味着可以推流数 据成功，如果链接成功之后，由于网络等原因导致推流数据发送失败，SDK会在继续重连。

    -   推流地址鉴权即将过期会回调`onPushURLAuthenticationOverdue`。如果您的推流开启了推流鉴权功能\(推流URL中带有auth\_key\)。我们会对推流URL做出校验。在推流URL过期前约1min，您会收到此回调，实现该回调后，您需要回传一个新的推流URL。以此保证不会因为推流地址过期而导致推流中断。
    AlivcLivePusherNetworkDelegate接口回调如下：

    ```
    /**
     网络差回调
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onNetworkPoor:(AlivcLivePusher *)pusher;
    
    
    /**
     推流链接失败
    
     @param pusher 推流AlivcLivePusher
     @param error error
     */
    - (void)onConnectFail:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error;
    
    
    /**
     网络恢复
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onConnectRecovery:(AlivcLivePusher *)pusher;
    
    
    /**
     重连开始回调
     
     @param pusher 推流AlivcLivePusher
     */
    - (void)onReconnectStart:(AlivcLivePusher *)pusher;
    
    
    /**
     重连成功回调
     
     @param pusher 推流AlivcLivePusher
     */
    - (void)onReconnectSuccess:(AlivcLivePusher *)pusher;
    
    /**
     连接被断开
     
     @param pusher 推流AlivcLivePusher
     */
    - (void)onConnectionLost:(AlivcLivePusher *)pusher;
    
    
    /**
     重连失败回调
    
     @param pusher 推流AlivcLivePusher
     @param error error
     */
    - (void)onReconnectError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error;
    
    
    /**
     发送数据超时
     
     @param pusher 推流AlivcLivePusher
     */
    - (void)onSendDataTimeout:(AlivcLivePusher *)pusher;
    
    
    /**
     推流URL的鉴权时长即将过期(将在过期前1min内发送此回调)
    
     @param pusher 推流AlivcLivePusher
     @return 新的推流URL
     */
    - (NSString *)onPushURLAuthenticationOverdue:(AlivcLivePusher *)pusher;
    
    
    /**
     发送SEI Message 通知
     
     @param pusher 推流AlivcLivePusher
     */
    - (void)onSendSeiMessage:(AlivcLivePusher *)pusher;
    ```

3.  背景音乐播放回调处理

    当收到AlivcLivePusherBGMDelegate 背景音乐错误回调时：

    -   背景音乐开启失败时会回调`onOpenFailed`，检查背景音乐开始播放接口所传入的音乐路径与该音乐文件是否正确，可调用 `startBGMAsync`重新播放。
    -   背景音乐播放超时会回调`onDownloadTimeout`，多出现于播放网络URL的背景音乐，提示主播检查当前网络状态，可调用 `startBGMAsync`重新播放。
    AlivcLivePusherBGMDelegate回调如下：

    ```
    /**
     背景音乐开始播放
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onStarted:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐停止播放
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onStoped:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐暂停播放
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onPaused:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐恢复播放
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onResumed:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐当前播放进度
    
     @param pusher 推流AlivcLivePusher
     @param progress 播放时长
     @param duration 总时长
     */
    - (void)onProgress:(AlivcLivePusher *)pusher progress:(long)progress duration:(long)duration;
    
    /**
     背景音乐播放完毕
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onCompleted:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐开启失败
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onOpenFailed:(AlivcLivePusher *)pusher;
    
    /**
     背景音乐下载播放超时
    
     @param pusher 推流AlivcLivePusher
     */
    - (void)onDownloadTimeout:(AlivcLivePusher *)pusher;
    ```


## 特殊情况处理 {#section_ts2_g2j_wgb .section}

1.  网络中断处理
    -   短时间断网和网络切换：短时间的网络波动或者网络切换。一般情况下，中途断网时长在AlivcLivePushConfig设置的重连超时时长和次数范围之内，SDK会进行自动重连，重连成功之后将继续推流。若您使用阿里云播放器，建议播放器收到超时通知之后短暂延时5s后再做重连操作。
    -   长时间断网：断网时长在AlivcLivePushConfig设置的重连超时时长和次数范围之外的情况下，SDK自动重连失败，此时会回调 `onReconnectError` 在等到网络恢复之后调用 `reconnectAsync`接口进行重连。同时播放器也要配合做重连操作。
    -   针对网络情况提供以下建议说明：
        -   建议您在SDK外部做网络监测。
        -   主播端和播放端在客户端无法进行直接通信，需要配合服务端使用。比如主播端断网，服务端会收到CDN的推 流中断回调，此时可以推动给播放端，主播推流中断，播放端在作出相应处理。恢复推流同理。
        -   阿里云播放器重连需要先停止播放在开始播放。调用接口顺序stop \> prepareAndPlay。
2.  退后台和锁屏
    -   当app退后台或锁屏时，您可调用 AlivcLivePusher 的 pause/resume接口暂停/恢复推流。
    -   对于非系统的音视频通话，sdk会采集声音并推送出去，您可以根据业务需求在退后台或锁屏时调用静音接口setMute来决定后台时是否采集音频。

## 结束销毁推流 {#section_ys2_g2j_wgb .section}

当使用推流结束时需要调用推流相关的销毁接口，清理当前使用资源。

在正常推流模式下，具体示例如下：

```
if(self.livePusher) {
   [self.livePusher stopPush];
   [self.livePusher destory];
   self.livePusher = nil;
 }
```

## 注意事项 {#section_zs2_g2j_wgb .section}

-   接口调用
    -   同步异步接口都可以正常调用，尽量使用异步接口调用，可以避免对主线程的资源消耗。
    -   SDK接口都会在发生错误或者调用顺序不对时 thorws 出异常，调用时注意添加try catch 处理，否则会造成程序的crash。
    -   接口调用顺序，如下图所示：

        ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40320/155418918021053_zh-CN.png)

-   关于包大小
    -   SDK大小为23.9MB。
    -   集成SDK后，ipa包增加大小约为：带播放器版本14MB，不带播放器版本9MB。
    -   适配机型：iPhone5s及以上版本，iOS8.0及以上版本。
-   功能限制说明
    -   您只能在推流之前设置横竖屏模式，不支持在直播的过程中实时切换。
    -   在推流设定为横屏模式时，需设定界面为不允许自动旋转。
    -   在硬编模式下，考虑编码器兼容问题分辨率会使用16的倍数，如设定为540p，则输出的分辨率为544\*960，在设置播放器视图大小时需按输出分辨率等比缩放，避免黑边等问题。
-   关于历史版本升级说明
    -   推流SDK V1.3升级至 \[V3.0.0-3.3.3\]、连麦SDK升级至推流 \[V3.0.0-3.3.3\]，请下载 [升级说明文档](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45265/cn_zh/1511187112732/updateDoc_android_20171120.zip?spm=a2c4g.11186623.2.37.6284161cvDZvBu&file=updateDoc_android_20171120.zip)。
    -   从V3.3.4版开始不支持推流V1.3版兼容，升级时建议您重新接入最新版SDK。
    -   推流SDK升级至V3.1.0，如果您未集成阿里云播放器SDK，需集成该SDK（已包含推流SDK下载包里面）。
    -   推流SDK升级至V3.2.0+，提供包含阿里云播放器的版本和不包含阿里云播放器两个版本。如果您需要背景音乐功能必须集成播放器，否则可以不使用播放器SDK。


# SDK使用 {#concept_zy5_myx_pfb .concept}

本文详细说明如何使用Android推流SDK API以及相关功能。

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

## 推流主要接口类列表 {#section_hp1_2b3_wgb .section}

|类|说明|
|:-|:-|
|AlivcLivePushConfig|推流初始配置|
|AlivcLivePusher|推流功能类|
|AlivcLivePushInfoListener|推流相关信息回调接口|
|AlivcLivePushNetworkListener|推流网络回调接口|
|AlivcLivePushErrorListener|推流报错回调接口|
|AlivcLivePushBGMListener|背景音乐回调接口|
|AlivcLivePushCustomFilter|自定义滤镜回调接口|
|AlivcLivePushCustomDetect|自定义人脸检测回调接口|
|AlivcSnapshotListener|截图回调接口|

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
    |videoEncoderMode|视频编码器|硬件编码|
    |audioEncoderProfile|音频编码格式|AAC LC|
    |audioEncoderMode|音频编码器|软编码|
    |externMainStream|自定义外部主流开关|关闭|
    |externVideoFormat|自定义外部视频数据格式| |
    |externAudioFormat|自定义外部音频数据格式| |
    |previewDisplayMode|预览窗口显示模式|ASPECT FIT模式|
    |addWatermarkWithPath|添加水印接口| |
    |removeWatermarkWithPath|移除水印接口| |
    |getAllWatermarks|获取所有水印信息| |
    |getPushResolution|获取推流分辨率| |

    1.  创建AlivcLivePushConfig对象

        ```
        mAlivcLivePushConfig = new AlivcLivePushConfig();
        ```

    2.  分辨率设置

        ```
        mAlivcLivePushConfig.setResolution(AlivcResolutionEnum.RESOLUTION_540P);
        ```

        SDK支持的主播推流分辨率如下：

        |分辨率定义|分辨率|
        |:----|:--|
        |AlivcResolutionEnum.RESOLUTION\_180P|192x320|
        |AlivcResolutionEnum.RESOLUTION\_240P|240x320|
        |AlivcResolutionEnum.RESOLUTION\_360P|368x640|
        |AlivcResolutionEnum.RESOLUTION\_480P|480x640|
        |AlivcResolutionEnum.RESOLUTION\_540P|544x960|
        |AlivcResolutionEnum.RESOLUTION\_720P|720x1280|
        |AlivcResolutionEnum.RESOLUTION\_PASS\_THROUGH|屏幕分辨率|

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
        |AlivcResolutionEnum.RESOLUTION\_180P|20|120|300|550|
        |AlivcResolutionEnum.RESOLUTION\_240P|20|180|450|750|
        |AlivcResolutionEnum.RESOLUTION\_360P|20|300|600|1000|
        |AlivcResolutionEnum.RESOLUTION\_480P|20|300|800|1200|
        |AlivcResolutionEnum.RESOLUTION\_540P|20|600|1000|1400|
        |AlivcResolutionEnum.RESOLUTION\_720P|20|600|1500|2000|

        **流畅度优先模式各视频参数对应值：**

        |分辨率|fps|minVideoBitrate 视频最小码率kbps|initialVideoBitrate 视频初始码率kbps|targetVideoBitrate 视频目标码率kbps|
        |:--|:--|:-------------------------|:-----------------------------|:----------------------------|
        |AlivcResolutionEnum.RESOLUTION\_180P|25|80|200|250|
        |AlivcResolutionEnum.RESOLUTION\_240P|25|120|300|350|
        |AlivcResolutionEnum.RESOLUTION\_360P|25|200|400|600|
        |AlivcResolutionEnum.RESOLUTION\_480P|25|300|600|800|
        |AlivcResolutionEnum.RESOLUTION\_540P|25|300|800|1000|
        |AlivcResolutionEnum.RESOLUTION\_720P|25|300|1000|1200|

        **说明：** 如果觉得清晰度优先模式和流畅度优先模式下的视频参数设置不满足推流场景要求，必须使用自定义模式来设置自定义的参数值。

        **码率自适应**

        码率自适应是推流码率控制中的一种策略，其定义表示推流过程中是否根据当前实际网络代码动态调整视频的编码码率，调整范围就是由最小码率、初始码率和，目标码率来限定的。

        码率自适应打开时，推流过程中首先使用初始码率作为编码码率，当检测到当前上传带宽充足时，会慢慢上调编码码率，直至到目标码率就不再向上调整，而当检测到当前上传带宽不足时，开始下调视频编码码率，下调的最小值为最小码率，此时不再继续下调。

        当码率自适应关闭时，整个推流过程中始终使用初始编码码率，不会动态去调整编码码率。

        **动态分辨率**

        动态分辨率是在推流过程中，根据码率调整到一定的范围后，可以动态切换相应的分辨率，也就是说此设置是依赖码率自适应的开关的，如果码率自适应关闭，此设置无效，且动态分辨率目前只支持清晰度优先模式和流畅度优先模式，不支持自定义模式。当动态分辨率开关生效后，对应的分辨率切换范围为：

        |分辨率|最小码率kbps|最大码率kbps率|
        |:--|:-------|:--------|
        |AlivcResolutionEnum.RESOLUTION\_480P|无|1000|
        |AlivcResolutionEnum.RESOLUTION\_540P|1000|1200|
        |AlivcResolutionEnum.RESOLUTION\_720P|1200|无|

        目前只支持分辨率在480P、540P和720P中切换，当码率调整在相应的区间中时，会动态调整成相应的分辨率。分辨率调整只能由初始分辨率向下调整，也就是说如果初始设置分辨率为540P，那么动态分辨率只能最大调整到540P。

        **说明：** 动态分辨率在某些播放器上可能无法正常播放，阿里云播放器已支持。使用动态分辨率功能时，建议您使用阿里云播放器。

    4.  纯音视频推流设置

        SDK支持纯音频和纯视频推流设置，通过打开audioOnly，SDK就会只推纯音频流，如果打开videoOnly，SDK只推纯视频流。不可以同时打开这两种模式。

        示例代码如下：

        ```
        //设置纯音频推流
        mAlivcLivePushConfig.setAudioOnly(true);
        ```

        ```
        //设置纯视频推流
        mAlivcLivePushConfig.setVideoOnly(true);
        ```

    5.  推流图片设置

        为了更好的用户体验，SDK提供了后台图片推流和码率过低时进行图片推流的设置。当SDK在退后台时默认暂停推流视频，只推流音频，此时可以设置图片来进行图片推流和音频推流。例如，在图片上提醒用户“主播离开片刻，稍后回来”。示例代码如下：

        ```
        //设置用户后台推流的图片
        mAlivcLivePushConfig.setPausePushImage("图片.png");
        ```

        另外，当网络较差时用户可以根据自己的需求设置推流一张静态图片。设置图片后，SDK检测到当前码率较低时，会推流此图片，避免视频流卡顿。示例代码如下：

        ```
        //设置网络较差时推流的图片
        mAlivcLivePushConfig.setNetworkPoorPushImage("图片.png");
        ```

        **说明：** 此处的图片只支持png格式，且在app资源文件中能够访问到的图片，不支持网络图片。

    6.  水印设置

        SDK提供了添加水印功能，并且最多支持添加多个水印，水印图片必须为png格式图片，目前最多支持3个水印。示例代码如下：

        ```
        //添加水印
        mAlivcLivePushConfig.addWaterMark(mWaterMarkPath, 0.1f, 0.1f, 0.3f);
        ```

        **说明：** 

        -   coordX、coordY、width为相对值，例如watermarkCoordX:0.1表示水印的x值为推流画面的10%位置，即推流分辨率为540\*960，则水印x值为54。
        -   水印图片的高度按照水印图片的真实宽高与输入的width值等比缩放。
        -   要实现文字水印，可以先将文字转换为图片，再使用此接口添加水印。
        -   为了保障水印显示的清晰度与边缘平滑，请您尽量使用和水印输出尺寸相同大小的水印源图片。如输出视频分辨率544\*940, 水印显示的w是0.1f，则尽量使用水印源图片宽度在544\*0.1f=54.4左右。
    7.  显示模式设置

        推流预览显示支持以下三种模式：

        -   AlivcPreviewDisplayMode.ALIVC\_LIVE\_PUSHER\_PREVIEW\_SCALE\_FILL //铺满窗口，视频比例和窗口比例不一致时预览会有变形。
        -   AlivcPreviewDisplayMode.ALIVC\_LIVE\_PUSHER\_PREVIEW\_ASPECT\_FIT //保持视频比例，视频比例和窗口比例不一致时有黑边（默认）。
        -   AlivcPreviewDisplayMode.ALIVC\_LIVE\_PUSHER\_PREVIEW\_ASPECT\_FILL //剪切视频以适配窗口比例，视频比例和窗口比例不一致时会裁剪视频。
        这三种模式可以在AlivcLivePushConfig中设置，也可以在预览中和推流中通过API setPreviewDisplayMode 进行动态设置。

        **说明：** 本设置只对预览显示生效，实际推出的视频流的分辨率和AlivcLivePushConfig中预设置的分辨率一致，并不会因为更改预览显示模式而变化。预览显示模式是为了适配不同尺寸的手机，您可以自由选择预览效果。

2.  创建AlivcLivePusher对象

    当AlivcLivePushConfig对象创建成功并设置了初始化参数后，根据AlivcLivePushConfig对象来创建AlivcLivePusher对象。示例代码如下：

    ```
    mAlivcLivePusher = new AlivcLivePusher();
    try {
        mAlivcLivePusher.init(getApplicationContext(), mAlivcLivePushConfig);
    } catch (IllegalArgumentException e) {
        e.printStackTrace();
    } catch (IllegalStateException e) {
        e.printStackTrace();
    }
    ```

3.  注册回调

    推流主要回调分为三种：Info、Error、Network、背景音乐、截图、自定义滤镜和自定义人脸检测回调，注册相应接口可接收到对应的回调。示例代码如下：

    ```
    mAlivcLivePusher.setLivePushInfoListener(this);
    mAlivcLivePusher.setLivePushNetworkListener(this);
    mAlivcLivePusher.setLivePushBGMListener(this);
    mAlivcLivePusher.setLivePushErrorListener(this);
    mAlivcLivePusher.setLivePushBGMListener(this);
    mAlivcLivePusher.setCustomFilter(this);
    mAlivcLivePusher.setCustomDetect(this);
    ```


## 预览 {#section_ovv_2zx_pfb .section}

1.  开始预览

    初始成功之后，就是进入预览的环节，预览使用外部传入一个SurfaceView，调用startPreview接口后SDK内部会自动打开相机采集，并将采集画面渲染到预览 SurfaceView 上。示例代码如下：

    ```
    if(mAsync) {
      mAlivcLivePusher.startPreviewAysnc(mPreviewView);
    } else {
      mAlivcLivePusher.startPreview(mPreviewView);
    }
    ```

    **说明：** 如果APP没有打开过系统相机使用权限，这一步会要求打开系统相机权限，如果选择禁止打开相机，会导致预览失败。

2.  停止预览

    调用stopPreview可以停止预览，此时画面会停留在最后一帧。示例代码如下：

    ```
    mAlivcLivePusher.stopPreview();
    ```


## 推流 {#section_wcv_gzx_pfb .section}

1.  开始推流

    预览成功后，调用startPush接口开始推流，startPush接口需要传入有效的rtmp推流url地址，阿里云推流地址获取参见 快速开始。使用正确的推流地址开始推流后，可用播放器（阿里云播放器、ffplay、VLC等）进行拉流测试，拉流地址如何获取参见 快速开始。示例代码如下：

    ```
    mAlivcLivePusher.startPush("推流测试地址(rtmp://......)");
    ```

2.  停止推流

    通过调用stopPush接口可以停止推流。示例代码如下：

    ```
    mAlivcLivePusher.stopPush();
    ```

3.  重新推流

    通过调用restartPush可以在推流中或者推流出错后，重新开始推流。示例代码如下：

    ```
    mAlivcLivePusher.restartPush();
    ```


## 暂停恢复 {#section_ttp_fdl_nfb .section}

在推流过程中，通过调用pause和resume接口来控制推流的暂停和恢复。

1.  暂停

    暂停是指推流过程中调用pause接口暂停相机的采集，此时的推流行为是只采集音频数据，视频数据不采集，所以此时推流只推音频数据，不推视频数据，但是如果用户设置了pauseImg，此时视频会推设置的图片数据。示例代码如下：

    ```
    mAlivcLivePusher.pause();
    ```

2.  恢复

    恢复就是通过调用resume接口恢复正常推流状态。示例代码如下：

    ```
    mAlivcLivePusher.resume();
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

目前SDK 美颜采用外置对接方式，也就是说APP 需要对接实现美颜的回调才能使用美颜功能。首先app需要加载美颜的AAR文件live-beauty-xxxx.aar、人脸检测AAR文件live-face-xxxx.aar。然后实现美颜和人脸检测的回调。示例代码如下：

```
//人脸识别回调（只接入标准版美颜可不需要调用此接口）
mAlivcLivePusher.setCustomDetect(new AlivcLivePushCustomDetect()
{
   @Override
  public void customDetectCreate() {
      taoFaceFilter = new TaoFaceFilter(getApplicationContext());
      taoFaceFilter.customDetectCreate();
  }
  @Override
  public long customDetectProcess(long data, int width, int height, int rotation, int format, long extra) {
      if(taoFaceFilter != null) {
          return taoFaceFilter.customDetectProcess(data, width, height, rotation, format, extra);
      }
      return 0;
  }
  @Override
  public void customDetectDestroy() {
      if(taoFaceFilter != null) {
          taoFaceFilter.customDetectDestroy();
      }
  }
});

//美颜回调
mAlivcLivePusher.setCustomFilter(new AlivcLivePushCustomFilter() 
{
   @Override
  public void customFilterCreate() {
      taoBeautyFilter = new TaoBeautyFilter();
      taoBeautyFilter.customFilterCreate();
  }
  @Override
  public void customFilterUpdateParam(float fSkinSmooth, float fWhiten, float fWholeFacePink, float fThinFaceHorizontal, float fCheekPink, float fShortenFaceVertical, float fBigEye) {
      if (taoBeautyFilter != null) {
          taoBeautyFilter.customFilterUpdateParam(fSkinSmooth, fWhiten, fWholeFacePink, fThinFaceHorizontal, fCheekPink, fShortenFaceVertical, fBigEye);
      }
  }
  @Override
  public void customFilterSwitch(boolean on)
  {
      if(taoBeautyFilter != null) {
          taoBeautyFilter.customFilterSwitch(on);
      }
  }
  @Override
  public int customFilterProcess(int inputTexture, int textureWidth, int textureHeight, long extra) {
      if (taoBeautyFilter != null) {
          return taoBeautyFilter.customFilterProcess(inputTexture, textureWidth, textureHeight, extra);
      }
      return inputTexture;
  }
  @Override
  public void customFilterDestroy() {
      if (taoBeautyFilter != null) {
          taoBeautyFilter.customFilterDestroy();
      }
      taoBeautyFilter = null;
  }
});
```

通过设置AlivcLivePushConfig中的相关美颜参数，或者调用美颜相关接口都可以控制美颜开关、是否使用高级美颜以及调节美颜参数。

基本设置相关代码。示例代码如下：

```
mAlivcLivePushConfig.setBeautyOn(true);// 开启美颜
mAlivcLivePushConfig.setBeautyLevel(AlivcBeautyLevelEnum.BEAUTY_Professional);//设定为高级美颜
mAlivcLivePushConfig.setBeautyWhite(70);// 美白范围0-100
mAlivcLivePushConfig.setBeautyBuffing(40);// 磨皮范围0-100
mAlivcLivePushConfig.setBeautyRuddy(40);// 红润设置范围0-100
mAlivcLivePushconfig.setBeautyBigEye(30);// 大眼设置范围0-100
mAlivcLivePushConfig.setBeautyThinFace(40);// 瘦脸设置范围0-100
mAlivcLivePushConfig.setBeautyShortenFace(50);// 收下巴设置范围0-100
mAlivcLivePushConfig.setBeautyCheekPink(15);// 腮红设置范围0-100
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
    mAlivcLivePusher.switchCamera();
    ```

2.  设置手电筒

    ```
    mAlivcLivePusher.setFlash(true);
    ```

3.  自动对焦

    ```
    mAlivcLivePusher.setAutoFocus(true);
    ```

4.  手动对焦

    ```
    float x = motionEvent.getX() / mPreviewView.getWidth();
    float y = motionEvent.getY() / mPreviewView.getHeight();
    try{
        mAlivcLivePusher.focusCameraAtAdjustedPoint(x, y, true);
    } catch (IllegalStateException e) {
    }
    ```

5.  设置缩放倍数

    缩放接口为增量设置，每次设置参数都是在当前基础上做增减，缩放倍数范围（1-3）。

    ```
    //当前的缩放倍数+1
    mAlivcLivePusher.setZoom(1.0f);
    ```

6.  获取缩放倍数

    ```
    mAlivcLivePusher.getCurrentZoom();
    ```

7.  获取最大缩放倍数

    ```
    mAlivcLivePusher.getMaxZoom();
    ```

8.  设置曝光度

    ```
    mAlivcLivePusher.setExposure(mExposure);
    ```

9.  获取相机最小曝光度值

    ```
    mAlivcLivePusher.getSupportedMinExposure();
    ```

10. 获取相机最大曝光度值

    ```
    mAlivcLivePusher.getSupportedMaxExposure();
    ```

11. 获取当前曝光度值

    ```
    mAlivcLivePusher.getCurrentExposure();
    ```


## 截图 {#section_sr2_g2j_wgb .section}

截图功能是在推流和预览中可以截取视频生成图片，通过调用接口snapshot来实现，snapshot中有两个参数count和interval， count 表示要截取图片的个数，interval表示每张图片的间隔，如果需要立刻截取当前一张视频图片，只要传递count为1，interval为0即可。截图是异步代理回调操作，截图结果通过传入的AlivcSnapshotListener接口回调出来。示例代码如下：

```
mAlivcLivePusher.snapshot(1, 0, new AlivcSnapshotListener() {
    @Override
    public void onSnapshot(Bitmap bmp) {
      //保存视频流截图bitmap
    }
});
```

## 背景音乐 {#section_tr2_g2j_wgb .section}

该功能提供背景音乐播放、混音、降噪、耳返、静音等功能，通过AlivcLivePusher中的如下接口实现以上功能：

```
//开始播放背景音乐
mAlivcLivePusher.startBGMAsync(mPath);

//停止播放背景音乐
mAlivcLivePusher.stopBGMAsync();

//暂停播放背景音乐
mAlivcLivePusher.pauseBGM();

//恢复播放背景音乐
mAlivcLivePusher.resumeBGM();

//设置是否循环播放背景音乐
mAlivcLivePusher.setBGMLoop();

//设置耳返开关，耳返功能主要应用于KTV场景
//打开耳返后，插入耳机将在耳机中听到主播说话声音，关闭后，插入耳机无法听到人声
//未插入耳机的情况下，耳返不起作用
mAlivcLivePusher.setBGMEarsBack(isOpen);

//设置降噪开关，默认为false不使用
//打开降噪后，将对采集到的声音中非人声的部分进行过滤处理
//可能存在对人声稍微抑制作用，建议让用户自由选择是否开启降噪功能
mAlivcLivePusher.setAudioDenoise(onDenoise);

//设置背景音乐音量
mAlivcLivePusher.setBGMVolume(50);

//设置人声采集音量
mAlivcLivePusher.setCaptureVolume(50);

//设置静音，静音后音乐声音和人声输入都会静音
//要单独设置音乐或人声静音可以通过混音音量设置接口来调整
mAlivcLivePusher.setMute(isMute);
```

**说明：** 该功能只能在开始预览之后才可调用，目前只支持mp3格式音乐文件。

## 自定义音视频流输入 {#section_ur2_g2j_wgb .section}

该功能支持将外部的音视频源输入进行推流，比如推送一个音视频文件、第三方设备采集的音视频数据等。具体功能使用介绍如下：

1.  全局配置自定义音视频输入

    在推流配置AlivcLivePushConfig中配置使用自定义音视频输入，也可包括与自定义输入流相关的其他配置，具体配置如下：

    ```
    //是否使用外部音视频输入，并设置相关音视频输入格式
    //AlivcImageFormat输入的视频图像格式
    //AlivcSoundFormat输入的音频帧格式
    mAlivcLivePushConfig.setExternMainStream(true, AlivcImageFormat.IMAGE_FORMAT_YUVNV12, AlivcSoundFormat.SOUND_FORMAT_S16);
    
    //设置输入视频分辨率，默认值 540P
    mAlivcLivePushConfig.setResolution(mAlivcResolutionEnum);
    
    //设置音频采样率，默认值 32000HZ
    mAlivcLivePushConfig.setAudioSamepleRate(mAudioSampleRate);
    
    //设置音频采集声道，默认2个
    mAlivcLivePushConfig.setAudioChannels(mAudioChannels);
    ```

    其中，视频图像格式目前支持：

    -   IMAGE\_FORMAT\_BGRA
    -   IMAGE\_FORMAT\_RGBA
    -   IMAGE\_FORMAT\_YUVNV12
    -   IMAGE\_FORMAT\_YUVNV21
    -   IMAGE\_FORMAT\_YUV420P
    音频帧格式目前只支持PCM 格式，且为SOUND\_FORMAT\_S16。

2.  插入自定义音视频数据
    -   插入视频数据

        ```
        /**
         * 输入自定义视频流
         *
         * @param data      视频图像byte array
         * @param width     视频图像宽度
         * @param height    视频图像高度
         * @param pts       视频图像pts（μs）
         * @param rotation  视频图像旋转角度
         * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
         */
        mAlivcLivePusher.inputStreamVideoData(mBuffer, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0);
        
        /**
         * 输入自定义视频流
         *
         * @param dataptr   视频图像native内存指针
         * @param width     视频图像宽度
         * @param height    视频图像高度
         * @param pts       视频图像pts（μs）
         * @param rotation  视频图像旋转角度
         * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
         */
        mAlivcLivePusher.inputStreamVideoPtr(mDataptr, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0);
        
        /**
         * 输入自定义视频流
         *
         * @param textureId 视频纹理id
         * @param width     视频图像宽度
         * @param height    视频图像高度
         * @param pts       视频图像pts（us）
         * @param rotation  视频图像旋转角度
         * @param extra     暂无作用
         * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
         */
        mAlivcLivePusher.inputStreamTexture(mTextureId, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0, 0);
        ```

    -   插入音频数据

        ```
        /**
        * 输入自定义音频数据
        *
        * @param data 音频数据 byte array
        * @param size 音频数据size
        * @param pts  音频数据pts(μs)
        * 注意：此接口不控制时序，需要调用方控制输入音频帧的时序
        */
        mAlivcLivePusher.inputStreamAudioData(mBuffer, 2048, System.nanoTime()/1000);
        
        /**
        * 输入自定义音频数据
        *
        * @param dataPtr  音频数据native内存指针
        * @param size     音频数据size
        * @param pts      音频数据pts(μs)
        * 注意：此接口不控制时序，需要调用方控制输入音频帧的时序
        */
        mAlivcLivePusher.inputStreamAudioPtr(mDatePrt, 2048, System.nanoTime()/1000);
        ```


## 混流功能 {#section_yr2_g2j_wgb .section}

混流顾名思义就是把一路或多路音视频流混合成单路流推到流媒体服务器。具体使用介绍如下：

1.  添加混流

    添加混流包括混流格式设置、旋转角度设置、混流位置、音频采样率设置等，添加后获取到的返回值用于标示这一路混流，假如返回-1则混流失败，具体代码调用示例如下：

    ```
    /**
     * 添加一路视频混流，并设置狂高，设置混在主流的相对位置
     *
     * @param format    当前输入视频图像格式
     * @param width     当前输入视频图像宽度
     * @param height    当前输入视频图像高度
     * @param rotation  当前输入视频图像旋转角度
     * @param displayX  当前混流起始位置X
     * @param displayY  当前混流起始位置Y
     * @param displayW  当前混流显示区域Width
     * @param displayH  当前混流显示区域Height
     * @return 返回当前视频混流videoHandler，用于标示这一路混流，该值用于改变、移除混流等
     */
    mAlivcLivePusher.addMixVideo(AlivcImageFormat.IMAGE_FORMAT_RGBA, mWidth, mHeight, 0, mRect.mStartX, mRect.mStartY, mRect.mWidth, mRect.mHeight)；
    
    /**
     * 添加一路音频混流，并设置相应音频格式和采样率
     *
     * @param channels    当前音频流声道数
     * @param format      当前音频流格式
     * @param audioSample 当前音频流采样率
     * @return 返回当前音频混流audioHandler，用于标示这一路音频流，该值用于移除混流
     */
    mAlivcLivePusher.addMixAudio(mNumChannels, AlivcSoundFormat.SOUND_FORMAT_S16, mNumSamples * 100);
    ```

2.  更新混流位置

    ```
    /**
     * 更新视频混流位置
     *
     * @param videoHandler 已有混流的videoHandler值
     * @param displayX  当前混流起始位置X
     * @param displayY  当前混流起始位置Y
     * @param displayW  当前混流显示区域Width
     * @param displayH  当前混流显示区域Height
     * @return status 返回当前混流状态
     */
    mAlivcLivePusher.mixStreamChangePosition(mMixVideoHandler, mRect.mStartX, mRect.mStartY, mRect.mWidth, mRect.mHeight);
    ```

3.  输入混流数据

    确认添加好混流后，将已获得的混流返回值用于实际音视频流数据输入，具体示例如下：

    ```
    /**
     * 输入视频混流数据
     *
     * @param videoHandler  已有混流的videoHandler值
     * @param dataptr       视频图像native内存指针
     * @param width         视频图像宽度
     * @param height        视频图像高度
     * @param size          视频图像size
     * @param pts           视频图像pts（μs）
     * @param rotation      视频图像旋转角度
     * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
     */
    mAlivcLivePusher.inputMixVideoPtr(mMixVideoHandler, mDataPtr, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0);
    
    /**
     * 输入视频混流数据
     *
     * @param videoHandler  已有混流的videoHandler值
     * @param data          视频图像byte array
     * @param width         视频图像宽度
     * @param height        视频图像高度
     * @param size          视频图像size
     * @param pts           视频图像pts（μs）
     * @param rotation      视频图像旋转角度
     * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
     */
    mAlivcLivePusher.inputMixVideoData(mMixVideoHandler, mBuffer, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0);
    
    /**
     * 输入视频混流数据
     *
     * @param videoHandler  已有混流的videoHandler值 
     * @param textureId     视频图像纹理id
     * @param width         视频图像宽度
     * @param height        视频图像高度
     * @param size          视频图像size
     * @param pts           视频图像pts（μs）
     * @param rotation      视频图像旋转角度
     * 注意：此接口不控制时序，需要调用方控制输入视频帧的时序
     */
    mAlivcLivePusher.inputMixTexture(mMixVideoHandler, mTextureId, 720, 1280, 1280*720*3/2, System.nanoTime()/1000, 0);
    
    /**
     * 输入音频混流数据
     *
     * @param audioHandler  已有混流的audioHandler值
     * @param dataPtr       音频数据native内存指针
     * @param size          音频数据size
     * @param pts           音频数据pts(μs)
     * 注意：此接口不控制时序，需要调用方控制输入音频帧的时序
     */
    mAlivcPusher.inputMixAudioPtr(mMixAudioHandler, mDataPtr, 2048, System.nanoTime()/1000);
    
    /**
     * 输入音频混流数据
     *
     * @param audioHandler  已有混流的audioHandler值
     * @param data          音频数据 byte array
     * @param size          音频数据size
     * @param pts           音频数据pts(μs)
     * 注意：此接口不控制时序，需要调用方控制输入音频帧的时序
     */
    mAlivcPusher.inputMixAudioData(mMixAudioHandler, mBuffer, 2048, System.nanoTime()/1000);
    ```

4.  删除混流

    清理已有混流，包括移除音频和视频，具体示例如下：

    ```
    /**
     * 移除已添加的一路视频混流
     *
     * @param handler 已有混流的videoHandler值
     */
    mAlivcLivePusher.removeMixVideo(mMixVideoHandler);
    
    /**
     * 移除已添加的一路音频混流
     *
     * @param handler 已有混流的audioHandler值
     */
    mAlivcLivePusher.removeMixAudio(mMixAudioHandler);
    ```


## 直播答题 {#section_cs2_g2j_wgb .section}

该功能可以通过在直播流里面插入SEI信息并发送后阿里云播放器SDK可收到此SEI消息，解析后做具体展示。另外为了保证SEI不被丢帧，需设置重复次数，如设置100，则在接下去的100帧均插入此SEI消息，这个过程中播放器会对相同的SEI进行去重处理。示例代码如下：

```
/*
 * 推流端发送自定义消息
 *
 * @param info        需要插入流的SEI消息体，建议是json格式
 * @param repeat      发送的帧数
 * @param delay       延时多少毫秒发送
 * @param isKeyFrame  是否只发送关键帧
 */
mAlivcLivePusher.sendMessage(mQuestionInfo, 100, 0, false)；
```

**说明：** 只有在推流状态下，才能调用此接口。

## 录屏直播 {#section_ds2_g2j_wgb .section}

录制是把当前手机屏幕画面作为推流数据源，同时可叠加摄像头预览以及添加自定义混流数据。具体使用如下：

1.  开启录屏

    录屏采用MediaProjection，需要用户请求权限，将权限请求返回的数据通过此接口设置，即开启录屏模式。录屏情况下，默认不开启摄像头。

    ```
    //在config中设置权限请求的返回数据
    if (resultCode == Activity.RESULT_OK) {
        mAlivcLivePushConfig.setMediaProjectionPermissionResultData(data);
    }
    ```

2.  设置录屏模式

    录屏主要有三种模式：

    -   录屏时不开启摄像头，即只需开启录屏模式在config中设置权限请求的返回数据即可。
    -   录屏时开启摄像头，主播端有摄像头预览，同样观众端也有摄像头画面（通过录屏录制进去）。

        ```
        //在config中设置权限请求的返回数据
        if (resultCode == Activity.RESULT_OK) {
            mAlivcLivePushConfig.setMediaProjectionPermissionResultData(data);
        }
        
        //调用StartCamera传入surfaceView
        if(mLivePusher != null ) {
            mAlivcLivePusher.startCamera(mCameraPreview);
        }
        ```

    -   录屏时开启摄像头，主播端无摄像头预览，观众端有摄像头画面叠加。

        ```
        //在config中设置权限请求的返回数据
        if (resultCode == Activity.RESULT_OK) {
            mAlivcLivePushConfig.setMediaProjectionPermissionResultData(data);
        }
        
        //调用StartCamera传入surfaceView
        if(mLivePusher != null ) {
            mAlivcLivePusher.startCamera(mCameraPreview);
        }
        
        //调用startCameraMix传入观众端摄像头画面显示位置
        if(mAlivcLivePusher != null && mMixOn) {
            mAlivcLivePusher.startCameraMix(0.6f,0.08f, 0.3f,0.3f);
        }
        ```

3.  录屏其他设置

    录屏相关其他设置示例如下：

    ```
    //开启和关闭设想头预览
    //说明：
    // 录屏模式下摄像头预览surfaceView的长宽建议设置成1：1，这样在屏幕旋转时无需调整surfaceview；
    // 若设置的长宽不为1：1，则需要在屏幕旋转时，调整surfaceView的比例后，stopCamera再startCamera；
    // 如果主播端不需要预览，则surfaceview填为null；
    
    //开启摄像头预览
    mAlivcLivePusher.startCamera(mSurfaceView);
    
    //关闭摄像头预览
    mAlivcLivePusher.stopCamera();
    
    
    //摄像头混流
    //开启摄像头混流
    mAlivcLivePusher.startCameraMix(x, y, w, h);
    
    //停止摄像头混流
    mAlivcLivePusher.stopCameraMix();
    
    
    //设置屏幕旋转
    //说明：在横竖屏切换时，需要在应用层监听OrientationEventListener事件，并将旋转角度设置到此接口
    
    //设置感应的屏幕旋转角度，支持横屏/竖屏录制
    mAlivcLivePusher.setScreenOrientation(0);
    
    
    //开关隐私保护
    //说明：当主播在录屏时要进行密码输入等操作时，主播可以开启隐私保护功能，结束操作后可以关闭隐私
    
    //开启隐私保护
    mAlivcLivePusher.pauseScreenCapture();
    
    //关闭隐私保护
    mAlivcLivePusher.resumeScreenCapture();
    ```


**说明：** 录屏只支持5.0及以上的系统。

## 接口回调处理 {#section_b1t_y3j_wgb .section}

1.  错误回调处理

    当收到`AlivcLivePushErrorListener`时：

    -   当出现onSystemError系统级错误时，您需要退出直播。
    -   当出现onSDKError错误（SDK错误）时，有两种处理方式，选择其一即可：销毁当前直播重新创建、调用`restartPush/restartPushAsync`重启`AlivcLivePusher`。
    -   您需要特别处理APP没有麦克风权限和没有摄像头权限的回调。
        -   APP没有麦克风权限错误码为：ALIVC\_PUSHER\_ERROR\_SDK\_CAPTURE\_CAMERA\_OPEN\_FAILED
        -   APP没有摄像头权限错误码为：ALIVC\_PUSHER\_ERROR\_SDK\_CAPTURE\_MIC\_OPEN\_FAILED
    AlivcLivePushErrorListener接口回调示例代码如下：

    ```
    //系统错误回调
    @Override
    void onSystemError(AlivcLivePusher livePusher, AlivcLivePushError error);
    
    //SDK错误回调
    @Override
    void onSDKError(AlivcLivePusher livePusher, AlivcLivePushError error);
    ```

2.  网络监听回调处理

    当您收到AlivcLivePushNetworkListener时：

    -   网速慢时，回调`onNetworkPoor`，当您收到此回调说明当前网络对于推流的支撑度不足，此时推流仍在继续并没有中断。网络恢复时，回调`onNetworkRecovery`。您可以在此处理自己的业务逻辑，比如UI提醒用户。
    -   网络出现相关错误时，回调`onConnectFail`、`onReconnectError` 或`onSendDataTimeout`。有两种处理方式，您只需选择其一：销毁当前推流重新创建或调用 `reconnectAsync` 进行重连，建议您重连之前先进行网络检测和推流地址检测。
    -   SDK内部每次自动重连或者开发者主动调用 `reconnectAsync` 重连接口的情况下，会回调 `onReconnectStart`重连开始。每次重连都会对 RTMP 进行重连链接。
    -   推流地址鉴权即将过期会回调`onPushURLAuthenticationOverdue`。如果您的推流开启了推流鉴权功能\(推流URL中带有auth\_key\)。我们会对推流URL做出校验。在推流URL过期前约1min，您会收到此回调，实现该回调后，您需要回传一个新的推流URL。以此保证不会因为推流地址过期而导致推流中断。
    AlivcLivePushNetworkListener接口回调示例代码如下：

    ```
    //当前网络质量差
    @Override
    void onNetworkPoor(AlivcLivePusher pusher);
    
    //网络恢复
    @Override
    void onNetworkRecovery(AlivcLivePusher pusher);
    
    //开始重连
    @Override
    void onReconnectStart(AlivcLivePusher pusher);
    
    //连接失败
    @Override
    void onConnectionLost(AlivcLivePusher pusher);
    
    //重连失败
    @Override
    void onReconnectFail(AlivcLivePusher pusher);
    
    //重连成功
    @Override
    void onReconnectSucceed(AlivcLivePusher pusher);
    
    //发送数据超时
    @Override
    void onSendDataTimeout(AlivcLivePusher pusher);
    
    //连接失败
    @Override
    void onConnectFail(AlivcLivePusher pusher);
    
    //推流Url鉴权过期
    @Override
    String onPushURLAuthenticationOverdue(AlivcLivePusher pusher) {
        return "新的推流地址 rtmp://";
    }
    
    //发送SEI消息
    @Override
    void onSendMessage(AlivcLivePusher pusher);
    
    //推流过程丢包回调
    @Override
    void onPacketsLost(AlivcLivePusher pusher);
    ```

3.  背景音乐播放回调处理

    当您收到AlivcLivePushBGMListener背景音乐错误回调时：

    -   背景音乐开启失败时会回调`onOpenFailed`，检查背景音乐开始播放接口所传入的音乐路径与该音乐文件是否正确，可调用 `startBGMAsync`重新播放。
    -   背景音乐播放超时会回调`onDownloadTimeout`，多出现于播放网络URL的背景音乐，提示主播检查当前网络状态，可调用 `startBGMAsync`重新播放。
    AlivcLivePushBGMListener接口回调示例代码如下：

    ```
    //播放开始事件
    @Override
    void onStarted();
    
    //播放停止事件
    @Override
    void onStoped();
    
    //播放暂停事件
    @Override
    void onPaused();
    
    //播放恢复事件
    @Override
    void onResumed();
    
    //播放进度事件
    @Override
    void onProgress(long progress, long duration);
    
    //播放结束通知
    @Override
    void onCompleted();
    
    //播放器超时事件
    @Override
    void onDownloadTimeout();
    
    //流无效通知
    @Override
    void onOpenFailed();
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
    -   当app退后台或锁屏时，您可调用 AlivcLivePusher 的 pause\(\)/resume\(\)接口暂停/恢复推流。
    -   对于非系统的音视频通话，sdk会采集声音并推送出去，您可以根据业务需求在退后台或锁屏时调用静音接口mAlivcLivePusher.setMute\(true/false\)来决定后台时是否采集音频。

## 结束销毁推流 {#section_ys2_g2j_wgb .section}

当使用推流结束时需要调用推流相关的销毁接口，清理当前使用资源。

-   正常推流模式下的具体示例

    ```
    if(mAlivcLivePusher != null) {
      //停止推流
      try {
        mAlivcLivePusher.stopPush();
      } catch (Exception e) {
      }
      
      //停止预览
      try {
        mAlivcLivePusher.stopPreview();
      } catch (Exception e) {
      }
      
      //释放推流
      mAlivcLivePusher.destroy();
      mAlivcLivePusher.setLivePushInfoListener(null);
      mAlivcLivePusher = null;
    }
    ```

-   录屏推流模式下的具体示例

    ```
    if (mAlivcLivePusher != null) {
      //关闭摄像头预览
      try {
        mAlivcLivePusher.stopCamera();
      } catch (Exception e) {
      }
      
      //停止摄像头混流
      try {
        mAlivcLivePusher.stopCameraMix();
      } catch (Exception e) {
      }
      
      //停止推流
      try {
        mAlivcLivePusher.stopPush();
      } catch (Exception e) {
      }
      
      //停止预览
      try {
        mAlivcLivePusher.stopPreview();
      } catch (Exception e) {
      }
      
      //释放推流
      mAlivcLivePusher.destroy();
      mAlivcLivePusher.setLivePushInfoListener(null);
      mAlivcLivePusher = null;
    }
    ```


## 注意事项 {#section_zs2_g2j_wgb .section}

-   混淆规则说明

    检查混淆，确认已将SDK相关包名加入了不混淆名单中。

    ```
    -keep class com.alibaba.livecloud.** { *;}
    -keep class com.alivc.** { *;}
    ```

-   接口调用
    -   同步异步接口都可以正常调用，尽量使用异步接口调用，可以避免对主线程的资源消耗。
    -   SDK接口都会在发生错误或者调用顺序不对时 thorws 出异常，调用时注意添加try catch 处理，否则会造成程序的crash。
    -   接口调用顺序，如下图所示：

        ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/40382/155106682739351_zh-CN.png)

-   关于包大小
    -   SDK大小：arm64-v8a：7.6M、armv7a：5.2M
    -   集成SDK后apk会增加约5M
-   功能限制说明
    -   您只能在推流之前设置横竖屏模式，不支持在直播的过程中实时切换。
    -   在推流设定为横屏模式时，需设定界面为不允许自动旋转。
    -   在硬编模式下，考虑编码器兼容问题分辨率会使用16的倍数，如设定为540p，则输出的分辨率为544\*960，在设置播放器视图大小时需按输出分辨率等比缩放，避免黑边等问题。
-   关于历史版本升级说明
    -   推流SDK V1.3升级至 \[V3.0.0-3.3.3\]、连麦SDK升级至推流 \[V3.0.0-3.3.3\]，请下载 [升级说明文档](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/45265/cn_zh/1511187112732/updateDoc_android_20171120.zip?spm=a2c4g.11186623.2.37.6284161cvDZvBu&file=updateDoc_android_20171120.zip)。
    -   从V3.3.4版开始不支持推流V1.3版兼容，升级时建议您重新接入最新版SDK。
    -   推流SDK升级至V3.1.0，如果您未集成阿里云播放器SDK，需集成该SDK（已包含推流SDK下载包里面）。
    -   推流SDK升级至V3.2.0+，提供包含阿里云播放器的版本和不包含阿里云播放器两个版本。如果您需要背景音乐功能必须集成播放器，否则可以不使用播放器SDK。


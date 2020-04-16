# 关于Demo {#concept_iyh_4vx_pfb .concept}

本文介绍iOS推流SDKDemo相关内容。

## Demo架构 {#section_n24_pvx_pfb .section}

Demo使用 MVC 架构。目录结构如下：

![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/20918/155107313021058_zh-CN.png)

**各个Controller对应如下**

-   Others

    -   AlivcNavigationController – Navigation基类

    -   AlivcRootViewController – 首页列表

    -   AlivcCopyrightInfoViewController – 版权信息页

    -   AlivcQRCodeViewController – 二维码扫描页

-   AlivcLivePusher – 推流SDKv3.0

    -   AlivcLivePushConfigViewController – 推流参数设置页

    -   AlivcLivePusherViewController – 推流页

-   AlivcLiveSessoin – 推流SDKv1.3

    -   AlivcLiveConfigViewController – 推流参数设置页

    -   AlivcLiveViewController – 推流页


## Demo使用 {#section_gkm_tvx_pfb .section}

1.  打开SDK Demo工程 `AlivcLivePusherDemo.xcodeproj`。
2.  配置真机调试证书，选择调试真机。
3.  修改 `PrefixHeader.pch` 中的宏 `AlivcTextPushURL` 为您的测试推流地址。

    **说明：** 请务必修改推流地址为您的测试推流地址，避免出现多人使用同一推流地址造成推流异常的情况。或者在Demo中通过扫描二维码修改推流地址。

4.  运行，提示Buidling Success。即可在真机环境测试Demo。

## 播放地址获取 {#section_kg2_wvx_pfb .section}

一般情况下，rtmp推流地址格式如下：

`rtmp://push-#YourCompanyDomainName#/#YourAPPName#/#YourstreamName#`

对应的播放地址如下：

`rtmp://pull-#YourCompanyDomainName#/#YourAPPName#/#YourstreamName#`

## Demo描述 {#section_rwk_dwx_pfb .section}

-   列表页，列表页可以跳转到推流SDKv3.0版本Demo页和推流SDKv1.3版本Demo页。

-   推流SDKv3.0版本为最新SDK版本，主要使用 `AlivcLivePusher` 以及接口。

-   推流SDKv1.3版本为老接口版本，主要使用 `AlivcLiveSession` 以及相关接口。

    ![](http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/20918/155107313021060_zh-CN.png)



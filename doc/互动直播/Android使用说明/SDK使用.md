# SDK使用 {#concept_xsv_qwb_pfb .concept}

本文详细说明如何使用Android互动直播SDK API 和通知回调实现互动直播的功能。

## 互动直播主要接口类列表 {#section_zr5_rpf_2gb .section}

|类|说明|
|--|--|
|AlivcInteractiveLiveBase|互动直播全局设置类，所有方法都为静态方法，主要功能包括SDK版本号获取、Debug日志控制和业务信息设置|
|AlivcInteractiveLiveRoomConfig|互动直播初始设置，提供互动直播的初始化参数|
|AlivcInteractiveLiveRoom|互动直播功能类|
|IAlivcAuthListener|鉴权回调|
|IAlivcLiveRoomNotifyListener|直播间通知回调|
|IAlivcInteractiveNotifyListener|互动通知回调|
|IAlivcPusherNotifyListener|推流通知回调|
|IAlivcPlayerNotifyListener|播放器通知回调|
|IAlivcNetworkListener|网络通知回调|
|IAlivcErrorListener|错误通知回调|

## 初始化 {#section_p51_pqf_2gb .section}

**说明：** 在SDK 初始化之前，APP 必须保证已经开通互动直播服务，并申请到有效的App ID和STS Token。

请您按照以下步骤完成SDK初始化：

1.  设置Debug日志。

    在开发阶段，您可以通过以下接口打开SDK debug日志，产品上线时可以关掉日志。

    ```
    //设置日志打印级别
    AlivcInteractiveLiveBase.setLogLevel(AlivcLogLevel.AlivcLogLevelDebug);
    AlivcInteractiveLiveBase.setLogEnable(true);
    ```

2.  设置业务相关信息。

    App业务相关可以通过以下方式设置SDK，便于SDK做管理，建议App集成时设置以下信息：阿里云appID、当前用户信息、当前用户角色。

    ```
    //设置用户申请的appid
    AlivcInteractiveLiveBase.setAppId(AlivcConstants.getAppId());
    //设置用户信息
    AlivcInteractiveLiveBase.setAlivcUserInfo(mAlivcUserInfo.userId);
    //设置用户角色
    AlivcInteractiveLiveBase.setAlivcLiveRole(mAlivcLiveRole);
    ```

3.  互动直播初始设置。

    AlivcInteractiveLiveRoomConfig类用于互动直播的初始化设置，主要设置参数有：

    |参数|说明|默认|
    |:-|:-|:-|
    |region|直播服务区域（上海、新加坡、自定义）|上海|
    |imHost|自定义区域下IM服务器地址|无|
    |ilvbHost|自定义区域下互动直播服务器地址|无|
    |beautyOn|美颜开关|开|
    |cameraPosition|相机位置|前置|
    |resolution|推流分辨率|540P|
    |pauseImg|推流退后台图片url|无|

    -   初始化

        ```
        mAlivcILiveRoom.init(mContext, AlivcConstants.getAppId(), mAlivcLiveRoomConfig);
        ```

    -   region设置

        阿里云的互动直播目前支持的线上环境区域包括上海、新加坡，需要根据业务范围选择对应的区域，默认为上海区域。

        ```
        mAlivcILiveRoom.setAlivcLiveRegion(AlivcLiveRegion.REGION_SHANGHAI);
        ```

    -   美颜设置（主播端设置）

        ```
        此参数设置主播默认是否开始美颜，默认为开美颜。
        ```

        ```
        mAlivcILiveRoom.setBeautyOn(true);
        ```

    -   相机位置（主播端设置）

        此参数设置主播默认使用手机的摄像头位置，默认为前置。

        ```
        mAlivcILiveRoom.switchCamera();
        ```

    -   设置推流或者播放画面的显示模式

        ```
        //设置推流的显示模式
        //AlivcLiveScalingModeAspectFit
        //AlivcLiveScalingModeAspectFitWithCropping
        mAlivcILiveRoom.setScalingMode(mScalingMode);
        ```

    -   推流分辨率设置（主播端设置）

        ```
        mAlivcILiveRoom.changePushResolutionMode(AlivcResolutionMode.RESOLUTION_540P);
        ```

        SDK支持的主播推流分辨率和参数如下：

        |分辨率定义|分辨率|码率范围kbps|帧率|
        |:----|:--|:-------|:-|
        |AlivcResolutionMode.RESOLUTION\_180P|192x320|120~550|20|
        |AlivcResolutionMode.RESOLUTION\_240P|240x320|180~750|20|
        |AlivcResolutionMode.RESOLUTION\_360P|368x640|300~1000|20|
        |AlivcResolutionMode.RESOLUTION\_480P|480x640|300~1200|20|
        |AlivcResolutionMode.RESOLUTION\_540P|544x960|600~1400|20|
        |AlivcResolutionMode.RESOLUTION\_720P|720x1280|600~2000|20|

    -   推流退后台图片设置（主播端设置）

        直播推流中，当前APP 退后台时，视频采集被中断，此时可以设置一张退后台图片提示主播画面被中断，此参数为App资源文件中能够访问到的图片路径，且必须为png格式。如果不设置，那么在主播退后台的时候，观众端观看的画面为主播退后台前最后一帧视频。

        ```
        mAlivcLiveRoomConfig.setPausePushImage(Environment.getExternalStorageDirectory().getPath() + File.separator + "alivc_resource/background_push.png");
        ```

4.  创建互动直播间对象。

    ```
    //创建AlivcInteractiveLiveRoom对象
    mAlivcILiveRoom.init(mContext, AlivcConstants.getAppId(), mAlivcLiveRoomConfig);
    ```

5.  设置代理回调。

    ```
    mAlivcILiveRoom.setAuthListener(mAlivcAuthListener); // 设置鉴权通知代理
    if (mAlivcLiveRole == AlivcLiveRole.ROLE_HOST) {
        mAlivcILiveRoom.setPusherNotifyListener(mPushListener); // 主播端需要设置推流的代理
    } else {
        mAlivcILiveRoom.setPlayerNotifyListener(mPlayerListener); // 观众端需要设置播放的代理    
    }
    mAlivcILiveRoom.setNetworkListener(mNetworkListener); // 设置网络通知代理
    mAlivcILiveRoom.setInteractiveNotifyListener(mInteractiveListener); // 设置互动通知代理
    mAlivcILiveRoom.setLiveRoomNotifyListener(mLiveRoomNotifyListener); // 设置房间通知代理
    mAlivcILiveRoom.setErrorListener(mAlivcLiveRoomErrorListener); // 设置错误通知代理
    ```


## 鉴权操作 {#section_y2b_wvf_2gb .section}

鉴权操作包括设置STS Token、STS Token有效期管理以及注销操作，请您按照以下步骤完成鉴权操作。

1.  登录

    SDK初始化之后必须调用登录接口传入STS Token 给SDK， STS Token 为App 通过阿里云RAM 服务申请的鉴权Token。SDK 内部执行所有互动直播的功能都会依赖STS Token。

    ```
    mAlivcILiveRoom.login(AlivcStsManager.getInstance().getStsToken());
    ```

    **说明：** 调用登录接口时，App必须已经通过阿里云RAM服务器申请到有效的STS Token，并通过登录接口设置给SDK，传入无效或者已经过期的STS Token 会导致进房间失败。

2.  管理STS Token 有效期

    当App 设置有效的STS Token 给SDK后，SDK会自动管理STS Token的有效期， 并在有效期即将过期和已经过期时都会通过代理IAlivcAuthListener回调给App。

    SDK 在STS Token 过期时间前60秒时会上报一次即将过期的通知。

    ```
    @Override
    public void onStsTokenCloseExpire(Object iRoom, AlivcSts sts) {
        //token 即将过期，申请新的token
    }
    ```

    SDK 在STS Token 已经过期时会每隔10秒上报一次已经过期的通知。

    ```
    @Override
    public void onSTSTokenExpired(Object iRoom, AlivcSts sts) {
        //token 已经过期，申请新的token
    }
    ```

    **说明：** App在收到STS Token 即将过期或者已经过期的通知后，必须要申请新的有效的STS Token， 并通过接口refreshSts重新设置给SDK。

    ```
    mAlivcILiveRoom.refreshSts(sts);
    ```

3.  注销

    注销操作是在退出房间之后，销毁SDK之前调用logout，注销操作会清空SDK内所有的STS Token，注销之后所有的互动直播功能都不可用，除非再次调用login接口设置新的STS Token 给SDK。

    ```
    mAlivcILiveRoom.logout();
    ```


## 进入直播间 {#section_l21_lwf_2gb .section}

用户进入直播根据角色不同，操作步骤也有所区别，分为主播和观众两种。

-   主播进入直播间

    主播因为需要进行直播，所以进入直播间之前需要进行预览以及调节分辨率等操作。

    1.  主播预览

        设置预览AlivcSurfaceView和调用startPreview后，SDK内部会自动打开相机采集，并将采集画面渲染到预览 AlivcSurfaceView上。

        ```
        mAlivcILiveRoom.setLocalView(this.mAlivcLiveRoomView); // 主播设置本地预览UIView对象
        // 开始预览
        mAlivcILiveRoom.startPreview(new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
            @Override
            public void onSuccess(AlivcCommonSuccess iPusher) {
                //预览成功后的相关操作处理
            }
            @Override
            public void onFailure(AlivcCommonError error) {
                //预览失败后的相关操作处理
            }
        }
        ```

    2.  主播设置推流分辨率

        主播在预览阶段可以设置直播的分辨率。

        ```
        mAlivcILiveRoom.changePushResolutionMode(AlivcResolutionMode.RESOLUTION_540P); // 设置推流分辨率为540P
        ```

        ```
        <span data-type="color" style="color:#262626"> </span>
        ```

        **说明：** 在主播进房间成功之后，不允许切换推流分辨率。

    3.  主播进房间

        进房间接口需要传入有效的房间ID、主播信息、角色信息。

        ```
        mAlivcILiveRoom.enter(mRoomId, mUserInfo.getUserId(), mUserInfo.getUserDesp(), mAlivcLiveRole,
                                new IAlivcCallback<AlivcRoomInfo, AlivcCommonError>() {
                @Override
                public void onSuccess(AlivcRoomInfo roomResult) {
                    //处理进入直播间成功的操作
                    HandlerUtils.post(new Runnable() {
                        //最好使用Handler包装下，避免在回调同步处理中的直播间状态错误问题
                    });
                }
                @Override
                public void onFailure(AlivcCommonError commonError) {
                    //处理进入直播间错误的操作，根据错误码查看具体错误原因
                }
        }
        ```

        主播进房间成功后会返回AlivcLiveRoomInfo对象，AlivcLiveRoomInfo中包含该直播间的状态信息、推流和播放地址等信息，App可以获取这些信息做相关的处理，详见AlivcLiveRoomInfo定义。

        主播进房间成功后，服务端会通过IAlivcLiveRoomNotifyListener代理回调onNotifyUpMic通知给所有该房间内观众端，表示直播开始。

        ```
        @Override
        public void onNotifyUpMic(Object iRoom, String userId);
             //主播开始直播通知
        }
        ```

-   观众进入直播间
    1.  进入房间

        观众进入直播间，直接调用进房间接口，需要传入有效的房间ID、主播信息、角色信息。

        ```
        mAlivcILiveRoom.enter(mRoomId, mUserInfo.getUserId(), mUserInfo.getUserDesp(), mAlivcLiveRole,
                                new IAlivcCallback<AlivcRoomInfo, AlivcCommonError>() {
                @Override
                public void onSuccess(AlivcRoomInfo roomResult) {
                    //处理进入直播间成功的操作
                    HandlerUtils.post(new Runnable() {
                        //最好使用Handler包装下，避免在回调同步处理中的直播间状态错误问题
                    });
                }
                @Override
                public void onFailure(AlivcCommonError commonError) {
                    //处理进入直播间错误的操作，根据错误码查看具体错误原因
                }
        }
        ```

        观众进房间成功后会返回AlivcLiveRoomInfo对象，AlivcLiveRoomInfo中包含该直播间的状态信息、推流和播放地址等信息，App可以获取这些信息做相关的处理，详见AlivcLiveRoomInfo定义。

    2.  检查房间状态

        进入房间成功后，根据enter进入房间成功后得到的AlivcLiveRoomInfo信息来检查房间是否在直播。

        ```
        mAlivcILiveRoom.enter(mRoomId, mUserInfo.getUserId(), mUserInfo.getUserDesp(), mAlivcLiveRole,
                                new IAlivcCallback<AlivcRoomInfo, AlivcCommonError>() {
                @Override
                public void onSuccess(AlivcRoomInfo roomResult) {
                    //处理进入直播间成功的操作
                    HandlerUtils.post(new Runnable() {
                        //检查当前是否在直播
                        if (alivcEnterRoomResult.roomStatus == AlivcLiveRoomStatus.ROOM_ENTERED.getStatus()) {
                        }
                    });
                }
                @Override
                public void onFailure(AlivcCommonError commonError) {
                    //处理进入直播间错误的操作，根据错误码查看具体错误原因
                }
        }
        ```

    3.  设置主播播放窗口view

        根据AlivcLiveRoomInfo中的主播uid，设置主播直播视频的显示view，如果房间状态是直播中，设置view之后SDK会自动拉流播放。

        ```
        mAlivcILiveRoom.enter(mRoomId, mUserInfo.getUserId(), mUserInfo.getUserDesp(), mAlivcLiveRole,
                                new IAlivcCallback<AlivcRoomInfo, AlivcCommonError>() {
                @Override
                public void onSuccess(AlivcRoomInfo roomResult) {
                    //处理进入直播间成功的操作
                    HandlerUtils.post(new Runnable() {
                        //检查当前是否在直播
                        if (alivcEnterRoomResult.roomStatus == AlivcLiveRoomStatus.ROOM_ENTERED.getStatus()) {
                            //根据主播uid设置主播视频播放view
                            mAlivcILiveRoom.setRemoteView(roomResult.mStreamerId, mAlivcLiveRoomView);                                  
                        }
                    });
                }
                @Override
                public void onFailure(AlivcCommonError commonError) {
                    //处理进入直播间错误的操作，根据错误码查看具体错误原因
                }
        }
        ```

        **说明：** 不管直播间是否已经直播，必须执行该步骤，因为直播拉流播放都是显示到此view上。


## 退出直播间 {#section_lbc_nxf_2gb .section}

退出直播间调用quit接口。

```
mAlivcILiveRoom.quit(new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
    @Override
    public void onSuccess(AlivcCommonSuccess alivcQuitRoomResult) {
    }
    @Override
    public void onFailure(AlivcCommonError alivcCommonError) {
    }
});
```

主播在退出直播间时，会停止直播，此时观众端会收到主播下麦的通知，表示直播已经结束。

主播退出房间后，服务端会通过IAlivcLiveRoomNotifyListener代理回调onNotifyDownMic通知给所有该房间内观众端，表示直播结束。

```
@Override
public void onNotifyDownMic(Object iRoom, String userId) {
    //主播结束直播通知
}
```

## 互动 {#section_jzh_rxf_2gb .section}

直播间互动分为点赞、聊天两种。

-   发送点赞

    点赞调用接口sendLike，参数count表示点赞数，由于避免用户在短时间内疯狂点赞导致服务端接口的频繁调用，建议App在实现点赞功能时加以限制，统计一段时间内的点赞数后，再调用接口发送点赞信息。

    ```
    mAlivcILiveRoom.sendLike(mLikeCount, new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
        @Override
        public void onSuccess(AlivcCommonSuccess o) {
            //点赞成功
        }
        @Override
        public void onFailure(AlivcCommonError iError) {
           //点赞失败
        }
    }
    ```

-   点赞下行通知

    在观众端发送点赞消息后，服务端会发送点赞的下行通知，通过实现代理IAlivcInteractiveNotifyListener中的onNotifyLike方法来接受点赞通知。

    ```
    //点赞通知
    @Override
    public void onNotifyLike(Object alivcIRoom, final int likeCount) {
        // 处理
    }
    ```

-   查询房间内点赞数

    主播和观众在进入直播间时都可以查询房间内已收到的点赞数。

    ```
    // 获取房间的点赞数
    mAlivcILiveRoom.getLikeCount(new IAlivcCallback<Long, AlivcCommonError>() {
        @Override
        public void onSuccess(Long likeResult) {
            //获取点赞成功
        }
        @Override
        public void onFailure(AlivcCommonError alivcCommonError) {
            //获取点赞失败
        }
    });
    ```

    **说明：** 此接口一定要在进房间成功之后调用。

-   发送聊天信息

    发送聊天消息调用接口sendChatMessage接口，参数content为聊天内容字符串，userData为用户自定义数据，会和content一起通知。由于聊天content支持文字和表情符号，为了防止编码非UTF-8编码在通过服务端透传时产生乱码问题，建议您在使用时对content进行base64编码处理，收到消息通知后再对content进行base64解码后再显示，服务端对消息长度的限制为string长度不能超过512，超过最大长度则发送消息失败，即在发送消息时对content进行base64编码后长度不能超过512。

    **说明：** 如果已经上线了旧版的App中没有对聊天content进行base64编码，而新版本中使用了base64编码，会出现新老版本聊天消息不兼容问题，请您确保App的所有端和版本使用同一套编码方案，否则会出现兼容性问题。

    userData 一般可以传递用户头像url信息、用户id等，必须是json格式的数据。

    ```
    //用户聊天内容
    String chatMessage = "<聊天内容>";
    //对聊天内容进行Base64编码，解决不识别字符的乱码问题，如表情符号
    String chatContent = chatMessage;
    if (!TextUtils.isEmpty(chatMessage)) {
        chatContent = Base64.encodeToString(chatMessage.getBytes(), Base64.NO_WRAP);
    }
    //用户信息
    String userDesp = mAlivcUserInfo.userDesp;
    mAlivcILiveRoom.sendChatMessage(chatContent, userDesp, new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
        @Override
        public void onSuccess(AlivcCommonSuccess o) {
            //发送聊天消息成功
        }
        @Override
        public void onFailure(AlivcCommonError iError) {
            //发送聊天消息失败
        }
    });
    ```

-   聊天信息通知

    主播和观众在进入直播间时都可以查询房间内已收到的点赞数聊天消息的下行通知，通过实现代理IAlivcInteractiveNotifyListener中的onNotifyChatMsg方法来接收聊天通知，同样被base64编码后的content需要使用base64解码后显示。

    **说明：** 如果已经上线了旧版的App中没有对聊天content进行base64编码，而新版本中使用了base64编码，会出现新老版本聊天消息不兼容问题，请您确保App的所有端和版本使用同一套编码方案，否则会出现兼容性问题。

    ```
    //聊天消息通知
    @Override
    public void onNotifyChatMsg(Object iWidget, String userId, String content, String userData) {
        //处理聊天消息
    }
    ```

-   查询房间内历史消息

    主播和观众在进入直播间时都可以查询房间内的历史消息，历史消息每次最多返回最近20条以内的消息列表，按照降序排列，即返回的消息列表中第一条消息为房间内最新的消息，同样，消息列表中的消息content字段如果发送时被base64编码了，那么需要使用base64解码后显示。

    **说明：** 如果已经上线了旧版的App中没有对聊天content进行base64编码，而新版本中使用了base64编码，会出现新老版本聊天消息不兼容问题，请您确保App的所有端和版本使用同一套编码方案，否则会出现兼容性问题。

    ```
    //获取历史消息
    @Override
    public void getHistoryChatMessage(new IAlivcCallback<List<AlivcChatHistoryMsg>, AlivcCommonError>() {
        @Override
        public void onSuccess(final List<AlivcChatHistoryMsg> alivcChatHistoryMsgs) {
            //历史消息内容进行Base64解码
            Iterator<AlivcChatHistoryMsg> historyMsgIterator = alivcChatHistoryMsgs.iterator();
            while (historyMsgIterator.hasNext()) {
                AlivcChatHistoryMsg historyMsg = historyMsgIterator.next();
                if (historyMsg != null && !TextUtils.isEmpty(historyMsg.content)) {
                    if (!TextUtils.isEmpty(historyMsg.content)) {
                        historyMsg.content = new String(Base64.decode(historyMsg.content, Base64.NO_WRAP));
                    }
                }
            }
            Collections.reverse(alivcChatHistoryMsgs);
            //将历史消息进行其他处理
        }
        @Override
        public void onFailure(AlivcCommonError alivcCommonError) {
        }
    }
    ```

    **说明：** 此接口一定要在进房间成功之后调用。


## 播放控制 {#section_k4n_5yf_2gb .section}

播放控制时观众端操作，主要包含以下几项：

-   拉流播放

    观众进入直播间观看直播流，SDK内部会启动播放器进行拉流播放，拉流播放操作是有以下两种情况：

    -   观众进入直播间时，主播正在直播，在进入房间成功之后，App 调用接口setRemoteView时，SDK内部发现主播正在直播，会开始拉流播放。
    -   观众进入直播间时，主播没有直播，稍后主播开启直播。在进入房间成功之后，App 调用接口setRemoteView时，SDK内部发现主播没有直播，此时不会拉流播放，App根据房间状态来提示直播没有开始，当主播开始直播时，SDK 会收到主播直播的通知，然后自动开始直播。
    SDK 拉流播放成功会通过IAlivcPlayerNotifyListener回调的onPlayerStarted给APP通知播放开始。

    ```
    @Override
    public void onPlayerStarted(Object iPlayer, String s) {
      //播放开始通知
    }
    ```

-   播放停止

    导致直播播放地停止的原因有以下几种：

    -   主播主动停止直播，SDK在拉流结束后会停止播放，
    -   观众端主动退出直播间，会停止播放，
    -   观众端网络中断在播放器重试超时后会停止播放。
    无论是那种原因导致的播放停止，SDK都会通过IAlivcPlayerNotifyListener回调的onPlayerStopped给App通知播放结束。

    ```
    @Override
    public void onPlayerStopped(Object iPlayer, String s) {
        //播放停止通知
    }
    ```

-   重连播放

    当收到播放停止的通知后，App可以通过调用reconenct接口进行播放重连的操作，调用改接口后，SDK会重现尝试拉流播放操作。该操作适用于观众端由于网络原因导致播放失败时候后，进行重连。

    ```
    mAlivcILiveRoom.reconnect(new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
        @Override
        public void onSuccess(AlivcCommonSuccess object) {
        }
        @Override
        public void onFailure(AlivcCommonError error) {
        }
    });
    ```

    调用重连接口后，SDK都会通过IAlivcNetworkListener回调通知重连结果。

    ```
    @Override
    public void onReconnectStart() {
        //重连开始通知
    }
    @Override
    public void onReconnectFail() {
        //重连失败通知
    }
    @Override
    public void onReconnectSucceed() {
        //重连成功通知
    }
    ```

-   暂停、恢复

    观看直播时，可以暂停和恢复播放。

    ```
    mAlivcILiveRoom.pause(); //暂停播放
    ```

    ```
    mAlivcILiveRoom.resume(); //恢复播放
    ```

-   静音

    观看直播时，对播放进行禁音操作。

    ```
    mAlivcILiveRoom.setMute(mute); //静音
    ```


## 推流控制 {#section_itc_qzf_2gb .section}

主播端的推流控制包括以下几项操作：

-   开始推流

    主播进入房间成功后，SDK内部会自动开始推流，推流成功通知通过IAlivcPusherNotifyListener代理回调。

    ```
    @Override
    public void onPushStarted(AlivcLivePusher alivcLivePusher) {
        //推流成功通知
    }
    ```

-   停止推流

    主播退出房间，SDK会自动停止推流，停止推流通知通过IAlivcPusherNotifyListener代理回调。

    ```
    @Override
    public void onPushStoped(AlivcLivePusher alivcLivePusher) {
        //推流停止通知 
    }
    ```

-   推流重连

    推流过程中由于网络原因导致推流连接中断时，SDK内部会自动开启推流重连操作，重连操作会执行10次，每次间隔2秒，当内部重连操作失败后停止重试，上报重连错误通知。主播也可以调用reconnect接口进行重连。

    ```
    mAlivcILiveRoom.reconnect(new IAlivcCallback<AlivcCommonSuccess, AlivcCommonError>() {
        @Override
        public void onSuccess(AlivcCommonSuccess object) {
        }
        @Override
        public void onFailure(AlivcCommonError error) {
        }
    });
    ```

    无论是SDK内部自动重连还是调用接口reconnect重连，SDK都会通IAlivcNetworkListener回调通知重连结果。

    ```
    @Override
    public void onReconnectStart() {
        //重连开始通知
    }
    @Override
    public void onReconnectFail() {
        //重连失败通知
    }
    @Override
    public void onReconnectSucceed() {
        //重连成功通知
    }
    ```

-   静音

    主播直播过程中可以通过静音接口控制是否静音。

    ```
    mAlivcILiveRoom.setMute(mute); //静音
    ```


## 相机控制 {#section_q22_11g_2gb .section}

相机控制是主播端的操作，包括切换相机、获取当前相机位置、对焦、缩放、曝光和手电筒操作。

-   切换相机

    切换前置后置相机，预览和直播中都可以切换。

    ```
    mAlivcILiveRoom.switchCamera();
    ```

-   获取当前相机位置

    可以通过以下接口获取当前相机的位置。

    ```
    mAlivcILiveRoom.getCurrentCameraType();
    ```

-   自动对焦

    ```
    mAlivcILiveRoom.setAutoFocus(autoFocus);
    ```

-   手动对焦

    ```
    mAlivcILiveRoom.focusCameraAtAdjustedPoint(x, y, autofocus);
    ```

-   设置缩放倍数

    缩放接口为增量设置，每次设置参数都是在当前基础上做增减，缩放倍数范围（1-3）。

    ```
    mAlivcILiveRoom.setZoom(1.0); //当前的缩放倍数+1
    ```

-   获取缩放倍数

    ```
    mAlivcILiveRoom.getCurrentZoom();
    ```

-   获取最大缩放倍数

    ```
    mAlivcILiveRoom.getMaxZoom();
    ```

-   设置曝光度

    ```
    mAlivcILiveRoom.setExposure(exposure);
    ```

-   获取相机最小曝光度值

    ```
    mAlivcILiveRoom.getSupportedMinExposure();
    ```

-   获取相机最大曝光度值

    ```
    mAlivcILiveRoom.getSupportedMaxExposure();
    ```

-   获取当前曝光度值

    ```
    mAlivcILiveRoom.getCurrentExposure();
    ```


## 美颜控制 {#section_rl3_t1g_2gb .section}

美颜控制是主播端操作，主要通过两个接口控制美颜开关和调节美颜参数。

-   美颜开关

    ```
    mAlivcILiveRoom.setBeautyOn(true); //打开美颜
    ```

-   美颜参数调节

    setBeautyParams接口根据设置的参数AlivcBeautyParams可以调节美颜的各个参数。

    ```
    mAlivcILiveRoom.setBeautyBeautyParams(params); //调节美颜参数
    ```


## 错误处理 {#section_kwn_w1g_2gb .section}

SDK 在运行过程中所有错误都通过代理IAlivcErrorListener的接口onSystemError、onSDKError回调通知出去，AlivcCommonError对象有三个参数，errorModule表示SDK内部出错模块，errorCode表示错误码，errorMessage表示详细错误字符串描述。errorModule和errorCode都在AlivcCommonError中定义。

```
@Override
public void onSystemError(Object o, AlivcCommonError commonError) {
    //底层System API操作错误回调
}
@Override
public void onSDKError(Object o, AlivcCommonError commonError) {
    //回调SDK逻辑或者状态错误回调
}
```

## 销毁 {#section_brb_z1g_2gb .section}

在销毁SDK之前必须要调用SDK 接口release。

```
mAlivcILiveRoom.release();
```

## 通知回调 {#section_w1n_1bg_2gb .section}

SDK 根据不同的接口调用会有以下几种类型的通知回调，有些通知回调APP必须要做出对应的处理。

|通知回调类|通知详细说明|建议处理方式|
|:----|:-----|:-----|
|IAlivcAuthListener鉴权回调类|onStsTokenCloseExpireSTS Token 即将过期|APP 必须处理|
|onSTSTokenExpiredSTS Token 已经过期|APP 必须处理|
|IAlivcLiveRoomNotifyListener房间回调类|onNotifyUpMic主播开播通知|APP 必须处理|
|onNotifyDownMic主播停播通知|APP 必须处理|
|onNotifyKickoutUser用户被踢出直播间通知| |
|onForbidStream主播被禁播通知| |
|IAlivcInteractiveNotifyListener互动类回调|onNotifyChatMsg聊天消息通知| |
|onNotifyCustomMsg自定义通知| |
|onNotifyLike点赞消息通知| |
|IAlivcPusherNotifyListener主播推流回调|onFirstFramePreviewed主播首帧显示通知| |
|onPushStarted推流开始通知|建议处理，提示主播推流已经开始|
|onPushPauesed直播暂停通知| |
|onPushResumed直播恢复通知| |
|onPushStoped推流停止通知|建议处理，提示主播推流已经停止|
|IAlivcPlayerNotifyListener观众播放回调|onPlayerStarted播放开始回调|建议处理，提示拉流成功|
|onPlayerStopped播放停止回调|建议处理，提示播放失败，请重试|
|onPlayerBufferingStarted播放缓冲开始回调|建议处理，提示播放缓冲|
|onPlayerBufferingEnded播放缓冲结束回调|建议处理，提示播放缓冲结束|
|IAlivcNetworkListener网络状况回调|onNetworkPoor主播推流弱网提示|建议处理，提示主播网络差|
|onNetworkRecovery 主播推流网络恢复提示| |
|onReconnectStart 主播推流开始重连|建议处理，提示正在重连|
|onReconnectSucceed 主播推流重重连成功|建议处理，提示重连成功|
|onReconnectFail 主播推流重重连失败|必须处理 推流或者播放已经中断，一定要提示重试|
|IAlivcErrorListener错误回调|onSystemError使用系统API错误回调或者未知错误回调| |
|onSDKErrorSDK使用过程状态判断或者网络环境或者过期等回调|建议处理，根据errorCode提示或者相应处理|

## 常见问题 {#section_p5h_tbg_2gb .section}

-   观众端如何判断直播开始和直播结束？

    直播开始，观众端SDK会回调通知onNotifyUpMic直播结束，观众端SDK会回调通知onNotifyDownMic

-   如何发送用户进出房间通知？

    SDK 没有定义用户进出房间的通知，而是业务方通过服务端接口SendRoomNotification发送自定义房间消息，App自己定义进出房间的消息字段，在进出房间成功之后，通过接口SendRoomNotification发送给互动直播服务端，服务端会下发消息给互动直播客户端SDK， SDK会回调通知onNotifyCustomMsg将自定义房间消息回调给App，App通过解析自定义消息体，就能实现进出房间的通知。

-   主播切换前后台如何处理？

    在主播端退后台，App可以不用做任何处理，SDK已经处理了这种情况。SDK中在主播切换后台的时候，会停止相机的采集，只采集麦克风的音频数据，如果设置了退后台图片，主播端就会推这张图片，观众端观看的效果就是能够听到主播的声音，看到设置的一帧图片。如果没有设置了退后台图片，观众端的视频就会卡在主播退后台前一帧画面。

-   进房间的用户id可以使用业务方自己的用户id吗？

    可以，并且建议使用业务方自己的用户id作为进房间的用户id，但是有长度限制，目前最大长度为36位。

-   主播断网或者网络切换怎么处理？

    主播端断网或者网络切换会导致主播推流中断，此时SDK内部会自动开始重连，重连10次，每次2秒，如果重连次数用完后还是没有重连成功，SDK 会上报重连失败onReconnectFail通知。

    **说明：** 一旦收到onReconnectFail，表示主播推流失败，App上一定要做相应的提示信息通知给主播，因为即使推流中断，主播端的预览仍然是正常的，没有通知提醒，主播不知道推流已经中断。

    在推流中断后，建议App设计一个重连的按钮，调用SDK的reconnect接口进行重连推流，这样子在网络恢复后通过重连按钮可以让SDK开始重新推流。

-   主播直播中App进程异常退出再进入怎么处理？

    如果主播直播中App进程异常退出，观众端会提示播放结束onPlayerStopped通知回调：

    -   如果主播在5分钟内没有再次开启App进入同样的房间恢复直播，在App进程异常退出5分钟后，服务端会将该主播的状态强制设置为直播结束，所有观众端会收到主播停止直播onNotifyDownMic通知。
    -   如果主播在5分钟内再次开启App进入同样的房间恢复直播，那么直播继续，但是播放已经断开的观众端不会自动播放，建议观众端在收到onPlayerStopped，提示直播中断，调用reconnect接口重连后就可以继续播放。
    主播长时间断网的处理也与这个行为一致：

    -   如果断网5分钟以上，服务端会将该主播的状态强制设置为直播结束，所有观众端会收到主播停止直播onNotifyDownMic通知。
    -   如果5分钟内连上网络恢复直播，那么直播继续，但是播放已经断开的观众端不会自动播放，建议观众端在收到onPlayerStopped，提示直播中断，调用reconnect接口重连后就可以继续播放。
-   如何分享直播地址？

    SDK提供接口getPlayUrlInfo用于获取当前直播的播放地址，包含flv 和m3u8格式的两种类型。

    **说明：** 由于URL带有有效期信息，超过有效期的播放URL不能播放。



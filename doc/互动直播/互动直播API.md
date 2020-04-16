# 互动直播API {#concept_pvw_3kf_lfb .concept}

本文档主要介绍互动直播API使用流程和相关API描述。

## 互动直播API使用流程 {#section_m12_jkf_lfb .section}

互动直播服务端提供了一系列API接口，包含主要包含房间管理、用户管理、流管理和房间通知等接口。基本使用流程如下：

1.  在控制台或工单申请创建应用。
2.  创建房间。
3.  获取房间列表和状态。
4.  获取房间统计信息。
5.  禁止推流。
6.  获取禁播房间列表。
7.  房间内通知和用户通知。
8.  删除房间。

## API概述 {#section_h1l_zkf_lfb .section}

|API|描述|
|---|--|
|[CreateRoom](../../../../cn.zh-CN/API 参考/互动直播/创建房间.md#)|互动直播的所有交互都基于房间展开，必须先创建房间，直播间可重复使用。|
|[DeleteRoom](../../../../cn.zh-CN/API 参考/互动直播/删除房间.md#)|在直播结束或不再使用此直播间时删除直播间。|
|[DescribeRoomList](../../../../cn.zh-CN/API 参考/互动直播/获取房间列表.md#)|获取房间列表，创建直播间后可获取。|
|[DescribeRoomStatus](../../../../cn.zh-CN/API 参考/互动直播/获取房间状态.md#)|获取房间状态，可获取直播间的推端流状态。|
|[ForbidPushStream](../../../../cn.zh-CN/API 参考/互动直播/禁止推流.md#)|禁止推流，主要用于后台管理主播是否能推流。|
|[AllowPushStream](../../../../cn.zh-CN/API 参考/互动直播/解除禁止推流.md#)|解除禁止推流，用于被禁止推流后的房间恢复推流权限。|
|[DescribeForbidPushStreamRoomList](../../../../cn.zh-CN/API 参考/互动直播/获取禁播房间列表.md#)|获取禁播房间列表，被禁止推流的房间可以通过此接口获取。|
|[DescribeRoomKickoutUserList](../../../../cn.zh-CN/API 参考/互动直播/获取被踢出用户列表.md#)|获取被踢出直播间的用户列表，踢人操作在客户端上发起。|
|[SendRoomNotification](../../../../cn.zh-CN/API 参考/互动直播/房间通知消息.md#)|房间通知，主要用于进出入房间的通知，适合在整个房间广播的消息通知。|
|[SendRoomUserNotification](../../../../cn.zh-CN/API 参考/互动直播/房间内用户通知消息.md#)|房间用户通知，主要用户发送礼物的通知，适合向房间内的个人发送通知。|


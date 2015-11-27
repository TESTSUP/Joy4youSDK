//
//  JYDefine.h
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//
//  SDK中用到的key信息


#define KEY_SDKVER      @"sdkverison"
#define KEY_JSVER       @"sdkjsversion"

//请求相关
#define KEY_DATA        @"data"
#define KEY_MSG         @"msg"
#define KEY_STATUS      @"status"

//用户相关
#define KEY_UN          @"username"         //用户名
#define KEY_PW          @"password"         //密码
#define KEY_PHONE       @"phone"            //手机号
#define KEY_EMAIL       @"email"            //邮箱
#define KEY_TYPE        @"type"             //type=1 用户名注册  type=2游客登录  3手机号注册4 一键注册
#define KEY_SEX         @"sex"              //性别 0 女  1男
#define KEY_FROM        @"from"             //iOS或者Android
#define KEY_SID         @"sessionid"        //缓存登录用的sid
#define KEY_UID         @"userid"           //用户id
//第三方相关
#define KEY_TUID        @"tuid"             //第三方用户ID
#define KEY_THD         @"thd"              //第三方id
#define KEY_TUN         @"tun"              //第三方用户名
#define KEY_TPH         @"tph"              //第三方手机号
//应用相关
#define KEY_APPID       @"appid"            //游戏id（验证appid是否有效）
#define KEY_CHANNEL     @"channelid"        //注册渠道id
#define KEY_CUID        @"cuid"             //渠道用户id   不同渠道获取
#define KEY_PKG         @"pkg"              //包名packageName
#define KEY_VERSION     @"gameversion"      //游戏版本号
//唯一标示
#define KEY_CKID        @"ckid"             //设备信息加密串儿
#define KEY_DVID        @"dvid"             //设备信息加密串儿
#define KEY_CHID        @"chid"             //设备唯一编号 （客户端生成）
#define KEY_UDID        @"udid"             //设备id
#define KEY_IDFA        @"idfa"             //广告标识
#define KEY_IDFV        @"idfv"             //唯一标识
//设备信息
#define KEY_TEL         @"telecomoper"      //运营商
#define KEY_NET         @"network"          //(可选)3G/WIFI/2G
#define KEY_SCREEN_W    @"screenwidth"      //(可选)显示屏宽度
#define KEY_SCREEN_H    @"screenhight"      //(可选)显示屏高度
#define KEY_DEN         @"density"          //(可选)像素密度
#define KEY_CPU         @"cpuhardware"      //(可选)cpu类型|频率|核数
#define KEY_MEMORY      @"memory"           //(可选)内存信息单位M
#define KEY_DT          @"dt"               //终端类型
#define KEY_DM          @"dm"               //设备型号
#define KEY_OSV         @"osv"              //系统版本
#define KEY_MAC         @"mac"              //mac地址
#define KEY_IMEI        @"imei"             //用户imei码
#define KEY_SRL         @"srl"              //设备序列号
#define KEY_TSV         @"tsv"              //流量中心跟踪sdk版本号（如 1.1.0）
#define KEY_BN          @"bn"               //品牌名称（如 Samsung，Xiaomi）
//钥匙串
#define KEYCHAIN_SERVICE    @"keychainServiceName"
//请求相关
#define PATH_CHECK              @"/joysdk/index.php/UserApi/checkUserName/"          //检查用户名
#define PATH_LOGIN              @"/joysdk/index.php/UserApi/login/"                  //用户名+密码登录
#define PATH_LOGIN_TOURIST      @"/joysdk/index.php/UserApi/touristLogin/"           //游客登录
#define PATH_LOGIN_SID          @"/joysdk/index.php/UserApi/autoLogin/"              //缓存登录
#define PATH_REGIST_UN          @"/joysdk/index.php/UserApi/register/"               //用户名密码注册
#define PATH_BIND_ACCOUNT       @"/joysdk/index.php/UserApi/bindUserName/"           //绑定用户名
#define PATH_BIND_EMAIL         @"/joysdk/index.php/UserApi/bindEmail/"              //绑定邮箱
#define PATH_FIND_PW            @"/joysdk/index.php/FindPwdApi/findPwd/"             //找回密码





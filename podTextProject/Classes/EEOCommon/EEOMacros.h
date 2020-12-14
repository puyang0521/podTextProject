//
//  EEOMacros.h
//  EEOCommon
//
//  Created by HeQian on 2017/1/9.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#ifndef EEOMacros_h
#define EEOMacros_h

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF __strong typeof(self) strongSelf = weakSelf;
#define STRONGself __strong typeof(self) self = weakSelf;

#define     PATH_DOCUMENT                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define     PATH_LIBRARY_CACHES                   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define     PATH_APP_SUPPORT                   [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject]

#define PATH_NATIVE_DATA [PATH_APP_SUPPORT stringByAppendingPathComponent:[[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey]]

#define PATH_LOG [PATH_DOCUMENT stringByAppendingPathComponent:@"Log"]

//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//用于设置连接哪个环境
#define USE_LBSERVER_FLAG  3 //1=公网 2=预生产 3=内网13测试服务器 4=内网14测试服务器

//↓↓↓↓↓↓↓↓↓辅助功能的开关定义↓↓↓↓↓↓↓↓↓//
//1:开启 0:关闭

#if USE_LBSERVER_FLAG == 1  //发布公网版本时,会关闭运行日志,并开启腾讯MTA
    
    #if DEBUG
        #define Enabled_Run_Logs 1
    #else
        #define Enabled_Run_Logs 0
    #endif
    
    #define Enabled_MTA 1
#else
    #define Enabled_Run_Logs 1
    #define Enabled_MTA 0
#endif

#if USE_LBSERVER_FLAG >= 3  //只在内网测试环境开启
    #define Enabled_ServerBar 1
#else
    #define Enabled_ServerBar 0
#endif

#if Enabled_Run_Logs
    #define NSLog(...) NSLog(@"%@\n\n",[NSString stringWithFormat:__VA_ARGS__])
#else
    #define NSLog(...)
#endif

#define NSErrorLog(...) NSLog(@"Error::%s,%@\n\n",__func__,[NSString stringWithFormat:__VA_ARGS__])

#define Enabled_Bugly 1 //是否启用腾讯Bugly

#define Enabled_WX 1 //是否启用微信相关的api

#define Enabled_HomeWork 1 //是否开启作业功能入口

#define Enabled_OfflineUse 0 //是否开启离线使用功能

#define Enabled_ServerThrottle 0 //是否开启服务器节流模式

//↑↑↑↑↑↑↑↑↑辅助功能的开关定义↑↑↑↑↑↑↑↑↑//

#endif /* EEOMacros_h */

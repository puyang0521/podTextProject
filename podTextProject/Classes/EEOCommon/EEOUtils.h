//
//  EEOUtils.h
//  EEOCommon
//
//  Created by HeQian on 16/5/5.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger, EEODeviceType) {
    EEODeviceTypeIPhone,
    EEODeviceTypeIPodTouch,
    EEODeviceTypeIPad,
    EEODeviceTypeUnknow
};

@interface EEOUtils : NSObject

+ (int)randomNumberWithFrom:(int)from to:(int)to;

+ (NSUInteger)randomTimeIntervalWithFrom:(NSDate*)from to:(NSDate*)to;

+ (NSString *)fetchMacAddressInfo;

+ (NSString *)deviceName;

+ (void)getAppInfoFromAppstoreWithAppId:(NSString *)appId complete:(void(^)(NSDictionary *,NSError *))complete;

+ (NSString *)getIpAddressFromHostName:(NSString *)host;

+ (float)fetchFreeDiskSpaceToMB;

/** 获取设备类型 */
+ (EEODeviceType)getDeviceType;

/**
 判断是不是刘海屏手机
 */
+ (BOOL)isIPhoneXType;

/**
 判断是否为全面屏设备
 */
+ (BOOL)isFullScreenDevice;

/**
 判断系统版本小于某个版本
 */
+ (BOOL)systemVersionIsLowerThan:(CGFloat)version;
/**
 判断系统版本大于等于某个版本
 */
+ (BOOL)systemVersionIsHigherThan:(CGFloat)version;

/**
 获取组装好的User-Agent

 @return 格式:操作系统类型/操作系统版本号 客户端类型/客户端版本
 */
+ (NSString *)webCustomUA;

/// 替换url字符串中的域名
+ (NSString *)replaceURLDomainWithWebServerAddress:(NSString *)webServerAddress urlString:(NSString *)urlString;

@end

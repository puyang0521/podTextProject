//
//  EEOAppInfo.h
//  EEOEntity
//
//  Created by 蒋敏 on 2018/1/9.
//  Copyright © 2018年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOAppInfo : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,assign) NSUInteger isThirdPartyOpen;

@property (nonatomic,assign) NSUInteger appUnreadMsgNum;

@property (nonatomic,assign) NSUInteger classInUnreadMsgNum;

@property (nonatomic,assign) NSUInteger messageCenterUnreadMsgNum;
@property (nonatomic,assign) NSUInteger contactAddRequestUnreadMsgNum;
@property (nonatomic,assign) NSUInteger classReminderUnreadMsgNum;

@property (nonatomic,assign) NSInteger netStatus;

@property (nonatomic,copy) NSString *currentClassSN;
@property (nonatomic,copy) NSNumber *currentOpenClassID;

@property (nonatomic,assign) BOOL isShrink;
@property (nonatomic,assign) BOOL isSupportApplePencil;

@property (nonatomic,assign) NSUInteger clientISP;
@property (nonatomic,copy) NSNumber *clientLocation;

- (BOOL)isNeedUploadFreeDiskSpace;

/**
 缓存二维码扫描结果

 @param imageName 图片名字
 @param qrcode 二维码
 */
- (void)cacheQRCodeWithImageName:(NSString *)imageName qrcode:(NSString *)qrcode;

/**
 获取缓存的二维码

 @param imageName 图片名字
 @return 二维码
 */
- (NSString *)getQRCodeWithImageName:(NSString *)imageName;

@end

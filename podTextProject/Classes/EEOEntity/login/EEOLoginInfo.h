//
//  LoginInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/11/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LoginAuthType) {
    LoginAuthType_Temp = 0,
    LoginAuthType_PlainText = 1,
    LoginAuthType_Md5 = 2,
};

@interface EEOLoginInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) NSUInteger authType;
@property (nonatomic,assign) BOOL isForce;

@property (nonatomic,assign) NSString *clientVersion;

@property (nonatomic,assign) BOOL isIgnoreNewVersion;

@property (nonatomic,assign) BOOL isGuest;

@property (nonatomic,copy) NSNumber* uid;

- (BOOL)isAvailable;

- (NSString *)finalLoginPassword;

- (BOOL)isTempAuth;

@end

@class EEOSchoolInfo;
@interface EEOLoginCompleteInfo : NSObject

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,assign) NSUInteger lastLoginTime;
@property (nonatomic,assign,readonly) NSInteger serverTimeInterval;//表示与服务器时间相差的秒数,可能为负数

@property (nonatomic,readonly) NSString *webServerAddress;
@property (nonatomic,copy) NSString *webServerStaticAddress;
@property (nonatomic,copy) NSString *webServerDynamicAddress;
@property (nonatomic,copy) NSString *mntDomain;

/**
 公网ip地址
 */
@property (nonatomic,copy) NSString *ipAddress;

@property (nonatomic,assign) BOOL isGuest;

///下一次聊天文件能够上传的时间
@property (nonatomic,assign) NSTimeInterval nextChatFileUploadInterval;

/// 新版本的升级地址
@property (nonatomic,copy) NSString *upgradeAddress;

+ (instancetype)sharedInstance;

- (instancetype)initWithServerTime:(NSUInteger)serverTime;

- (void)cloneCompleteInfo:(EEOLoginCompleteInfo *)info;

- (NSUInteger)loginTime;

- (NSTimeInterval)clientCurrentTime;
- (NSTimeInterval)serverCurrentTime;

- (void)changeServerTime:(NSUInteger)serverTime;

- (NSString *)webServerStaticAddressNonScheme;
- (NSString *)webServerDynamicAddressNonScheme;

#pragma mark - 该账号所服务的机构列表信息
- (void)buildAssistantsSchoolList:(NSArray *)list;
- (BOOL)hasAssistantsSchool;
//子账号拥有建课权限的所属机构列表
- (NSArray *)subSchoolInfoList;

- (void)cacheSchoolInfo:(EEOSchoolInfo *)schoolInfo;
- (EEOSchoolInfo *)getCacheSchoolInfoWithSchoolId:(NSNumber *)schoolId;

@end

//
//  LoginInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/11/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOLoginInfo.h"

#import "NSString+EEO.h"
#import "EEOConstants.h"

#import "EEOSchoolInfo.h"

@implementation EEOLoginInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _authType = LoginAuthType_Md5;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOLoginInfo *copyObj = [[EEOLoginInfo allocWithZone:zone] init];
    copyObj.account = self.account;
    copyObj.password = self.password;
    copyObj.authType = self.authType;
    copyObj.isForce = self.isForce;
    copyObj.clientVersion = self.clientVersion;
    copyObj.isIgnoreNewVersion = self.isIgnoreNewVersion;
    copyObj.isGuest = self.isGuest;
    copyObj.uid = self.uid;
    return copyObj;
}

- (BOOL)isAvailable {
    if(_isGuest){
        return YES;
    }else{
        return _account.length > 0 && _password.length > 0;
    }
}

- (NSString *)finalLoginPassword {
    NSString *result = [_password copy];
    if(result.length > 0 && _authType == LoginAuthType_Md5){
        result = [result md5String];
    }
    return result;
}

- (BOOL)isTempAuth {
    return _authType == LoginAuthType_Temp;
}

@end

@interface EEOLoginCompleteInfo (){
    NSUInteger _loginServerTime;
}

@property (atomic,strong) NSMutableArray *assistantsSchoolList;
@property (atomic,strong) NSMutableDictionary *schoolInfoDic;

@end

@implementation EEOLoginCompleteInfo

+ (instancetype)sharedInstance {
    static EEOLoginCompleteInfo *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithServerTime:(NSUInteger)serverTime {
    self = [super init];
    if(self){
        _loginServerTime = serverTime;
        _serverTimeInterval = _loginServerTime - [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

- (void)cloneCompleteInfo:(EEOLoginCompleteInfo *)info {
    self.uid = info.uid;
    self.lastLoginTime = info.lastLoginTime;
//    self.webServerAddress = info.webServerAddress;
    self.webServerStaticAddress = info.webServerStaticAddress;
    self.webServerDynamicAddress = info.webServerDynamicAddress;
    self.mntDomain = info.mntDomain;
    self.ipAddress = info.ipAddress;
    self.assistantsSchoolList = [[info subSchoolInfoList] mutableCopy];
    self.schoolInfoDic = info.schoolInfoDic;
    self.isGuest = info.isGuest;
    
    _loginServerTime = [info loginTime];
    _serverTimeInterval = _loginServerTime - [[NSDate date] timeIntervalSince1970];
}

- (NSUInteger)loginTime {
    return _loginServerTime;
}

- (NSTimeInterval)clientCurrentTime {
    return [self serverCurrentTime];
}
- (NSTimeInterval)serverCurrentTime {
    NSTimeInterval result = [[[NSDate date] dateByAddingTimeInterval:_serverTimeInterval] timeIntervalSince1970];
    return result;
}

- (void)changeServerTime:(NSUInteger)serverTime {
    _loginServerTime = serverTime;
    _serverTimeInterval = _loginServerTime - [[NSDate date] timeIntervalSince1970];
}

- (NSString *)webServerStaticAddressNonScheme {
    NSString *result = @"";
    NSString *tempStr = _webServerStaticAddress;
    if(tempStr.length > 0){
        NSArray *strList = [tempStr componentsSeparatedByString:@"://"];
        if(strList.count >= 2){
            result = strList[1];
        }
    }
    return result;
}
- (NSString *)webServerDynamicAddressNonScheme {
    NSString *result = @"";
    NSString *tempStr = _webServerDynamicAddress;
    if(tempStr.length > 0){
        NSArray *strList = [tempStr componentsSeparatedByString:@"://"];
        if(strList.count >= 2){
            result = strList[1];
        }
    }
    return result;
}

- (NSString *)webServerAddress {
    return _webServerStaticAddress;//TODO...
}

- (NSString *)upgradeAddress {
    NSString *result = _upgradeAddress;
    if(result.length <= 0){
        result = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@?mt=8",kClassInAppId];
    }
    return result;
}

#pragma mark - 该账号所服务的机构列表信息
- (void)buildAssistantsSchoolList:(NSArray *)list {
    if(self.assistantsSchoolList == nil){
        self.assistantsSchoolList = [NSMutableArray array];
    }
    [self.assistantsSchoolList removeAllObjects];
    [self.assistantsSchoolList addObjectsFromArray:list];
    
    if (self.schoolInfoDic == nil) {
        self.schoolInfoDic = [NSMutableDictionary dictionary];
    }
    for (EEOSchoolInfo *info in list) {
        [self.schoolInfoDic setObject:info forKey:info.schoolId];
    }
}

- (BOOL)hasAssistantsSchool {
    return self.assistantsSchoolList.count > 0;
}

- (NSArray *)subSchoolInfoList{
    return [self.assistantsSchoolList copy];
}

- (void)cacheSchoolInfo:(EEOSchoolInfo *)schoolInfo{
    if (schoolInfo && schoolInfo.schoolId) {
        if (self.schoolInfoDic == nil) {
            self.schoolInfoDic = [NSMutableDictionary dictionary];
        }
        [self.schoolInfoDic setObject:schoolInfo forKey:schoolInfo.schoolId];
    }else{
        NSLog(@"%s 缓存schoolInfo出错",__func__);
    }
}

- (EEOSchoolInfo *)getCacheSchoolInfoWithSchoolId:(NSNumber *)schoolId{
    if (!self.schoolInfoDic || !schoolId) {
        return nil;
    }
    EEOSchoolInfo *result = [self.schoolInfoDic objectForKey:schoolId];
    return result;
}

@end

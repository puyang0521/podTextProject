//
//  EEOUser.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOUserInfo.h"

#import "NSString+EEO.h"
#import "NSDictionary+EEO.h"

@implementation EEOUserConfigInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeTag = @(0);
        self.cloudDiskID = @(0);
        self.privacyFlags = @(0);
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOUserConfigInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.timeTag = self.timeTag;
    copyObj.contactorAuth = self.contactorAuth;
    copyObj.passwordStrength = self.passwordStrength;
    copyObj.cloudDiskID = self.cloudDiskID;
    copyObj.privacyFlags = self.privacyFlags;
    return copyObj;
}

- (void)cloneConfigInfo:(EEOUserConfigInfo *)cfgInfo {
    self.timeTag = cfgInfo.timeTag;
    self.contactorAuth = cfgInfo.contactorAuth;
    self.passwordStrength = cfgInfo.passwordStrength;
    self.cloudDiskID = cfgInfo.cloudDiskID;
    self.privacyFlags = cfgInfo.privacyFlags;
}

- (BOOL)isOpenWithPrivacyFlag:(UserPrivacyFlag)flag {
    BOOL result = ([_privacyFlags unsignedLongLongValue] & flag) != 0;
    return result;
}

@end
@implementation EEOUserComprehensiveInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeTag = @(0);
        self.mobile = @"";
        self.nickName = @"";
        self.avatarURL = @"";
        self.birthday = @"";
        self.location = @"";
        self.sign = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOUserComprehensiveInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.timeTag = self.timeTag;
    copyObj.mobile = self.mobile;
    copyObj.nickName = self.nickName;
    copyObj.avatarURL = self.avatarURL;
    copyObj.gender = self.gender;
    copyObj.birthday = self.birthday;
    copyObj.location = self.location;
    copyObj.sign = self.sign;
    return copyObj;
}

- (void)cloneComprehensiveInfo:(EEOUserComprehensiveInfo *)comprehensiveInfo {
    self.timeTag = comprehensiveInfo.timeTag;
    self.mobile = comprehensiveInfo.mobile;
    self.nickName = comprehensiveInfo.nickName;
    self.avatarURL = comprehensiveInfo.avatarURL;
    self.gender = comprehensiveInfo.gender;
    self.birthday = comprehensiveInfo.birthday;
    self.location = comprehensiveInfo.location;
    self.sign = comprehensiveInfo.sign;
}

- (void)setNickName:(NSString *)nickName {
    if([_nickName isEqualToString:nickName]){
        return;
    }
    
    _nickName = [nickName copy];
    if(_nickName.length <= 0){
        return;
    }
    //过滤换行符
    _nickName = [NSString filterWhitespaceAndNewlineCharacter:_nickName];
}

- (void)setAvatarURL:(NSString *)avatarURL {
    if([_avatarURL isEqualToString:avatarURL]){
        return;
    }
    
    _avatarURL = [avatarURL copy];
    if(_avatarURL.length <= 0){
        _originalAvatarURL = @"";
        _compressionAvatarURL = @"";
        _thumbnailAvatarURL = @"";
        return;
    }
    
    NSString *outOriginalURL = @"";
    NSString *outCompressionURL = @"";
    NSString *outThumbnailURL = @"";
    [NSString parseAvatarURLJsonStr:_avatarURL outOriginalURL:&outOriginalURL outCompressionURL:&outCompressionURL outThumbnailURL:&outThumbnailURL];
    
    _originalAvatarURL = outOriginalURL;
    _compressionAvatarURL = outCompressionURL;
    _thumbnailAvatarURL = outThumbnailURL;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name=%@,mobile=%@", _nickName,_mobile];
}

@end
@implementation EEOUserInfo

static EEOUserInfo *_mine = nil;
+ (EEOUserInfo *)mine {
    if(_mine == nil){
        _mine = [[EEOUserInfo alloc] init];
    }
    return _mine;
}
+ (void)setMine:(EEOUserInfo *)mine {
    if(_mine != mine){
        _mine = mine;
    }
}

- (instancetype)init {
    return [self initWithUID:@(0)];
}
- (instancetype)initWithUID:(NSNumber *)uid {
    self = [super init];
    if(self){
        self.uid = uid;
    }
    return self;
}

- (NSUInteger)hash {
    return [_uid hash];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOUserInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.uid = self.uid;
    copyObj.configInfo = [_configInfo copy];
    copyObj.comprehensiveInfo = [_comprehensiveInfo copy];
    return copyObj;
}

- (void)cloneUserInfo:(EEOUserInfo *)userInfo {
    self.uid = userInfo.uid;
    if(userInfo.configInfo){
        if(self.configInfo == nil){
            self.configInfo = userInfo.configInfo;
        }else{
            [self.configInfo cloneConfigInfo:userInfo.configInfo];
        }
    }
    if(userInfo.comprehensiveInfo){
        if(self.comprehensiveInfo == nil){
            self.comprehensiveInfo = userInfo.comprehensiveInfo;
        }else{
            [self.comprehensiveInfo cloneComprehensiveInfo:userInfo.comprehensiveInfo];
        }
    }
}

- (unsigned long long)cfgTimeTagNum {
    return [_configInfo.timeTag unsignedLongLongValue];
}
- (NSNumber *)cloudDiskID {
    return _configInfo.cloudDiskID;
}
- (unsigned long long)infoTimeTagNum {
    return [_comprehensiveInfo.timeTag unsignedLongLongValue];
}
- (NSString *)mobile {
    return _comprehensiveInfo.mobile;
}
- (NSString *)nickName {
    return _comprehensiveInfo.nickName;
}
- (NSString *)avatarURL {
    return _comprehensiveInfo.avatarURL;
}
- (NSUInteger)gender {
    return _comprehensiveInfo.gender;
}
- (NSString *)birthday {
    return _comprehensiveInfo.birthday;
}
- (NSString *)location {
    return _comprehensiveInfo.location;
}
- (NSString *)sign {
    return _comprehensiveInfo.sign;
}

- (NSString *)originalAvatarURL {
    return _comprehensiveInfo.originalAvatarURL;
}
- (NSString *)compressionAvatarURL {
    return _comprehensiveInfo.compressionAvatarURL;
}
- (NSString *)thumbnailAvatarURL {
    return _comprehensiveInfo.thumbnailAvatarURL;
}

- (NSString *)displayName {
    NSString *result = _comprehensiveInfo.nickName;
    if(result.length <= 0 && _comprehensiveInfo.mobile.length > 0){
        result = [self p_privacyMobile];//如果返回手机号,需要对其进行特殊处理(如:13512345698 显示成:135...5698)
    }
    result = result == nil ? @"" : result;
    return result;
}
- (NSString *)p_privacyMobile {
    NSString *result = [NSString phoneNumToAsterisk:[self telephoneNum]];
    return result;
}

- (NSString *)displayNameNoPrivacy {
    NSString *result = _comprehensiveInfo.nickName;
    if(result.length <= 0){
        result = _comprehensiveInfo.mobile;
    }
    result = result == nil ? @"" : result;
    return result;
}

- (BOOL)isInfoIntegrity {
    BOOL result = NO;
    if(_comprehensiveInfo){
        result = _comprehensiveInfo.nickName.length > 0 /*&& _comprehensiveInfo.avatarURL.length > 0*/;
    }
    return result;
}

- (NSString *)areaCode {
    NSString *result = @"";
    NSString *tempMobile = [_comprehensiveInfo.mobile copy];
    if([tempMobile isKindOfClass:[NSString class]] && [tempMobile containsString:@"-"]){
        NSArray *strArray = [tempMobile componentsSeparatedByString:@"-"];
        if(strArray && strArray.count == 2){
            result = strArray[0];
        }
    }
    return result;
}
- (NSString *)telephoneNum {
    NSString *tempMobile = [_comprehensiveInfo.mobile copy];
    NSString *result = tempMobile;
    if([tempMobile isKindOfClass:[NSString class]] && [tempMobile containsString:@"-"]){
        NSArray *strArray = [tempMobile componentsSeparatedByString:@"-"];
        if(strArray && strArray.count == 2){
            result = strArray[1];
        }
    }
    return result;
}

@end

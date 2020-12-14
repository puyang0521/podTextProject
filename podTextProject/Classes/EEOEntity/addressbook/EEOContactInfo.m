//
//  EEOContactInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOContactInfo.h"

@implementation EEOContactInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _userInfo = [[EEOUserInfo alloc] init];
        
        _isReminderMessage = YES;//默认可打扰
    }
    return self;
}

- (NSUInteger)hash {
    return [self.uid hash];
}

- (void)cloneContactInfo:(EEOContactInfo *)contactInfo {
    self.lastContactTime = contactInfo.lastContactTime;
    self.isReminderMessage = contactInfo.isReminderMessage;
    self.isInvalid = contactInfo.isInvalid;
    
    [self.userInfo cloneUserInfo:contactInfo.userInfo];
}

- (NSNumber *)uid {
    return _userInfo.uid;
}
- (NSString *)displayName {
    return _userInfo.displayName;
}
/*
- (EEOUserBasicInfo *)basicInfo {
    return _userInfo.basicInfo;
}
- (EEOUserDeepInfo *)deepInfo {
    return _userInfo.deepInfo;
}
- (EEOUserAvatarInfo *)avatarInfo {
    return _userInfo.avatarInfo;
}
*/

@end

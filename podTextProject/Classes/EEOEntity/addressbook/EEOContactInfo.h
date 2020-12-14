//
//  EEOContactInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOUserInfo.h"

typedef NS_ENUM(NSUInteger, ContactMsgFlags) {
    ContactMsgFlags_isReminderMessage = 0x00000001,
};
@interface EEOContactInfo : NSObject

@property (nonatomic,assign) NSTimeInterval lastContactTime;
@property (nonatomic,assign) BOOL isReminderMessage;
@property (nonatomic,assign) BOOL isInvalid;//好友关系是否已失效

@property (nonatomic,strong) EEOUserInfo *userInfo;

- (void)cloneContactInfo:(EEOContactInfo *)contactInfo;

- (NSNumber *)uid;
- (NSString *)displayName;
/*
- (EEOUserBasicInfo *)basicInfo;
- (EEOUserDeepInfo *)deepInfo;
- (EEOUserAvatarInfo *)avatarInfo;
*/

@end

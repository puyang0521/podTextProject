//
//  EEOUser.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

///用户推送消息种类，多个设置相加即可，比如 UserPushMsgCategories_Basic | UserPushMsgCategories_Lesson
///判断一个数值是否包含上课提醒类消息，可以使用 (MsgCategoriesNum & UserPushMsgCategories_Lesson) != 0
typedef NS_ENUM(uint64_t, UserPushMsgCategories) {
    UserPushMsgCategories_Unknown = 0x0,
    UserPushMsgCategories_Basic = 0x1,//普通消息类
    UserPushMsgCategories_Lesson = 0x2,//上课提醒类
    UserPushMsgCategories_Homework = 0x4,//作业消息类
    UserPushMsgCategories_Exam = 0x8,//测验消息类
};

typedef NS_ENUM(uint64_t, UserPrivacyFlag) {
    UserPrivacyFlag_Unknown = 0x0,
    UserPrivacyFlag_PersonalInfo_NotOpenToStrangers = 0x1,//个人信息不对陌生人（非好友）开放
    UserPrivacyFlag_PersonalInfo_NotOpenToFriends = 0x2,//个人信息不对好友开放
    UserPrivacyFlag_Search_NoPhoneNumber = 0x4,//不允许通过手机号搜索到我
    UserPrivacyFlag_FriendRequest_NoPhoneNumber = 0x8,//不允许通过手机号添加我为好友
    UserPrivacyFlag_FriendRequest_NoQRCode = 0x10,//不允许通过二维码添加我为好友
    UserPrivacyFlag_FriendRequest_NoClassGroup = 0x20,//不允许通过班级群添加我为好友
    UserPrivacyFlag_CourseScheduling_NotAllowed = 0x40,//不允许被动排课
};

@interface EEOUserConfigInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) NSUInteger contactorAuth;
@property (nonatomic,assign) NSUInteger passwordStrength;
@property (nonatomic,copy) NSNumber *cloudDiskID;
@property (nonatomic,copy) NSNumber *privacyFlags;

- (void)cloneConfigInfo:(EEOUserConfigInfo *)cfgInfo;

/// 判断某个标志位是打开还是关闭
/// @param flag UserPrivacyFlag枚举
- (BOOL)isOpenWithPrivacyFlag:(UserPrivacyFlag)flag;

@end
@interface EEOUserComprehensiveInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *timeTag;
/**
 手机号,带区号的格式:00852-1530****402
 */
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *nickName;
/**
 用户头像url,一个json字符串,包含了缩略图、预览图、原图链接,界面不需要使用这个字段
 */
@property (nonatomic,copy) NSString *avatarURL;
@property (nonatomic,assign) NSUInteger gender;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *sign;

/**
 原图地址
 */
@property (nonatomic,copy,readonly) NSString *originalAvatarURL;
/**
 压缩(预览)图地址
 */
@property (nonatomic,copy,readonly) NSString *compressionAvatarURL;
/**
 缩略图地址
 */
@property (nonatomic,copy,readonly) NSString *thumbnailAvatarURL;

- (void)cloneComprehensiveInfo:(EEOUserComprehensiveInfo *)comprehensiveInfo;

@end
@interface EEOUserInfo : NSObject<NSCopying>

/**
 类属性,表示自己的用户信息
 */
@property (class,nonatomic) EEOUserInfo *mine;

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,strong) EEOUserConfigInfo *configInfo;
@property (nonatomic,strong) EEOUserComprehensiveInfo *comprehensiveInfo;

- (instancetype)initWithUID:(NSNumber *)uid;

- (void)cloneUserInfo:(EEOUserInfo *)userInfo;

- (unsigned long long)cfgTimeTagNum;
- (NSNumber *)cloudDiskID;
- (unsigned long long)infoTimeTagNum;
- (NSString *)mobile;
- (NSString *)nickName;
- (NSString *)avatarURL;
- (NSUInteger)gender;
- (NSString *)birthday;
- (NSString *)location;
- (NSString *)sign;

- (NSString *)originalAvatarURL;
- (NSString *)compressionAvatarURL;
- (NSString *)thumbnailAvatarURL;

/**
 @return 用户显示名,如果有昵称则返回昵称否则返回手机号
 */
- (NSString *)displayName;
/**
 @return 不带*号的显示名
 */
- (NSString *)displayNameNoPrivacy;

/**
 判断用户资料是否完善,判断规则为是否设置了昵称和头像
 */
- (BOOL)isInfoIntegrity;

- (NSString *)areaCode;
- (NSString *)telephoneNum;

@end

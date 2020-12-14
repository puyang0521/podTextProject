//
//  EEOConversationInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EEOUserInfo.h"
#import "EEOCourseScheduleInfo.h"
#import "EEOContactInfo.h"
#import "EEOClassInfo.h"

typedef NS_ENUM(NSUInteger,ConversationType){
    ConversationType_Unknown,
    ConversationType_System,
    ConversationType_Chat,
};
@interface EEOConversationInfo : NSObject<NSCopying>

@property (nonatomic,assign) NSUInteger conversationID;
@property (nonatomic,assign) NSUInteger unreadMsgCount;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSData *avatarData;
@property (nonatomic,assign) BOOL isReminderMessage;
@property (nonatomic,copy) NSString *lastContent;
@property (nonatomic,assign) NSTimeInterval lastTime;

- (BOOL)isMessageConversation;

@end

typedef NS_ENUM(NSUInteger,SystemConversationType){
    SystemConversationType_Unknown,
    SystemConversationType_Helper,
};
@class UIImage;
@interface EEOSystemConversationInfo : EEOConversationInfo

@property (nonatomic,assign) SystemConversationType systemType;
@property (nonatomic,copy) UIImage *systemIcon;

@end

typedef NS_ENUM(NSUInteger,ChatConversationType){
    ChatConversationType_Unknown,
    ChatConversationType_Contact,//联系人(私聊)
    ChatConversationType_Class,//班级(群聊)
    ChatConversationType_Classroom,//教室
};
@interface EEOChatConversationInfo : EEOConversationInfo

@property (nonatomic,copy) NSNumber *chatID;//对方的id或班级的id
@property (nonatomic,assign) ChatConversationType chatType;

@property (nonatomic,weak) EEOContactInfo *contactInfo;
@property (nonatomic,weak) EEOClassInfo *classInfo;

@property (nonatomic,copy) NSNumber *lastSenderId;
@property (nonatomic,weak) EEOUserInfo *lastSenderUserInfo;

@property (nonatomic,assign) NSUInteger lastSenderMessageId;
@property (nonatomic,assign) NSUInteger lastSenderMessageStatus;

@property (nonatomic,weak) EEOCourseInfo *courseInfo;

- (NSString *)lastSenderName;

- (EEOClassMemberInfo *)memberInfoWithUID:(NSNumber *)uid;

@end

@interface EEOSessionInfo : NSObject

@property (nonatomic,copy) NSNumber *sessionID;//classID或courseID(classID与courseID是保持一致的)
@property (nonatomic,assign) NSUInteger sessionType;//暂时不用
@property (nonatomic,assign) NSUInteger unreadCount;
@property (nonatomic,assign) BOOL isDisplay;

@property (nonatomic,strong) EEOClassInfo *classInfo;
/**
 注意::该课程对象只用于首页显示课节信息，如果班级聊天页面需要获取courseInfo请使用classInfo.courseInfo
 */
@property (nonatomic,strong) EEOCourseInfo *courseInfo;

/**
聊天草稿
*/
@property (nonatomic,copy) NSString *chatDraft;

/**
聊天草稿更新的时间戳
*/
@property (nonatomic,assign) NSTimeInterval chatDraftTimestamp;

- (instancetype)initWithSessionID:(NSNumber *)sessionID;

- (NSString *)title;
- (NSString *)iconURL;

- (BOOL)isClassSession;
- (BOOL)isReminderMessage;

@end

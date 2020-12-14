//
//  EEOConversationInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOConversationInfo.h"

#import <UIKit/UIImage.h>

@implementation EEOConversationInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOConversationInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.conversationID = self.conversationID;
    copyObj.unreadMsgCount = self.unreadMsgCount;
    copyObj.title = self.title;
    copyObj.avatarData = self.avatarData;
    copyObj.isReminderMessage = self.isReminderMessage;
    copyObj.lastContent = self.lastContent;
    copyObj.lastTime = self.lastTime;
    return copyObj;
}

- (BOOL)isMessageConversation{
    return NO;
}

@end

@implementation EEOSystemConversationInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOSystemConversationInfo *copyObj = [super copyWithZone:zone];
    copyObj.systemType = self.systemType;
    copyObj.systemIcon = self.systemIcon;
    return copyObj;
}

@end

@implementation EEOChatConversationInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOChatConversationInfo *copyObj = [super copyWithZone:zone];
    copyObj.chatID = self.chatID;
    copyObj.chatType = self.chatType;
    copyObj.contactInfo = self.contactInfo;
    copyObj.lastSenderId = self.lastSenderId;
    copyObj.lastSenderUserInfo = self.lastSenderUserInfo;
    copyObj.lastSenderMessageId = self.lastSenderMessageId;
    copyObj.lastSenderMessageStatus = self.lastSenderMessageStatus;
    copyObj.courseInfo = self.courseInfo;
    copyObj.classInfo = self.classInfo;
    return copyObj;
}

- (BOOL)isReminderMessage {
    BOOL result = [super isReminderMessage];
    if(_chatType == ChatConversationType_Contact && _contactInfo){
        result = [_contactInfo isReminderMessage];
    }else if(_chatType == ChatConversationType_Class && _classInfo){
        result = [_classInfo isReminderMessage];
    }
    return result;
}
- (NSString *)title {
    NSString *result = [super title];
    if(_chatType == ChatConversationType_Contact && _contactInfo){
        result = [_contactInfo displayName];
    }else if(_chatType == ChatConversationType_Class && _classInfo){
        result = [_classInfo displayName];
    }else if(_courseInfo && _courseInfo.displayName.length > 0){//TODO...
        result = [_courseInfo displayName];
    }
    return result;
}
- (NSData *)avatarData {
    NSData *result = [super avatarData];
    if(_chatType == ChatConversationType_Contact && _contactInfo){
//        result = _contactInfo.avatarInfo.avatarData;
    }else if(_chatType == ChatConversationType_Class && _classInfo){
//        result = _classInfo.avatarData;
    }else if(_chatType == ChatConversationType_Class && _courseInfo){
//        result = _courseInfo.iconData;
    }
    return result;
}

- (NSString *)lastSenderName {
    NSString *result = @"";
    if(_lastSenderUserInfo){
        result = [_lastSenderUserInfo displayName];
    }
    return result;
}

- (BOOL)isMessageConversation {
    BOOL result = NO;
    if(_chatType == ChatConversationType_Contact){
        result = _contactInfo != nil;
    }else if(_chatType == ChatConversationType_Class){
        result = _classInfo != nil;
    }
    return result;
}

- (EEOClassMemberInfo *)memberInfoWithUID:(NSNumber *)uid {
    EEOClassMemberInfo *result = nil;
    if(_classInfo){
        result = [_classInfo memberWithUID:uid];
    }
    return result;
}

@end

@implementation EEOSessionInfo

- (instancetype)init {
    return [self initWithSessionID:@(0)];
}
- (instancetype)initWithSessionID:(NSNumber *)sessionID {
    self = [super init];
    if(self){
        _sessionID = sessionID;
        _isDisplay = YES;
    }
    return self;
}

- (NSString *)title {
    NSString *result = _classInfo ? [_classInfo displayName] : @"";
    if(result.length <= 0 && _courseInfo && _courseInfo.displayName.length > 0){
        result = _courseInfo.displayName;
    }
    return result;
}
- (NSString *)iconURL {
    NSString *result = @"";
    if(_classInfo && _classInfo.thumbnailAvatarURL.length > 0){
        result = _classInfo.thumbnailAvatarURL;
    }else if(_courseInfo && _courseInfo.thumbnailAvatarURL.length > 0){
        result = _courseInfo.thumbnailAvatarURL;
    }
    return result;
}

- (BOOL)isClassSession {
    return _classInfo != nil;
}

- (BOOL)isReminderMessage {
    BOOL result = NO;
    if(_classInfo){
        result = [_classInfo isReminderMessage];
    }
    return result;
}

- (void)setCourseInfo:(EEOCourseInfo *)courseInfo {
    if(_courseInfo == courseInfo){
        return;
    }
    
    if(courseInfo == nil){
        NSArray *lessonList = [_courseInfo.lessonList copy];
        for (EEOLessonInfo *lessonInfo in lessonList) {
            lessonInfo.isStartCountdown = NO;
            lessonInfo.isCanEnter = NO;
            lessonInfo.isStartedFlag = NO;
        }
    }
    _courseInfo = courseInfo;
}

- (NSUInteger)unreadCount {
    NSUInteger result = _unreadCount;
    if(_classInfo){
        result = [_classInfo unreadMsgCount];
    }
    return result;
}

@end

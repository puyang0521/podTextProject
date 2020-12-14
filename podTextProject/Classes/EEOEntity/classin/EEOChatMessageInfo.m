//
//  EEOChatMessageInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOChatMessageInfo.h"
#import "EEOClassReminderInfo.h"
#import "NSString+EEO.h"
#import "NSDictionary+EEO.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation EEOChatMessageStanceItem

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOChatMessageStanceItem *copyObj = [self copyWithZone:zone];
    copyObj.leftMsgServerID = self.leftMsgServerID;
    copyObj.rightMsgServerID = self.rightMsgServerID;
    return copyObj;
}

- (NSUInteger)gap {
    NSUInteger result = 0;
    if(_leftMsgServerID && _rightMsgServerID){
        result = (NSUInteger)([_rightMsgServerID unsignedLongLongValue] - [_leftMsgServerID unsignedLongLongValue] - 1);
    }
    return result;
}

@end

@interface EEOChatMessageInfo (){
    NSString *_messageContent;
    NSMutableDictionary *_messageContentDic;
}
@end

@implementation EEOChatMessageInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _senderId = @(0);
        _serverMsgID = @(10001);//服务端的定义从10000开始
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOChatMessageInfo *copyObj = [super copyWithZone:zone];
    copyObj.type = self.type;
    copyObj.status = self.status;
    copyObj.senderId = self.senderId;
    copyObj.serverMsgID = self.serverMsgID;
    copyObj.hidden = self.isHidden;
    
    copyObj.senderUserInfo = self.senderUserInfo;//TODO...
    return copyObj;
}

- (NSDictionary *)messageContentDic{
    @synchronized (self) {
        if (!_messageContentDic) {
            NSDictionary *tempDic = [NSDictionary dictionaryWithJsonString:self.messageContent];
            if(tempDic && [tempDic isKindOfClass:[NSDictionary class]]){
                    _messageContentDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                if (self.type != ChatMessageType_Text) {
                    NSString *contentJsonString = [_messageContentDic objectForKey:@"content"];
                    if(contentJsonString){
                        NSDictionary *contentDic = [NSDictionary dictionaryWithJsonString:contentJsonString];
                        if (contentDic) {
                            [_messageContentDic setValue:contentDic forKey:@"content"];
                        }
                    }
                }
            }
        }
    }
    return [_messageContentDic copy];
}
- (id)contentDic {
    id result = self.messageContentDic[@"content"];
    if(result == nil){
        result = @"";
    }
    return result;
}

- (NSString *)messageContent {
    NSString *result = _messageContent;
    result = result == nil ? @"" : result;
    return result;
}

- (void)setMessageContent:(NSString *)messageContent{
    if([_messageContent isEqualToString:messageContent]){
        return;
    }
    @synchronized (self) {
        _messageContent = [messageContent copy];
        _messageContentDic = nil;
    }
}

- (NSString *)senderDisplayName {
    NSString *result = @"";
    if(_senderUserInfo){
        result = [_senderUserInfo displayName];
    }
    return result;
}
- (NSData *)senderAvatarData {
//    return _senderUserInfo.avatarInfo.avatarData;
    return nil;//TODO...
}

+(EEOChatMessageInfo *)chatWithContact:(EEOClassInfo *)classInfo withSenderId:(NSString *)senderId
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = @([senderId integerValue]);
    
    info.type = ChatMessageType_Card;
    
    EEOUserInfo *friendsInfo = [classInfo friendsInfo].userInfo;
    NSDictionary *contentDic = @{@"name":[classInfo displayName],
                                 @"mobile":friendsInfo.mobile,
                                 @"gender":@(friendsInfo.gender),
//                                 @"zodiac":@([contactInfo basicInfo].zodiac),//im3.0没有该字段
                                 @"location":friendsInfo.location,
                                 @"sign":friendsInfo.sign,
                                 @"uid":[friendsInfo uid]};
    
    
    NSString *contentStr = [NSString jsonStringWithObject:contentDic];
    
    NSDictionary * sendDic = @{@"type":@(ChatMessageType_Card),@"content":contentStr};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithText:(NSString *)contentText withSenderId:(NSString *)senderId
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = @([senderId integerValue]);
    
    info.type = ChatMessageType_Text;
    
    NSString *msgID = [NSString UUID];
    NSDictionary * sendDic = @{@"type":@(ChatMessageType_Text),@"content":contentText,@"msgID":msgID};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}


+(EEOChatMessageInfo *)chatWithImageID:(NSString *)imageID withSenderId:(NSString *)senderId
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = @([senderId integerValue]);
    
    info.type = ChatMessageType_Emote;
    
    NSString *msgID = [NSString UUID];
    NSDictionary * sendDic = @{@"type":@(ChatMessageType_Emote),@"content":imageID,@"msgID":msgID};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithImageID:(NSString *)imageID senderId:(NSString *)senderId  shareId:(NSNumber *)shareId
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = @([senderId integerValue]);
    
    info.type = ChatMessageType_Emote;
    
    NSDictionary *imageDic = @{@"shareId":shareId,
                               @"shareUid":info.senderId,
                               @"fileId":imageID
                               };
    NSString *imageDicStr = [NSString jsonStringWithDictionary:imageDic];
    
    
    NSDictionary * sendDic = @{@"type":@(ChatMessageType_Emote),@"content":imageDicStr};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithAudioID:(NSString *)audioID withSenderId:(NSString *)senderId andAudioLength:(NSInteger)length
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = @([senderId integerValue]);
    
    info.type = ChatMessageType_Audio;
    
    NSDictionary *contentDic = @{@"audioID":audioID,
                                 @"length":@(length)};
    
    NSDictionary * sendDic = @{@"type":@(ChatMessageType_Audio),@"content":contentDic};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithClassroomInfoDic:(NSDictionary *)classroomInfoDic withSenderId:(NSNumber *)senderId
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = senderId;
    
    info.type = ChatMessageType_TempClassroom;
    NSString *contentStr = [NSString jsonStringWithObject:classroomInfoDic];

    NSDictionary * sendDic = @{@"type":@(info.type),@"content":contentStr};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithCloudFileDic:(NSDictionary *)cloudFileDic withSenderId:(NSNumber *)senderId withShareUid:(NSNumber *)shareUid
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = senderId;
    
    info.type = ChatMessageType_CloudDriveFile;
    
    NSString *sizeStr = cloudFileDic[@"fileSize"];
    if ([NSString isPureInt:sizeStr]) {
        sizeStr = [@([sizeStr doubleValue] * 1024) stringValue];
    }
    
    NSDictionary *dic =@{@"fileId":cloudFileDic[@"shareId"],
                         @"fileName":[NSString stringWithFormat:@"%@.%@",cloudFileDic[@"fileName"],cloudFileDic[@"fileExtension"]],
                         @"fileSize":sizeStr,
                         @"shareUid":shareUid
                         };

    NSString *contentStr = [NSString jsonStringWithObject:dic];
    
    NSDictionary * sendDic = @{@"type":@(info.type),@"content":contentStr};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

/**
 {
 "type": 9, //免费会议消息类型
 "content":{
    "SID": 机构ID
    "CourseId": 课程ID
    "CID": 课节ID
    "TeacherName":老师名称
    "StartTime": 课节开始时间
    "MeetingTimeLength": 会议时长
    }
 }
 */
+(EEOChatMessageInfo *)chatWithMeetingInfoDic:(NSDictionary *)mettingInfoDic withSenderId:(NSNumber *)senderId {
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    
    info.senderId = senderId;
    
    info.type = ChatMessageType_Meeting;
    NSString *contentStr = [NSString jsonStringWithObject:mettingInfoDic];
    
    NSDictionary * sendDic = @{@"type":@(info.type),@"content":contentStr};
    
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+(EEOChatMessageInfo *)chatWithTipsType:(ChatTipsMessageType)tipsType tipsValue:(id)tipsValue
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.type = ChatMessageType_SystemTipes;
    NSDictionary *contentDic = @{@"tipsType":@(tipsType),
                                 @"tipsValue":tipsValue};
    NSDictionary * sendDic = @{@"type":@(info.type),@"content":contentDic};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    return info;
}

+(EEOChatMessageInfo *)chatTipsWithClassReminderInfo:(EEOClassReminderInfo *)reminderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.type = ChatMessageType_SystemTipes;
    info.messageTime = reminderInfo.messageTime;
    NSDictionary *tipsValue = @{@"reminderType":@(reminderInfo.reminderType),
                                @"reminderContent":reminderInfo.reminderContent,
                                @"isClassTeacher":@(reminderInfo.isClassTeacher)};
    NSDictionary *contentDic = @{@"tipsType":@(ChatTipsMessageType_ClassReminderInfo),
                                 @"tipsValue":tipsValue};
    NSDictionary *sendDic = @{@"type":@(info.type),@"content":contentDic};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    return info;
}

+ (NSString *)getChatMessageTypeTextWithType:(NSUInteger)type {
    NSString *chatMessageTypeStr = @"";
    switch (type) {
        case ChatMessageType_Text:{
            chatMessageTypeStr = @"纯文本";
            break;
        }
        case ChatMessageType_Emote:{
            chatMessageTypeStr = @"图片";
            break;
        }
        case ChatMessageType_Card:{
            chatMessageTypeStr = @"名片";
            break;
        }
        case ChatMessageType_Audio:{
            chatMessageTypeStr = @"音频文件";
            break;
        }
        case ChatMessageType_Video:{
            chatMessageTypeStr = @"视频文件";
            break;
        }
        case ChatMessageType_TempClassroom:{
            chatMessageTypeStr = @"临时教室";
            break;
        }
        case ChatMessageType_CloudDriveFile:{
            chatMessageTypeStr = @"云盘文件";
            break;
        }
        case ChatMessageType_Meeting:{
            chatMessageTypeStr = @"免费会议";
            break;
        }
        case ChatMessageType_HomeworkTemplate:{
            chatMessageTypeStr = @"作业";
            break;
        }
        case ChatMessageType_Mute:{
            chatMessageTypeStr = @"禁言消息";
            break;
        }
        case ChatMessageType_Emotion:{
            chatMessageTypeStr = @"表情包动图";
            break;
        }
        case ChatMessageType_Event:{
            chatMessageTypeStr = @"事件消息";
            break;
        }
        case ChatMessageType_ClassCard:{
            chatMessageTypeStr = @"班级名片";
            break;
        }
        default:
            chatMessageTypeStr = [NSString stringWithFormat:@"消息类型:%zi",type];
            break;
    }
    return chatMessageTypeStr;
}

- (id)getContentValueWithKey:(NSString *)key {
    id result = nil;
    //    NSString *jsonStr = self.messageContent;
    //    NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:jsonStr];
    //    NSDictionary *jsonObj = self.messageContentDic;
    //    if(jsonObj && [jsonObj isKindOfClass:[NSDictionary class]]){
    //        NSString *contentStr = [jsonObj objectForKey:@"content"];
    //        NSDictionary *contentObj = [NSDictionary dictionaryWithJsonString:contentStr];
    NSDictionary *contentObj = self.contentDic;
    if(contentObj && [contentObj isKindOfClass:NSDictionary.class]){
        result = contentObj[key];
    }
    return result;
}

- (NSString *)getChatMessageNotificationText{
    NSString *result = @"";
    if (self.type == ChatMessageType_Text) {
//        NSDictionary *messageDic = [NSDictionary dictionaryWithJsonString:self.messageContent];
        NSDictionary *contentDic = self.contentDic;
        if(contentDic && [contentDic isKindOfClass:NSString.class]){
            result = [contentDic copy];
        }
        if(result.length > 40){
            result = [result substringToIndex:37];
            result = [result stringByAppendingString:@"..."];
        }
    }else if (self.type == ChatMessageType_Emotion){
//        NSDictionary *messageDic = [NSDictionary dictionaryWithJsonString:self.messageContent];
//        NSDictionary *messageDic = self.messageContentDic;
//        if(messageDic){
//            NSString *contentStr = messageDic[@"content"];
//            NSDictionary *contentDic = [NSDictionary dictionaryWithJsonString:contentStr];
        NSDictionary *contentDic = self.contentDic;
        if (contentDic && [contentDic isKindOfClass:NSDictionary.class]) {
            result = contentDic[@"name_en"];;
        }
//        }
        if(result.length > 38){
            result = [result substringToIndex:35];
            result = [result stringByAppendingString:@"..."];
        }
        if (result.length > 0) {
            result = [NSString stringWithFormat:@"[%@]",result];
        }
    }
    return result;
}

- (BOOL)changeContentWithKey:(NSString *)key value:(id)value {
//    NSString *jsonStr = self.messageContent;
//    NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:jsonStr];
    NSDictionary *jsonObj = self.messageContentDic;
    if(jsonObj && [jsonObj isKindOfClass:NSDictionary.class] && value != nil){
//        NSString *contentStr = [jsonObj objectForKey:@"content"];
//        NSDictionary *contentObj = [NSDictionary dictionaryWithJsonString:contentStr];
        NSDictionary *contentObj = self.contentDic;
//        [jsonObj objectForKey:@"content"];
        if(contentObj && [contentObj isKindOfClass:NSDictionary.class]){
            NSMutableDictionary *contentObjMut = [NSMutableDictionary dictionaryWithDictionary:contentObj];
            contentObjMut[key] = value;
            NSString *contentStr = [NSString jsonStringWithDictionary:contentObjMut];
            NSMutableDictionary *jsonObjMut = [NSMutableDictionary dictionaryWithDictionary:jsonObj];
            jsonObjMut[@"content"] = contentStr;
            self.messageContent = [NSString jsonStringWithDictionary:jsonObjMut];
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}
- (BOOL)changeFileMessageSharedID:(NSNumber *)shareId {
    BOOL result = NO;
    if(_type == ChatMessageType_Emote && [self changeContentWithKey:@"shareId" value:shareId]){
        result = YES;
    }else if(_type == ChatMessageType_CloudDriveFile && [self changeContentWithKey:@"shareId" value:shareId]){
        result = YES;
    }else{
        //TODO...
    }
    return result;
}

- (BOOL)changeLocalContentWithKey:(NSString *)key value:(id)value{
    NSString *jsonStr = self.messageContent;
    if(jsonStr.length <= 0 || value == nil){
        return NO;
    }
//    NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:jsonStr];
    NSDictionary *jsonObj = self.messageContentDic;
    if(jsonObj){
        NSMutableDictionary *jsonObjOut = [NSMutableDictionary dictionaryWithDictionary:jsonObj];
        if(![jsonObjOut.allKeys containsObject:@"localContent"]){
            [jsonObjOut setValue:@{key : value} forKey:@"localContent"];
        }else{
            NSMutableDictionary *localContentDic = [NSMutableDictionary dictionaryWithDictionary:[jsonObjOut objectForKey:@"localContent"]];
            localContentDic[key] = value;
            jsonObjOut[@"localContent"] = localContentDic;
        }
        self.messageContent = [NSString jsonStringWithDictionary:jsonObjOut];
    }else{
        return NO;
    }
    return YES;
}

- (id)getLocalContentValueWithKey:(NSString *)key{
    id result = nil;
//    NSString *jsonStr = self.messageContent;
//    NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:jsonStr];
    NSDictionary *jsonObj = self.messageContentDic;
    if(jsonObj){
        if([jsonObj.allKeys containsObject:@"localContent"]){
            NSDictionary *localContentDic = jsonObj[@"localContent"];
            if([localContentDic.allKeys containsObject:key]){
                result = localContentDic[key];
            }
        }
    }
    return result;
}

- (BOOL)isRemoteMsg {
    BOOL result = _serverMsgID && [_serverMsgID unsignedLongLongValue] > 0;
    if(result){
        result = _status != ChatMessageStatus_Sendin && _status != ChatMessageStatus_SendFailed && _status != ChatMessageStatus_SendFailed_NotInClass && _status != ChatMessageStatus_SendFailed_ClassDeleted && _status != ChatMessageStatus_SendSoonToComplete;
    }
    return result;
}

/*------------ IM3.0新接口  ---------------*/
//文本消息
+ (EEOChatMessageInfo *)chatWithText:(NSString *)text senderInfo:(EEOUserInfo *)senderInfo{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Text;
    
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":text};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}
//图片消息
+ (EEOChatMessageInfo *)chatWithImageId:(NSString *)imageId senderInfo:(EEOUserInfo *)senderInfo shareId:(NSNumber *)shareId fileAttr:(NSInteger)fileAttr{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Emote;
    
    NSDictionary *imageDic = @{
                               @"shareId":shareId,
                               @"shareUid":senderInfo.uid,
                               @"fileId":imageId,
                               @"fileAttr":@(fileAttr),
                               };
    NSString *imageDicStr = [NSString jsonStringWithDictionary:imageDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":imageDicStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//临时教室
+(EEOChatMessageInfo *)chatWithTempClassroomWithDic:(NSDictionary *)classroomInfoDic senderInfo:(EEOUserInfo *)senderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_TempClassroom;
    
    NSString *contentStr = [NSString jsonStringWithObject:classroomInfoDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//名片消息
+(EEOChatMessageInfo *)chatWithUserInfoCard:(EEOUserInfo *)userInfo senderInfo:(EEOUserInfo *)senderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Card;
    
    //在后续处理中会增加一个avatarURL字段
    NSDictionary *contentDic = @{
                                 @"uid":userInfo.uid,
                                 @"name":[userInfo displayName],
                                 @"mobile":userInfo.mobile,
                                 @"gender":@(userInfo.gender),
                                 @"location":userInfo.location == nil ? @"" : userInfo.location,
                                 @"sign":userInfo.sign == nil ? @"" : userInfo.sign,
                                 @"birthday":userInfo.birthday == nil ? @"" : userInfo.birthday,
                                 };
    
    NSString *contentStr = [NSString jsonStringWithObject:contentDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//语音消息
+(EEOChatMessageInfo *)chatWithAudioID:(NSString *)audioID senderInfo:(EEOUserInfo *)senderInfo andAudioLength:(NSInteger)length
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Audio;
    
    NSDictionary *contentDic = @{@"audioID":audioID,
                                 @"length":@(length)};
    NSString *contentStr = [NSString jsonStringWithObject:contentDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//文件消息
+(EEOChatMessageInfo *)chatWithCloudFileDic:(NSDictionary *)cloudFileDic senderInfo:(EEOUserInfo *)senderInfo withShareUid:(NSNumber *)shareUid
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_CloudDriveFile;
    
    NSString *sizeStr = cloudFileDic[@"fileSize"];
//    if ([NSString isPureInt:sizeStr]) {
//        sizeStr = [@([sizeStr doubleValue] * 1024) stringValue];
//    }else
//        if (!([sizeStr containsString:@"b"] || [sizeStr containsString:@"B"])){
//        sizeStr = [@([sizeStr doubleValue] * 1024) stringValue];
//    }
    NSString *checkedSizeString = [sizeStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedSizeString.length <= 0 || ([checkedSizeString isEqualToString:@"."])) {
        sizeStr = [@([sizeStr doubleValue] * 1024) stringValue];
    }
    
    NSDictionary *dic =@{
                         @"shareId":cloudFileDic[@"shareId"],
                         @"fileName":[NSString stringWithFormat:@"%@.%@",cloudFileDic[@"fileName"],cloudFileDic[@"fileExtension"]],
                         @"fileSize":sizeStr,
                         @"shareUid":shareUid
                         };
    NSString *contentStr = [NSString jsonStringWithObject:dic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//表情消息
+(EEOChatMessageInfo *)chatWithEmotionDic:(NSDictionary *)emotionDic senderInfo:(EEOUserInfo *)senderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Emotion;
    
    NSString *contentStr = [NSString jsonStringWithObject:emotionDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//免费会议消息
+(EEOChatMessageInfo *)chatWithMeetingInfoDic:(NSDictionary *)mettingInfoDic senderInfo:(EEOUserInfo *)senderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Meeting;
    
    NSString *contentStr = [NSString jsonStringWithObject:mettingInfoDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

//禁言消息
+(EEOChatMessageInfo *)chatWithMuteDic:(NSDictionary *)muteDic senderInfo:(EEOUserInfo *)senderInfo
{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_Mute;
    
    NSString *contentStr = [NSString jsonStringWithObject:muteDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+ (EEOChatMessageInfo *)chatWithClassInfo:(EEOClassInfo *)classInfo senderInfo:(EEOUserInfo *)senderInfo{
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_ClassCard;
    
    //在后续处理中会增加一个avatarURL字段
    NSDictionary *contentDic = @{
                                 @"courseId":classInfo.classID,
                                 @"sid":classInfo.schoolID,
                                 @"name":[classInfo displayName],
                                 };
    
    NSString *contentStr = [NSString jsonStringWithObject:contentDic];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName],@"content":contentStr};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    
    return info;
}

+ (EEOChatMessageInfo *)chatWithHomeworkTemplateInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo {
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_HomeworkTemplate;
    NSDictionary *dict = @{@"shareId":[infoDic safeNumberObjectForKey:@"share_id"],
                           @"resourceId":[infoDic safeNumberObjectForKey:@"user_resource_id"],
                           @"resourceType":[infoDic safeNumberObjectForKey:@"user_resource_type"],
                           @"shareUid":senderInfo.uid,
                           @"fileName":[infoDic safeStringObjectForKey:@"user_resource_name"],
                           @"folderId":[infoDic safeNumberObjectForKey:@"folder_id"],
    };
    NSString *content = [NSString jsonStringWithDictionary:dict];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName], @"content":content};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];
    return info;
}

+ (EEOChatMessageInfo *)chatWithTestQuestionsInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo {
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_TestQuestions;
    NSDictionary *dict = @{@"shareId":[infoDic safeNumberObjectForKey:@"shareId"],
                           @"resourceId":[infoDic safeNumberObjectForKey:@"resourceId"],
                           @"resourceType":[infoDic safeNumberObjectForKey:@"shareType"],
                           @"shareUid":senderInfo.uid,
                           @"fileName":[infoDic safeStringObjectForKey:@"resourceName"],
                           @"folderId":[infoDic safeNumberObjectForKey:@"folderId"],
    };
    NSString *content = [NSString jsonStringWithDictionary:dict];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName], @"content":content};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];;
    return info;
}

+ (EEOChatMessageInfo *)chatWithTestPaperInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo {
    EEOChatMessageInfo *info = [[EEOChatMessageInfo alloc] init];
    info.senderId = senderInfo.uid;
    info.senderUserInfo = senderInfo;
    info.type = ChatMessageType_TestPaper;
    NSDictionary *dict = @{@"shareId":[infoDic safeNumberObjectForKey:@"shareId"],
                           @"resourceId":[infoDic safeNumberObjectForKey:@"resourceId"],
                           @"resourceType":[infoDic safeNumberObjectForKey:@"shareType"],
                           @"shareUid":senderInfo.uid,
                           @"fileName":[infoDic safeStringObjectForKey:@"resourceName"],
                           @"folderId":[infoDic safeNumberObjectForKey:@"folderId"],
    };
    NSString *content = [NSString jsonStringWithDictionary:dict];
    NSDictionary * sendDic = @{@"strTalker":[senderInfo displayName], @"content":content};
    info.messageContent = [NSString jsonStringWithDictionary:sendDic];;
    return info;
}

@end


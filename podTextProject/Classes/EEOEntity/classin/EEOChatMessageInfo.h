//
//  EEOChatMessageInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOMessageInfo.h"

#import "EEOUserInfo.h"

typedef NS_ENUM(NSUInteger,ChatMessageType){
    ChatMessageType_Text = 0,
    ChatMessageType_Emote = 1,
    ChatMessageType_TempClassroom = 2,
    ChatMessageType_Card = 3,
    ChatMessageType_Audio = 4,
    ChatMessageType_Video = 5,
    ChatMessageType_CloudDriveFile = 6,
    ChatMessageType_Event = 7,
    ChatMessageType_Emotion = 8,
    ChatMessageType_HomeworkTemplate = 9,//作业模版
    ChatMessageType_Meeting = 10,//免费会议
    ChatMessageType_Mute = 11,
    ChatMessageType_ClassCard = 13,
    ChatMessageType_TestQuestions = 14,//试题
    ChatMessageType_TestPaper = 15,//试卷
    ChatMessageType_SystemTipes = 0xFF
};

typedef NS_ENUM(NSUInteger,ChatMessageStatus){
    ChatMessageStatus_UnRead,//未读(只用于别人发送的消息)
    ChatMessageStatus_Read,//已读(只用于别人发送的消息)
    ChatMessageStatus_SendSoonToComplete,//发送即将完成的状态(只用于自己发送的消息，不显示Loading)
    ChatMessageStatus_Sendin,//发送中(只用于自己发送的消息，显示Loading)
    ChatMessageStatus_SendSuccessfully,//发送成功(只用于自己发送的消息)
    ChatMessageStatus_SendFailed,//发送失败(只用于自己发送的消息)
    ChatMessageStatus_SendFailed_ClassDeleted,//发送失败(只用于自己发送的消息,班级已解散)
    ChatMessageStatus_SendFailed_NotInClass,//发送失败(只用于自己发送的消息，自己被移出班级)
    ChatMessageStatus_Masked = 0xCC,//已屏蔽
    ChatMessageStatus_MaskedBySensitive = 0xCD,//因为敏感词被屏蔽
    ChatMessageStatus_Deleted = 0xEE,//已删除
    ChatMessageStatus_Canceled = 0xFF,//已撤销
    ChatMessageStatus_NotSupport = 0xFFFF,//不支持的消息
};

typedef NS_ENUM(NSUInteger,ChatTipsMessageType){
    ChatTipsMessageType_Unknown,
    ChatTipsMessageType_TargetAgreeMineContactRequest,//对方已经通过你的好友请求，打个招呼吧
    ChatTipsMessageType_MineAgreeTargetContactRequest,//你已通过对方的好友请求
    ChatTipsMessageType_MineCreateClassSuccess,//自己创建班级成功
    ChatTipsMessageType_AppointmentToClassTeacher,//被任命为班主任
    ChatTipsMessageType_CancelledAppointmentFromClassTeacher,//班主任身份被取消
    ChatTipsMessageType_ClassNameChanged,//班级名称被修改
    ChatTipsMessageType_MembersJoinClass,//有人加入了班级(需要根据自身角色来显示不同信息)
    ChatTipsMessageType_MineJoinToClass,//我加入了班级
    ChatTipsMessageType_MembersKickoutClass,//有人被移出了班级
    ChatTipsMessageType_MineKickoutFromClass,//我被移出了班级
    ChatTipsMessageType_MembersQuitClass,//有人主动退出了班级
    ChatTipsMessageType_MineQuitFromClass,//我主动退出了班级
    ChatTipsMessageType_ClassReminderInfo = 100,//班级提醒信息
    ChatTipsMessageType_ClassroomEstoppelGlobalFlagChanged = 200,//教室聊天全体学生禁言状态变更
    ChatTipsMessageType_ClassroomMineEstoppelFlagChanged = 201,//教室聊天内自己被禁言或取消禁言
    ChatTipsMessageType_ClassroomMemberEstoppelFlagChanged = 202,//教室聊天内别人被禁言或取消禁言
    ChatTipsMessageType_NewMessageTips = 500,//新消息分割线
};

typedef NS_ENUM(NSUInteger,ChatEventMessageType){
    ChatEventMessageType_StatusChanged = 1,//@{@"classStatus":status}
    ChatEventMessageType_NameChanged,//@{@"oldClassName":oldClassName,@"newClassName":className}
    ChatEventMessageType_OwnerChanged,//@{@"oldOwnerUID":oldOwnerUID,@"oldOwnerName":oldOwnerName,@"newOwnerUID":ownerUID,@"newOwnerName":ownerName}
    ChatEventMessageType_AddedMember,//@{@"memberInfoList":@[@[uid,name],...]}
    ChatEventMessageType_DeletedMember,//@{@"memberInfoList":@[@[uid,name],...]}
    ChatEventMessageType_NoticeChanged,//@{@"notice":notice}
};

@interface EEOChatMessageStanceItem : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *leftMsgServerID;//小
@property (nonatomic,copy) NSNumber *rightMsgServerID;//大

- (NSUInteger)gap;

@end

@class EEOClassInfo;
@class EEOClassReminderInfo;
@interface EEOChatMessageInfo : EEOMessageInfo

@property (nonatomic,assign) ChatMessageType type;
@property (nonatomic,assign) ChatMessageStatus status;
@property (nonatomic,copy) NSNumber *senderId;
@property (nonatomic,copy) NSNumber *serverMsgID;
@property (nonatomic,assign,getter=isHidden) BOOL hidden;

@property (nonatomic,strong) EEOUserInfo *senderUserInfo;

- (NSString *)senderDisplayName;
- (NSData *)senderAvatarData;

+(EEOChatMessageInfo *)chatWithContact:(EEOClassInfo *)classInfo withSenderId:(NSString *)senderId;

+(EEOChatMessageInfo *)chatWithText:(NSString *)contentText withSenderId:(NSString *)senderId;
//此方法仅在教室里聊天调用，暂时未做3.0修改
+(EEOChatMessageInfo *)chatWithImageID:(NSString *)imageID withSenderId:(NSString *)senderId;

+(EEOChatMessageInfo *)chatWithImageID:(NSString *)imageID senderId:(NSString *)senderId  shareId:(NSNumber *)shareId;

+(EEOChatMessageInfo *)chatWithAudioID:(NSString *)audioID withSenderId:(NSString *)senderId andAudioLength:(NSInteger)length;

+(EEOChatMessageInfo *)chatWithClassroomInfoDic:(NSDictionary *)classroomInfoDic withSenderId:(NSNumber *)senderId;

+(EEOChatMessageInfo *)chatWithCloudFileDic:(NSDictionary *)cloudFileDic withSenderId:(NSNumber *)senderId withShareUid:(NSNumber *)shareUid;

+(EEOChatMessageInfo *)chatWithMeetingInfoDic:(NSDictionary *)mettingInfoDic withSenderId:(NSNumber *)senderId;
/**
 tipsValue说明:
 ChatTipsMessageType_ClassNameChanged:{"oldName":nowCourseInfo.name,"nowName":info.name}
 */
+(EEOChatMessageInfo *)chatWithTipsType:(ChatTipsMessageType)tipsType tipsValue:(id)tipsValue;
/**
 根据班级提醒创建聊天提示信息

 @param info 班级提醒信息
 @return EEOChatMessageInfo
 */
+(EEOChatMessageInfo *)chatTipsWithClassReminderInfo:(EEOClassReminderInfo *)info;

+ (NSString *)getChatMessageTypeTextWithType:(NSUInteger)type;

- (id)getContentValueWithKey:(NSString *)key;
//发送聊天消息需要传的消息推送的内容
- (NSString *)getChatMessageNotificationText;

- (BOOL)changeContentWithKey:(NSString *)key value:(id)value;
- (BOOL)changeFileMessageSharedID:(NSNumber *)shareId;

//content增加本地字段 localContent:@{}，与strTalker、content同级别
- (BOOL)changeLocalContentWithKey:(NSString *)key value:(id)value;
- (id)getLocalContentValueWithKey:(NSString *)key;

- (BOOL)isRemoteMsg;

/*----------- IM3.0 --------------*/
/**
 文本消息
 */
+ (EEOChatMessageInfo *)chatWithText:(NSString *)text senderInfo:(EEOUserInfo *)senderInfo;
/**
 图片消息,    缩略图
 */
+ (EEOChatMessageInfo *)chatWithImageId:(NSString *)imageId senderInfo:(EEOUserInfo *)senderInfo shareId:(NSNumber *)shareId fileAttr:(NSInteger)fileAttr;
/**
 临时教室消息
 classroomInfoDic 为创建临时教室时PHP返回的json
 */
+(EEOChatMessageInfo *)chatWithTempClassroomWithDic:(NSDictionary *)classroomInfoDic senderInfo:(EEOUserInfo *)senderInfo;
/**
 名片消息
 */
+(EEOChatMessageInfo *)chatWithUserInfoCard:(EEOUserInfo *)userInfo senderInfo:(EEOUserInfo *)senderInfo;
/**
 语音消息
 */
+(EEOChatMessageInfo *)chatWithAudioID:(NSString *)audioID senderInfo:(EEOUserInfo *)senderInfo andAudioLength:(NSInteger)length;
/**
 文件消息
 */
+(EEOChatMessageInfo *)chatWithCloudFileDic:(NSDictionary *)cloudFileDic senderInfo:(EEOUserInfo *)senderInfo withShareUid:(NSNumber *)shareUid;
/**
 表情消息
 emotionDic{
    id: 表情ID
    pkgId: 表情包ID
    timeTag:表情最后修改时间
    source_src：表情url
    thumb_src: 表情缩略图url
    name_zh: 表情中文描述
    name_en: 表情英文文描述
    version:版本号
 }
 */
+(EEOChatMessageInfo *)chatWithEmotionDic:(NSDictionary *)emotionDic senderInfo:(EEOUserInfo *)senderInfo;
/**
 免费会议消息
 mettingInfoDic{
    SID: 机构ID
    CourseId：课程ID
    CID：课节ID
    TeacherName: 老师名字
    StartTime: 课节开始时间
    MeetingTimeLength: 会议时长
 }
*/
+(EEOChatMessageInfo *)chatWithMeetingInfoDic:(NSDictionary *)mettingInfoDic senderInfo:(EEOUserInfo *)senderInfo;
/**
 禁言消息
 //在后续处理中会增加一个OperatorName、TargetName字段
 muteDic  {
    Type: 0-全局禁言; 1-单独禁言
    OperatorUID：操作者UID
    IsMute: 是否禁言
    TargetUID: 操作对象UID(Type为1时有效)
    Duration: 禁言时长(分钟)(Type为1时有效)
  }
 */
+(EEOChatMessageInfo *)chatWithMuteDic:(NSDictionary *)muteDic senderInfo:(EEOUserInfo *)senderInfo;
/**
班级名片消息
*/
+(EEOChatMessageInfo *)chatWithClassInfo:(EEOClassInfo *)classInfo senderInfo:(EEOUserInfo *)senderInfo;

/** 作业模版 */
+ (EEOChatMessageInfo *)chatWithHomeworkTemplateInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo;
/** 试题 */
+ (EEOChatMessageInfo *)chatWithTestQuestionsInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo;
/** 试卷 */
+ (EEOChatMessageInfo *)chatWithTestPaperInfoDic:(NSDictionary *)infoDic senderInfo:(EEOUserInfo *)senderInfo;

@end


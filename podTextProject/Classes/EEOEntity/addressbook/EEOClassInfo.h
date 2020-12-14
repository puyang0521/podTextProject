//
//  EEOClassInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOUserInfo.h"
#import "EEOContactInfo.h"
#import "EEOCourseScheduleInfo.h"

/// 考试信息
@interface EEOExaminationInfo : NSObject<NSCopying>

//考试信息基本数据
@property (nonatomic,copy) NSNumber *courseID;
//单个考试信息(这些字段，只有当未读考试数为1或进行中考试数为1时，才有意义)
@property (nonatomic,copy) NSNumber *examID;//考试id
@property (nonatomic,copy) NSNumber *uid;//该考试信息对应的用户id
@property (nonatomic,copy) NSString *paperName;//考试名称
@property (nonatomic,assign) NSUInteger endTime;//考试结束时间

//统计信息
@property (nonatomic,assign) NSUInteger redTotal;//红点总数

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj;

- (void)cloneExaminationInfo:(EEOExaminationInfo *)examinationInfo;

/**
 是否只有一个考试信息
 由子类实现
 */
- (BOOL)isSingle;
//是否需要显示试题卡片
- (BOOL)isShowExamination;

@end
@interface EEOStudentExaminationInfo : EEOExaminationInfo

@property (nonatomic,assign) NSUInteger unreadTotal;//未读考试总数
@property (nonatomic,assign) NSUInteger unreadSubmit;//未读提交
@property (nonatomic,assign) NSUInteger unreadReview;//未读批阅

@end
@interface EEOTeacherExaminationInfo : EEOExaminationInfo

@property (nonatomic,assign) NSUInteger inProgress;//考试进行中总数
@property (nonatomic,assign) NSUInteger shouldStudent;//应试学生数
@property (nonatomic,assign) NSUInteger endStudent;//已交卷学生数

@end

/// 作业信息
@interface EEOHomeworkInfo : NSObject<NSCopying>

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj;

//作业数据的基本信息
@property (nonatomic,copy) NSNumber *homeworkID;
@property (nonatomic,copy) NSNumber *courseID;
@property (nonatomic,copy) NSNumber *teacherUID;//发布人的uid
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) BOOL isPublic;
@property (nonatomic,assign) NSUInteger endTime;
@property (nonatomic,assign) NSUInteger updateTime;
@property (nonatomic,assign) NSUInteger createTime;

//统计信息
@property (nonatomic,assign) NSUInteger memberNum;//需要答题的人数
@property (nonatomic,assign) NSUInteger submittedNum;//已提交的人数
@property (nonatomic,assign) NSUInteger notMarkingNum;//未批阅数

//因界面显示额外添加的属性
@property (nonatomic,strong) EEOUserInfo *teacherUserInfo;

- (void)cloneHomeworkInfo:(EEOHomeworkInfo *)homeworkInfo;

/**
 是否只有一个作业提醒
 */
- (BOOL)isSingle;

- (NSString *)teacherDisplayName;

@end
@interface EEOStudentHomeworkInfo : EEOHomeworkInfo

@property (nonatomic,copy) NSNumber *submitID;
@property (nonatomic,assign) NSUInteger submitStatus;//0：未提交 1：已提交 2：已批阅
@property (nonatomic,assign) NSUInteger warnTime;//提醒时间
@property (nonatomic,assign) BOOL isReform;//是否重做
@property (nonatomic,assign) BOOL isRead;//是否已读
@property (nonatomic,assign) NSUInteger markingNum;//当前作业被批阅次数

//统计信息
@property (nonatomic,assign) NSUInteger notSubmittedNum;//未提交的人数
@property (nonatomic,assign) NSUInteger notReadNum;//学生未查看已批阅作业数

@end
@interface EEOTeacherHomeworkInfo : EEOHomeworkInfo

//统计信息
@property (nonatomic,assign) NSUInteger ongoingNum;//老师进行中作业数

@end

@interface EEOClassChatMessageReceiptInfo : NSObject

@property (nonatomic,copy) NSNumber *msgID;
@property (nonatomic,assign) NSUInteger msgTimestamp;
@property (nonatomic,assign) NSUInteger msgCommand;
@property (nonatomic,assign) NSUInteger msgRspCode;
@property (nonatomic,copy) NSNumber *msgSequence;
@property (nonatomic,copy) NSData *msgAppendix;

@end

@class EEOChatMessageInfo;
@interface EEOClassLastMsgInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *lastMsgID;
@property (nonatomic,assign) NSUInteger displayableMsgNum;
@property (nonatomic,copy) NSNumber *atMsgID;//@MsgID
@property (nonatomic,copy) NSNumber *lastDisplayableMsgID;
@property (nonatomic,copy) NSNumber *lastDisplayableMsgSourceUID;
@property (nonatomic,assign) NSUInteger lastDisplayableMsgCommand;
@property (nonatomic,copy) NSData *lastDisplayableMsgData;
@property (nonatomic,assign) NSUInteger lastDisplayableMsgTimestamp;

/// 最后一条可显示消息对应的EEOChatMessageInfo实例
@property (nonatomic,strong) EEOChatMessageInfo *chatMessage;

@end

typedef NS_ENUM(NSUInteger, ClassMemberStatus) {
    ClassMemberStatus_Normal = 0,//正常
    ClassMemberStatus_Locked = 1,//锁定
    ClassMemberStatus_Deleted = 0xFF,//删除
};
typedef NS_ENUM(NSUInteger, GroupRole) {
    GroupRole_Ordinary = 0,
    GroupRole_Administrator = 1,
    GroupRole_Master = 0xFF,
};
typedef NS_ENUM(NSUInteger, ClassRole) {
    ClassRole_Unknown                 = 0x00,     // Invalid
    ClassRole_Student                 = 0x01,
    ClassRole_Auditor                 = 0x02,
    ClassRole_Teacher                 = 0x03,
    ClassRole_TeacherAssistant        = 0x04,
    ClassRole_PublicStudent           = 0x81,     // Student in public class
    ClassRole_PublicAuditor           = 0x82,     // Auditor in public class
    ClassRole_Master                  = 0xC1,
    ClassRole_MasterAssistant         = 0xC2,
    ClassRole_Administrator           = 0xFF,
};
typedef NS_ENUM(NSUInteger, ClassMemeberSettingsFlag) {
    ClassMemeberSettingsFlag_Mute = 0x1,//禁言
};
@interface EEOClassMemberInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) ClassMemberStatus status;
@property (nonatomic,assign) GroupRole groupRole;//群组角色
@property (nonatomic,assign) ClassRole role;//与教室相关的角色
/**
 群昵称(界面显示请调用displayName函数)
 */
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,assign) NSUInteger gender;//群名片性别
@property (nonatomic,copy) NSString *tel;//群名片电话
@property (nonatomic,copy) NSString *email;//群名片邮箱
@property (nonatomic,copy) NSString *comment;//群名片个人说明
@property (nonatomic,assign) NSUInteger memberSettings;//群成员设置
@property (nonatomic,assign) NSUInteger allowSpeakTime;//允许发言时间

@property (nonatomic,strong) EEOUserInfo *userInfo;

/** 附加属性 */
@property (nonatomic, getter = isSelected, assign) BOOL selected; //是否选中，在选择成员列表中使用

/**
 如果是好友则该值不为nil
 */
@property (nonatomic,weak) EEOContactInfo *contactInfo;

+ (void)saveClassMemberListToCache:(NSArray *)classMemberList classID:(NSNumber *)classID;
+ (EEOClassMemberInfo *)classMemberInfoByCacheWithUID:(NSNumber *)uid classID:(NSNumber *)classID;
+ (void)cleanClassMemberCacheWithClassID:(NSNumber *)classID;
+ (void)cleanAllClassMemberCache;

- (BOOL)isEqualToClassMemberInfo:(EEOClassMemberInfo *)target;
- (void)cloneClassMemberInfo:(EEOClassMemberInfo *)classMemberInfo;

- (BOOL)isClassTeacher;

- (NSUInteger)displayIndex;

- (void)setUID:(NSNumber *)uid;
- (NSNumber *)uid;
- (NSString *)displayName;

- (BOOL)isLeave;//是否已离开班级
- (BOOL)isMute;

@end

typedef NS_ENUM(NSUInteger, ClassMsgFlags) {
    ClassMsgFlags_isReminderMessage = 0x1,//消息免打扰
    ClassMsgFlags_isMessageTopping = 0x2,//消息置顶
    ClassMsgFlags_isHidden = 0x4,//隐藏群组
};
@interface EEOClassConfigInfo : NSObject

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,copy) NSString *alias;
@property (nonatomic,assign) NSUInteger msgSetting;
@property (nonatomic,assign) NSUInteger msgFlags;
@property (nonatomic,copy) NSString *externInfo;
@property (nonatomic,copy) NSNumber *readCursorMsgID;

- (void)cloneClassConfigInfo:(EEOClassConfigInfo *)configInfo;

@end
typedef NS_ENUM(NSUInteger, ClassType) {
    ClassType_Common = 0,//课程群
    ClassType_Contact = 1,//联系人聊天 (单聊)
    ClassType_Group = 2,//普通聊天群
};
typedef NS_ENUM(NSUInteger, ClassStatus) {
    ClassStatus_Normal = 0,//正常
    ClassStatus_Locked = 1,//锁定
    ClassStatus_Deleted = 0xFF,//删除
};
typedef NS_ENUM(NSUInteger, ClassAuthType) {
    ClassAuthType_AnyoneCanJoin = 0,//任何人可以加入
    ClassAuthType_RequireAuthentication = 1,//需要身份验证
    ClassAuthType_NoAdmission = 2,//不允许加入
};
typedef NS_ENUM(NSUInteger, ClassAttributeFlag) {
    ClassAttributeFlag_Single = 0x1,//单聊群
};
@class EEOClassInfo;
@protocol EEOClassInfoDelegate <NSObject>

- (void)classInfoNeedToLoadInfo:(EEOClassInfo *)classInfo;
- (void)classInfoNeedToLoadLastMsgInfo:(EEOClassInfo *)classInfo;

@end
@interface EEOClassInfo : NSObject

@property (nonatomic,weak) id<EEOClassInfoDelegate> delegate;//界面无需赋值

@property (nonatomic,copy) NSNumber *classID;
@property (nonatomic,assign) ClassType type;
@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,copy) NSNumber *schoolID;
@property (nonatomic,assign) ClassStatus status;
@property (nonatomic,copy) NSNumber *ownerUID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *classAttribute;
@property (nonatomic,assign) ClassAuthType authType;
@property (nonatomic,assign) NSUInteger memberCardPermission;
@property (nonatomic,assign) NSUInteger globalMemberSettings;
@property (nonatomic,copy) NSString *notice;
@property (nonatomic,copy) NSString *brief;

/**
 班级头像url,一个json字符串,包含了缩略图、预览图、原图链接,界面不需要使用这个字段
 */
@property (nonatomic,copy) NSString *avatarURL;

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
@property (nonatomic,copy) NSString *thumbnailAvatarURL;

@property (nonatomic,strong) EEOClassConfigInfo *configInfo;

/**
 用于首页显示的聊天信息
 */
@property (nonatomic,strong) EEOClassLastMsgInfo *lastMsgInfo;

/**
 包括已经不在班级内的成员信息
 */
@property (atomic,strong) NSMutableDictionary *memberMap;
//@property (nonatomic,strong) NSMutableArray<EEOClassMemberInfo *> *memberList;

/**
 与班级绑定的课程对象
 */
@property (nonatomic,strong) EEOCourseInfo *courseInfo;

@property (nonatomic,strong) EEOHomeworkInfo *homeworkInfo;

@property (nonatomic,strong) EEOExaminationInfo *examinationInfo;

- (instancetype)initWithClassID:(NSNumber *)classID;

- (BOOL)isEqualToClassInfo:(EEOClassInfo *)classInfo;

- (void)cloneClassInfo:(EEOClassInfo *)classInfo;

- (NSString *)displayName;
- (BOOL)isReminderMessage;
- (BOOL)isHidden;

- (BOOL)isGlobalMute;

- (EEOClassMemberInfo *)memberWithUID:(NSNumber *)uid;
- (EEOClassMemberInfo *)contactClassMemberInfoWithUID:(NSNumber *)uid;
- (NSArray *)memberList;

//获取好友
- (EEOClassMemberInfo *)friendsInfo;

//是否是单聊群
- (BOOL)isSingleClass;

- (NSUInteger)unreadMsgCount;

/// 允许任何人加入班级
- (BOOL)isAllowAnyoneJoinClass;
/// 班级内禁止互相添加好友
- (BOOL)isDontAddFriends;
/// 允许老师创建课节
- (BOOL)isAllowTeachersCreateLesson;
/// 禁止发起临时教室
- (BOOL)isDontCreateTempClassroom;
/// 分享出去的班级web页面需要显示加入班级入口
- (BOOL)isClassWebPageCanJoinClass;

/// 需要显示在界面上最后一条消息内容(该函数会触发按需加载，只能在界面显示时使用)
- (NSDictionary *)displayLastMessageContentDic;
@end

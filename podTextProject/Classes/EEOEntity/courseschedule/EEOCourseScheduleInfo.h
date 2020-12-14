//
//  EEOCourseScheduleInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EEOUserInfo.h"

typedef NS_ENUM(NSUInteger,LessonSettingFlag){
    LessonSettingFlag_AuthBoard              = 0x01,
    LessonSettingFlag_OnStage                = 0x02,
    LessonSettingFlag_Mute                   = 0x04,
    LessonSettingFlag_Kickout                = 0x08,
    LessonSettingFlag_Estoppel               = 0x10,
};

typedef NS_ENUM(NSUInteger, LessonStatus) {
    LessonStatus_Unknown = 0,
    LessonStatus_Normal = 1,
    LessonStatus_Reported = 2,
    LessonStatus_Locked = 0xFF,//被删除
};
typedef NS_ENUM(NSUInteger, LessonType) {
    LessonType_Unknown = 0,
    LessonType_Basic = 1,//普通教学专用
    LessonType_Temp = 2,//临时教室专用
    LessonType_Public = 3,//公开课专用
    LessonType_ShuangShi = 4,//双师课专用
    LessonType_Meeting = 5,//会议系统
    LessonType_Experience = 6,//体验教室
};
typedef NS_ENUM(uint64_t, LessonAttributeFlag) {
    LessonAttributeFlag_Unknown = 0x0,
    LessonAttributeFlag_NS = 0x1,//支持串号
    LessonAttributeFlag_HD = 0x2,//高清教室
    LessonAttributeFlag_FHD = 0x4,//全高清教室
    LessonAttributeFlag_CAMERA2 = 0x8,//支持副摄像头
    LessonAttributeFlag_CAM2_HD = 0x10,//高清副摄像头
    LessonAttributeFlag_CAM2_FHD = 0x20,//全高清副摄像头
    LessonAttributeFlag_Open = 0x40,//开放式教室
    LessonAttributeFlag_Open_Invite = 0x80,//可邀请开放式教室
    LessonAttributeFlag_HideSeatArea = 0x100,//隐藏坐席区
    LessonAttributeFlag_LargeScreen = 0x200,//大屏模式
};
typedef NS_ENUM(NSUInteger, LessonPublicType) {
    LessonPublicType_Unknown = 0,
    LessonPublicType_NonPublic = 1,
    LessonPublicType_Public = 2,
    LessonPublicType_PublicAuditor = 3,
};
typedef NS_ENUM(NSUInteger, LessonStudyType) {
    LessonStudyType_Unknown = 0,
    LessonStudyType_LiveClass = 1,
    LessonStudyType_VideoClass = 2,
};
typedef NS_ENUM(NSUInteger, LessonPrelectStatus) {
    LessonPrelectStatus_Unknown = 0,
    LessonPrelectStatus_NotStarted = 1,//未上课
    LessonPrelectStatus_OnProgress = 2,//上课中
    LessonPrelectStatus_Ended = 3,//已下课
    LessonPrelectStatus_ClosedInAdvance = 4,//未上课就已关闭
    LessonPrelectStatus_EndedAndClosed = 5,//下课后关闭
};
typedef NS_ENUM(NSUInteger, LessonVideoClassStatus) {
    LessonVideoClassStatus_Unknown = 0,
    LessonVideoClassStatus_NotUploaded = 1,
    LessonVideoClassStatus_Invalid = 2,
    LessonVideoClassStatus_Valid = 3,
};
typedef NS_ENUM(NSUInteger, LessonRole) {
    LessonRole_Unknown                 = 0x00,     // Invalid
    LessonRole_Student                 = 0x01,
    LessonRole_Auditor                 = 0x02,
    LessonRole_Teacher                 = 0x03,
    LessonRole_TeacherAssistant        = 0x04,
    LessonRole_PublicStudent           = 0x81,     // Student in public class
    LessonRole_PublicAuditor           = 0x82,     // Auditor in public class
    LessonRole_Master                  = 0xC1,
    LessonRole_MasterAssistant         = 0xC2,
    LessonRole_Administrator           = 0xFF,
};

@class EEOLessonUserRelationInfo;
@class EEOClassMemberInfo;
@interface EEOLessonMemberInfo : NSObject

- (instancetype)initWithUID:(NSNumber *)uid;

@property (nonatomic,strong) EEOUserInfo *userInfo;

@property (nonatomic,strong) EEOLessonUserRelationInfo *relationInfo;

@property (nonatomic,strong) EEOClassMemberInfo *classMemberInfo;

- (void)cloneLessonMemberInfo:(EEOLessonMemberInfo *)memberInfo;

- (NSNumber *)uid;
- (NSString *)displayName;

- (LessonRole)roleIdentity;
- (BOOL)isReleased;

@end
@interface EEOLessonMemberListInfo : NSObject

/**
 老师
 */
@property (nonatomic,copy) NSArray *teacherList;
/**
 助教
 */
@property (nonatomic,copy) NSArray *assistantList;
/**
 学生、插班生
 */
@property (nonatomic,copy) NSArray *studentList;
/**
 旁听
 */
@property (nonatomic,copy) NSArray *autidorList;

- (instancetype)initWitAllMember:(NSArray *)memberList;

@end

/**
 课节直播信息
 */
@interface EEOLessonVODInfo : NSObject

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) NSUInteger activity;//存储了录课/直播/回放3个状态
@property (nonatomic,copy) NSString *vodUpload;
@property (nonatomic,copy) NSString *vodDownload;

- (void)cloneLessonVODInfo:(EEOLessonVODInfo *)info;

@end
/**
 课节-用户关系
 */
@interface EEOLessonUserRelationInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) LessonRole roleIdentity;//LessonRole
@property (nonatomic,assign) BOOL isReleased;

- (void)cloneLessonUserRelationInfo:(EEOLessonUserRelationInfo *)info;

@end
@class EEOLessonInfo;
@protocol EEOLessonInfoDelegate <NSObject>

- (void)lessonInfoNeedToLoadInfo:(EEOLessonInfo *)lessonInfo;
- (void)lessonVODInfoNeedToLoadInfo:(EEOLessonInfo *)lessonInfo;
- (void)lessonTeacherClassMemberInfoNeedToLoadInfo:(EEOLessonInfo *)lessonInfo;

@end
/**
 课节信息
 */
@interface EEOLessonInfo : NSObject<NSCopying>

@property (class) NSDictionary *kRoleAheadTimeMap;

@property (nonatomic,weak) id<EEOLessonInfoDelegate> delegate;

@property (nonatomic,copy) NSNumber *courseID;
@property (nonatomic,copy) NSNumber *lessonID;
@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) LessonStatus status;
@property (nonatomic,assign) LessonType type;
@property (nonatomic,assign) NSUInteger lessonIndex;
@property (nonatomic,copy) NSNumber *lessonAttribute;
@property (nonatomic,assign) LessonPublicType publicType;
@property (nonatomic,assign) NSUInteger publicLimit;
@property (nonatomic,assign) NSUInteger startTime;
@property (nonatomic,assign) LessonStudyType studyType;
@property (nonatomic,assign) NSUInteger prelectTimeLength;
@property (nonatomic,assign) LessonPrelectStatus prelectStatus;
@property (nonatomic,copy) NSNumber *teacherUID;
@property (nonatomic,copy) NSString *teacherName;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *photoURL;
@property (nonatomic,copy) NSString *notice;
@property (nonatomic,copy) NSString *brief;
@property (nonatomic,copy) NSString *presetPublicCourseware;
@property (nonatomic,copy) NSArray *presetPrivateCoursewareList;
@property (nonatomic,copy) NSArray *lessonSettingsList;

@property (atomic,strong) EEOLessonVODInfo *vodInfo;
@property (nonatomic,strong) EEOLessonUserRelationInfo *relationInfo;

@property (nonatomic,strong) EEOUserInfo *teacherUserInfo;
@property (nonatomic,strong) EEOClassMemberInfo *teacherClassMemberInfo;

@property (nonatomic,assign) NSUInteger firstEnterTime;
@property (nonatomic,assign) NSUInteger lastExitTime;

@property (nonatomic,assign) BOOL isStartCountdown;//只在ClassIn模块使用...
@property (nonatomic,assign) BOOL isCanEnter;//只在ClassIn模块使用...
@property (nonatomic,assign) BOOL isStartedFlag;//只在ClassIn模块使用...
//@property (nonatomic,assign) BOOL isEndedFlag;//只在ClassIn模块使用...

@property (nonatomic,assign) NSUInteger memberTotalNum;//课节总人数
@property (nonatomic,assign) NSUInteger memberOnlineNum;//在教室的人数

- (BOOL)isEqualToLessonInfo:(EEOLessonInfo *)target;
- (void)cloneLessonInfo:(EEOLessonInfo *)info;

/// 是否加载了课节初始信息
- (BOOL)isLoadedInitialInfo;
/// 是否加载了完备信息
- (BOOL)isLoadedCompleteInfo;

- (NSString *)displayName;

- (BOOL)isEffectively;

- (NSUInteger)endTime;
- (NSUInteger)closeTime;

- (BOOL)isStarted;

- (BOOL)isNotStartedWithNowTime:(NSUInteger)nowTime;
- (BOOL)isStartedWithNowTime:(NSUInteger)nowTime;
- (BOOL)isCanEnterWithNowTime:(NSUInteger)nowTime;
- (BOOL)isStartCountdownWithNowTime:(NSUInteger)nowTime;
- (BOOL)isFinished;
- (BOOL)isFinishedWithNowTime:(NSUInteger)nowTime;
/// 根据状态和时间来判断课节是否已结束(进入拖堂时间也算作结束)
/// @param nowTime 当前时间
/// @param leeway 允许的时间差(单位:秒)
- (BOOL)isFinishedWithNowTime:(NSUInteger)nowTime leeway:(NSUInteger)leeway;
- (BOOL)isClosed;

- (BOOL)isSupportNS;
- (BOOL)isSupportHD;
- (BOOL)isSupportFHD;
- (BOOL)isSupportCamera2;
- (BOOL)isSupportCamera2HD;
- (BOOL)isSupportCamera2FHD;
- (BOOL)isSupportTeacherInvite;
- (BOOL)isSupportAllMemberInvite;
- (BOOL)isSupportHideSeatArea;
- (BOOL)isSupportLargeScreen;
- (NSUInteger)maxSeatNum;
- (BOOL)changeSettingsMaxNumWithFlag:(uint64_t)settingsFlag maxNum:(NSUInteger)maxNum;

- (BOOL)isRecording;//是否开启了录课
- (BOOL)isLive;//是否开启了直播
- (BOOL)isPlayback;//是否开启了回放
- (NSString *)vodUpload;
- (NSString *)vodDownload;

- (LessonRole)roleIdentity;
/**
 是否是老师
 */
- (BOOL)isTeacherMember;
/**
 是否是学生
 */
- (BOOL)isStudentMember;
/**
 是否是旁听成员
 */
- (BOOL)isAuditMember;
/**
 是否是校长或校长助理成员
 */
- (BOOL)isMasterMember;
/**
 是否已经退课
 */
- (BOOL)isReleased;

- (NSString *)teacherDisplayName;

/**
 判断自身在这节课中有没有学习数据报告

 @return bool
 */
- (BOOL)haveLearningDataReports;
/**
 判断自身在这节课中有没有视频录像
 
 @return bool
 */
- (BOOL)haveLearningVideo;

/**
 是否已经下课

 @return bool
 */
- (BOOL)isDismissed;

/**
 当课节类型为双师的情况下使用,用于判断是否是主课节

 @return bool
 */
- (BOOL)isMasterLesson;
/**
 当课节类型为双师的情况下,用于判断是否是该双师课的主讲老师且该节课为主课节
 
 @return bool
 */
- (BOOL)isSpeakerAndMasterLesson;

/**
 自身是否与课节无关,没有任何角色

 @return bool
 */
- (BOOL)isUnrelated;

/**
 0:表示可随时进入 1:表示不可提前进入 >1:表示具体秒数

 @return NSUInteger
 */
- (NSUInteger)aheadTime;

- (NSUInteger)aheadTimeWithRoleIdentity:(LessonRole)roleIdentity;

/**
 课程类型翻译为中文
 
 @return 返回中文课程类型名
 */
- (NSString *)lessonTypeTranslateChinese;

/// 根据课节类型判断是否存在班级，公开课、双师课、免费会议等没有对应的班级
- (BOOL)hasClassByType;

@end

/**
 课程-用户关系
 */
@interface EEOCourseUserRelationInfo : NSObject

@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) NSUInteger autoPayIdentity;//LessonRole
@property (nonatomic,assign) BOOL isReleased;
@property (nonatomic,assign) BOOL isMaster;

- (void)cloneCourseUserRelationInfo:(EEOCourseUserRelationInfo *)info;

@end
typedef NS_ENUM(NSUInteger, CourseStatus) {
    CourseStatus_Unknown = 0,
    CourseStatus_Normal = 1,
    CourseStatus_Reported = 2,
    CourseStatus_Deleted = 0xFF,
};
typedef NS_ENUM(NSUInteger, CourseType) {
    CourseType_Unknown = 0,
    CourseType_Normal = 1,
    CourseType_Temporary = 2,
    CourseType_Public = 3,
    CourseType_ShuangShi = 4,
    CourseType_Meeting = 5,//会议系统
    CourseType_Experience = 6,//体验教室
};
@class EEOCourseInfo;
@protocol EEOCourseInfoDelegate <NSObject>

- (void)courseInfoNeedToLoadInfo:(EEOCourseInfo *)courseInfo;
- (void)courseInfoNeedToLoadSchoolName:(EEOCourseInfo *)courseInfo;

@end
/**
 课程信息
 */
@interface EEOCourseInfo : NSObject

@property (nonatomic,weak) id<EEOCourseInfoDelegate> delegate;//界面无需赋值

@property (nonatomic,copy) NSNumber *courseID;
@property (nonatomic,copy) NSNumber *schoolID;
@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,copy) NSNumber *classTeacherUID;
@property (nonatomic,assign) CourseStatus status;
@property (nonatomic,assign) CourseType type;
@property (nonatomic,assign) NSUInteger attribute;
@property (nonatomic,assign) NSUInteger expiryTime;//0代表未过期
@property (nonatomic,assign) NSUInteger publicStudentLimit;
/// 如果是界面显示用到，请调用displayName函数
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *autoAppointTeacherUID;
@property (nonatomic,copy) NSString *autoAppointTeacherName;
@property (nonatomic,copy) NSString *photoURL;
@property (nonatomic,copy) NSString *brief;
@property (nonatomic,copy) NSString *keywords;//暂不使用
@property (nonatomic,copy) NSString *courseware;
@property (nonatomic,assign) NSUInteger createTime;

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

@property (nonatomic,strong) EEOCourseUserRelationInfo *relationInfo;

@property (nonatomic,strong) NSMutableArray<EEOLessonInfo*> *lessonList;

/// 调用该属性get方法会触发按需加载逻辑，所以仅在界面需要显示时才使用(该字段不存本地数据库)
@property (nonatomic,copy) NSString *schoolName;

- (BOOL)isEqualToCourseInfo:(EEOCourseInfo *)target;
- (void)cloneCourseInfo:(EEOCourseInfo *)courseInfo;

/// 是否加载了课程初始x信息
- (BOOL)isLoadedInitialInfo;

- (BOOL)isExpiredWithNowTime:(NSUInteger)nowTime;//课程是否已经结束

/// 只能在界面展示时调用该函数，这里会触发按需加载逻辑
- (NSString *)displayName;

- (BOOL)isPublic;
- (BOOL)isShuangShi;

- (BOOL)isDisplay;

- (BOOL)isTransferStudent;
- (BOOL)isReleased;
- (BOOL)mineIsClassTeacher;

- (NSUInteger)lessonTotal;

- (NSArray *)lessonListFromNotOver;//未结束的课节列表

- (EEOLessonInfo *)firstNotOverLesson;
- (NSUInteger)firstNotOverLessonStartTime;
- (NSUInteger)firstNotOverLessonEndTime;

- (EEOLessonInfo *)lessonWithID:(NSNumber *)lessonId;

- (void)addLessonInfoByThreadSafety:(EEOLessonInfo *)lessonInfo;
- (void)removeLessonInfoByThreadSafety:(EEOLessonInfo *)lessonInfo;

- (BOOL)hasNotOverLessonAndExistRoleWithNowTime:(NSUInteger)nowTime;

- (NSNumber *)minTimetag;

- (BOOL)isCompeletedWithNowTime:(NSUInteger)nowTime;//是否为已结课程。

/// 获取群简介，不会触发按需加载逻辑
- (NSString *)briefNoLoadOnDemand;

@end



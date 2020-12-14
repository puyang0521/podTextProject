//
//  EEOSchoolInfo.h
//  EEOEntity
//
//  Created by HeQian on 2017/6/16.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SchoolAssistantsRight) {
    SchoolAssistantsRight_Unknown = 0,
    SchoolAssistantsRight_Educational = 0x1,//教务管理
    SchoolAssistantsRight_SupervisorClasses = 0x2,//课堂监课
};

typedef NS_ENUM(NSUInteger, SchoolStatus) {
    SchoolStatus_Unknown = 0,
    SchoolStatus_Normal = 1,//正常
    SchoolStatus_BeReported = 2,//被举报
    SchoolStatus_OweFee = 3,//欠费
    SchoolStatus_Lock = 0xFF,//锁定
};
typedef NS_ENUM(NSUInteger, SchoolType) {
    SchoolType_Unknown = 0,
    SchoolType_Basic = 1,//普通教学专用
    SchoolType_Temp = 2,//临时教室专用
    SchoolType_Meeting = 5,//会议系统专用
};
typedef NS_ENUM(NSUInteger, SchoolAuthenticationStatus) {
    SchoolAuthenticationStatus_Unknown = 0,
    SchoolAuthenticationStatus_NotCertified = 1,//未认证
    SchoolAuthenticationStatus_Waiting = 2,//等待验证(认证中)
    SchoolAuthenticationStatus_NotPass = 3,//未通过
    SchoolAuthenticationStatus_Pass = 4,//通过
    SchoolAuthenticationStatus_CertificationDataNotProvided = 5,//未提供认证资料
};
typedef NS_ENUM(NSUInteger, SchoolServiceVersion) {
    SchoolServiceVersion_Institution = 0,//学校版
    SchoolServiceVersion_InstitutionPro = 1,//专业学校版
    SchoolServiceVersion_Free = 2,//免费版
    SchoolServiceVersion_Teacher = 3,//老师版
    SchoolServiceVersion_Colleges = 4,//高校版
};

typedef NS_ENUM(NSUInteger, WebSchoolServiceVersion) {
    WebSchoolServiceVersion_Unknown = 0,
    WebSchoolServiceVersion_Free = 1,//免费版
    WebSchoolServiceVersion_TeacherTrial = 2,//老师版(试用)
    WebSchoolServiceVersion_Teacher = 3,//老师版
    WebSchoolServiceVersion_InstitutionTrial = 4,//学校版(试用)
    WebSchoolServiceVersion_Institution = 5,//学校版
    WebSchoolServiceVersion_InstitutionPro = 6,//专业学校版
};

typedef NS_ENUM(NSUInteger, SchoolProperty) {
    SchoolProperty_Unknown = 0,
    SchoolProperty_Formal = 1,//正式机构
    SchoolProperty_Testing = 2,//测试机构
    SchoolProperty_Public = 3,//公益机构
};

@interface EEOSchoolFreeVersionCRModeSettingInfo : NSObject
@property (nonatomic, assign) NSUInteger onStageCount;
@property (nonatomic, assign) NSUInteger classroomTimeLength;

+ (EEOSchoolFreeVersionCRModeSettingInfo *)schoolCRModeSettingInfoWithDic:(NSDictionary *)dic;
@end

@interface EEOSchoolSettingInfo : NSObject

@property (nonatomic, assign) BOOL allowAddFriend;
@property (nonatomic, assign) BOOL allowAnyoneJoin;
@property (nonatomic, assign) BOOL allowQuitCourse;
@property (nonatomic, assign) BOOL allowTeacherAddClass;
@property (nonatomic, assign) BOOL assistant;
@property (nonatomic, assign) BOOL clientAddClass;
@property (nonatomic, assign) BOOL liveAndPlayback;
@property (nonatomic, assign) BOOL recordClass;
@property (nonatomic, assign) NSUInteger maxSeatNum;
@property (nonatomic, assign) NSUInteger courseAuditNum;
@property (nonatomic, assign) NSUInteger courseStudentNum;
@property (nonatomic, assign) NSUInteger authStatus;
@property (nonatomic, assign) NSUInteger freeClassroomTimeLength;
@property (nonatomic, assign) SchoolProperty webSchoolProperty;
@property (nonatomic, assign) WebSchoolServiceVersion webServiceVersion;
@property (nonatomic, strong) EEOSchoolFreeVersionCRModeSettingInfo *wisdomMode;
@property (nonatomic, strong) EEOSchoolFreeVersionCRModeSettingInfo *onlineMode;

+ (EEOSchoolSettingInfo *)schoolSettingInfoWithDic:(NSDictionary *)dic;

@end

@interface EEOSchoolInfo : NSObject

@property (class,nonatomic) EEOSchoolInfo *mine;

@property (nonatomic,copy) NSNumber *schoolId;
@property (nonatomic,copy) NSNumber *timeTag;
@property (nonatomic,assign) SchoolStatus status;
@property (nonatomic,assign) SchoolType type;
@property (nonatomic,assign) SchoolAuthenticationStatus authenticationStatus;
@property (nonatomic,assign) NSUInteger attribute;
@property (nonatomic,copy) NSString *ownerUserName;
@property (nonatomic,copy) NSString *ownerTrueName;
@property (nonatomic,copy) NSString *ownerIDCard;
@property (nonatomic,copy) NSString *ownerMobile;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *photoURL;
@property (nonatomic,copy) NSString *notice;
@property (nonatomic,copy) NSString *brief;
@property (nonatomic,copy) NSString *keywords;//暂不使用
@property (nonatomic,assign) NSUInteger createTime;

///从php接口中获取的数据
@property (nonatomic,copy) NSString *coverUrl;//机构默认班级头像
///从php接口中获取的数据
@property (nonatomic,strong) EEOSchoolSettingInfo *settingInfo;//web端机构配置信息

+ (void)saveCloudDiskId:(NSNumber *)number withSchoolId:(NSNumber *)schoolId;
+ (NSNumber *)cloudDiskIdWithSchoolId:(NSNumber *)schoolId;

+ (BOOL)isSchoolAssistantsEducationalRight:(NSUInteger)right;

- (instancetype)initWithSchoolId:(NSNumber *)schoolId;
- (instancetype)initWithSchoolId:(NSNumber *)schoolId webSettingDic:(NSDictionary *)dic;

- (void)cloneSchoolInfo:(EEOSchoolInfo *)schoolInfo;

/// 机构服务版本
- (SchoolServiceVersion)serviceVersion;

/// 是否为试用版
- (BOOL)isTrialVersion;

- (BOOL)isLoadedInitialInfo;

@end

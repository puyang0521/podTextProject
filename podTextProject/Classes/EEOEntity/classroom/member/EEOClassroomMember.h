//
//  EEOCRMember.h
//  EEOEntity
//
//  Created by HeQian on 16/4/11.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOUserInfo.h"
#import "EEOClassInfo.h"

typedef NS_ENUM(NSUInteger,ClassroomRoleIdentity){
    RoleUnknown         = 0x00,     /* 无效身份 */
    RoleStudent         = 0x01,     /* 指定的学生（教室固定人员） */
    RoleAuditor         = 0x02,     /* 指定的旁听（教室固定人员） */
    RoleTeacher         = 0x03,     /* 指定的讲师（教室固定人员） */
    RoleAssistant       = 0x04,     /* 指定的助教（教室固定人员） */
    RolePublicStudent   = 0x81,     /* 公开学生  （出现在允许公开授课教室中，非固定人员） */
    RolePublicAuditor   = 0x82,     /* 公开旁听  （出现在允许公开旁听教室中，非固定人员） */
    RoleMaster          = 0xC1,     /* 校长      （非固定人员） */
    RoleMasterAssistant = 0xC2,     /* 校长助理  （非固定人员） */
    RoleAdministrator   = 0xFF,     /* 巡检员    （非固定人员） */
};
typedef NS_ENUM(NSUInteger,ClassroomGroupRole){
    ClassroomGroupRole_Member         = 0x00,     /* 组员 */
    ClassroomGroupRole_Leader         = 0x01,     /* 组长 */
};

typedef NS_ENUM(NSUInteger,ClassroomUserSettings){
    ClassAuthBoard              = 0x01,
    ClassOnStage                = 0x02,
    ClassMute                   = 0x04,
    ClassKickout                = 0x08,
    ClassEstoppel               = 0x10,
};
typedef NS_ENUM(NSUInteger,ClassroomUserEquipmentsSettings){
    ClassroomUserEquipmentsSettings_Camera = 0x01,
    ClassroomUserEquipmentsSettings_Microphone = 0x02,
    ClassroomUserEquipmentsSettings_Speakers = 0x04,
    ClassroomUserEquipmentsSettings_Camera2 = 0x08,
    ClassroomUserEquipmentsSettings_Microphone2 = 0x10,
};

typedef NS_ENUM(NSUInteger,ClientType){
    ClientType_PC = 0x00,
    ClientType_iPhone = 0x01,
    ClientType_iPad = 0x02,
    ClientType_Web_Client = 0x03,
    ClientType_Android_Phone = 0x04,
    ClientType_Android_Pad = 0x05,
    ClientType_Android_TV = 0x06,
    ClientType_Web_Page = 0x1F,
};
typedef NS_ENUM(NSUInteger, ClientOSFlag) {
    ClientOSFlag_Unknonw = 0x00,
    ClientOSFlag_XP = 0x01,
    ClientOSFlag_Vista = 0x02,
    ClientOSFlag_Win7 = 0x03,
    ClientOSFlag_iOS = 0x04,
    ClientOSFlag_Linux = 0x05,
    ClientOSFlag_OSX = 0x06,
};

@interface EEOClassroomMemberSettings : NSObject<NSCopying>

@property (nonatomic,assign) uint64_t flags;
@property (nonatomic,assign) NSUInteger stageTime;
@property (nonatomic,assign) NSUInteger allowEnterTime;

- (void)cloneMemberSettings:(EEOClassroomMemberSettings *)settingsInfo;

@end
@interface EEOClassroomMember : NSObject<NSCopying>

@property (class,nonatomic) EEOClassroomMember *mine;

@property (nonatomic,assign) BOOL isOnline;
@property (nonatomic,assign) ClassroomRoleIdentity roleIdentity;
@property (nonatomic,assign) NSUInteger groupID;
@property (nonatomic,assign) ClassroomGroupRole groupRole;
/// 实时分组:是否隐身
@property (nonatomic,assign) BOOL groupIsInvisible;
@property (nonatomic,assign) NSUInteger plannedGroupID;
@property (nonatomic,assign) ClassroomGroupRole plannedGroupRole;
/// 预分组:是否隐身
@property (nonatomic,assign) BOOL plannedGroupIsInvisible;
@property (atomic,strong) EEOClassroomMemberSettings *userSettings;
@property (nonatomic,assign) uint64_t equipments;
@property (nonatomic,copy) NSString *alias;
@property (nonatomic,assign) ClientType clientType;
@property (nonatomic,assign) ClientOSFlag clientOSFlag;

/// get方法已被重写，只有界面显示时调用isAuthorized，其它时候请使用isAuthorizedByUserSettings
@property (nonatomic,assign) BOOL isAuthorized;
@property (nonatomic,assign) BOOL isOnStage;//是否显示视频窗口
@property (nonatomic,assign) BOOL isMute;
@property (nonatomic,assign) BOOL isEstoppel;
@property (nonatomic,assign) NSUInteger trophyCount;
@property (nonatomic,assign) BOOL isHandsUp;
@property (nonatomic,assign) BOOL isKickedOut;

@property (nonatomic,assign) BOOL isEnableCamera;
@property (nonatomic,assign) BOOL isEnableCamera2;
@property (nonatomic,assign) BOOL isCameraDisplayin;
@property (nonatomic,assign) BOOL isCamera2Displayin;
@property (nonatomic,assign) BOOL isEnableMicrophone;
@property (nonatomic,assign) BOOL isEnableMicrophone2;
@property (nonatomic,assign) BOOL isEnableSpeakers;

@property (nonatomic,strong) EEOUserInfo *userInfo;

@property (nonatomic,strong) EEOClassMemberInfo *classMemberInfo;

+ (instancetype)nativeTeacherClassroomMember;

+ (BOOL)isAuthorizeWithUserSettings:(NSNumber*)userSettings;
+ (BOOL)isOnStageWithUserSettings:(NSNumber*)userSettings;
+ (BOOL)isMuteWithUserSettings:(NSNumber*)userSettings;
+ (BOOL)isEstoppelWithUserSettings:(NSNumber*)userSettings;
+ (BOOL)isKickoutWithUserSettings:(NSNumber*)userSettings;

- (instancetype)initWithUserSettings:(NSNumber*)userSettings;

- (void)cloneMemberInfo:(EEOClassroomMember *)memberInfo;

- (BOOL)isTeacher;
- (BOOL)isAssistant;
- (BOOL)isStudent;
/// 是否是旁听生
- (BOOL)isAuditor;
- (BOOL)isSupervisors;

- (BOOL)isGroupLeader;

- (BOOL)isCompere;//教室主持人:老师和助教、组长

/// 是不是有最高权限:是老师或者助教
- (BOOL)haveHighestAuthority;

- (BOOL)isAVSession;//表示是否拥有与教室内其它成员的音视频会话权限

- (BOOL)isDisplayToSeat;
- (BOOL)isDisplayToList;

- (BOOL)canSendMicrophoneData;
- (BOOL)canSendMicrophone2Data;
- (BOOL)canSendCameraData;
- (BOOL)canSendCamera2Data;

- (void)changeEquipmentIsEnableStatusWithFlag:(NSNumber *)flag isEnable:(BOOL)isEnable;

- (NSNumber *)uid;
- (NSString *)displayName;

- (NSUInteger)offStageTime;

- (BOOL)canCarouselWithIsNeedCamera:(BOOL)isNeedCamera groupID:(NSUInteger)groupID;

- (BOOL)isAuthorizedByUserSettings;

/**
 自己在教室中的角色翻译

 @return 中文角色名
 */
- (NSString *)classroomRoleTranslateChinese;

@end

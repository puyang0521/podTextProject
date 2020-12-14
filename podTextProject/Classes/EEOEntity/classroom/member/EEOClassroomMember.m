//
//  EEOCRMember.m
//  EEOEntity
//
//  Created by HeQian on 16/4/11.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomMember.h"

#import "NSString+EEO.h"

@implementation EEOClassroomMemberSettings

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomMemberSettings *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.flags = self.flags;
    copyObj.stageTime = self.stageTime;
    copyObj.allowEnterTime = self.allowEnterTime;
    return copyObj;
}

- (void)cloneMemberSettings:(EEOClassroomMemberSettings *)settingsInfo {
    self.flags = settingsInfo.flags;
    self.stageTime = settingsInfo.stageTime;
    self.allowEnterTime = settingsInfo.allowEnterTime;
}

@end
@interface EEOClassroomMember(){
    
}

@end
@implementation EEOClassroomMember

static EEOClassroomMember *_mine = nil;
+ (instancetype)mine {
    if(_mine == nil){
        _mine = [[EEOClassroomMember alloc] init];
    }
    return _mine;
}
+ (void)setMine:(EEOClassroomMember *)mine {
    if(_mine != mine){
        _mine = mine;
    }
}

- (instancetype)init {
    return [self initWithUserSettings:@(0)];
}
- (instancetype)initWithUserSettings:(NSNumber*)userSettings {
    if(self = [super init]){
        self.userInfo = [[EEOUserInfo alloc] init];
        self.userInfo.comprehensiveInfo = [[EEOUserComprehensiveInfo alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomMember *member = [[[self class] allocWithZone:zone] init];
    member.isOnline = self.isOnline;
    member.roleIdentity = self.roleIdentity;
    member.groupID = self.groupID;
    member.groupRole = self.groupRole;
    member.groupIsInvisible = self.groupIsInvisible;
    member.plannedGroupID = self.plannedGroupID;
    member.plannedGroupRole = self.plannedGroupRole;
    member.plannedGroupIsInvisible = self.plannedGroupIsInvisible;
    member.userSettings = [self.userSettings copy];
    member.equipments = self.equipments;
    member.alias = self.alias;
    member.clientType = self.clientType;
    member.clientOSFlag = self.clientOSFlag;
    
    member.isAuthorized = self.isAuthorized;
    member.isOnStage = self.isOnStage;
    member.isMute = self.isMute;
    member.isEstoppel = self.isEstoppel;
    member.trophyCount = self.trophyCount;
    member.isHandsUp = self.isHandsUp;
    member.isKickedOut = self.isKickedOut;
    
    member.isEnableCamera = self.isEnableCamera;
    member.isEnableCamera2 = self.isEnableCamera2;
    member.isCameraDisplayin = self.isCameraDisplayin;
    member.isCamera2Displayin = self.isCamera2Displayin;
    member.isEnableMicrophone = self.isEnableMicrophone;
    member.isEnableMicrophone2 = self.isEnableMicrophone2;
    member.isEnableSpeakers = self.isEnableSpeakers;
    
    member.userInfo = [self.userInfo copy];
    
    member.classMemberInfo = [self.classMemberInfo copy];
    
    return member;
}
- (void)cloneMemberInfo:(EEOClassroomMember *)memberInfo {
    self.isOnline = memberInfo.isOnline;
    self.roleIdentity = memberInfo.roleIdentity;
    self.groupID = memberInfo.groupID;
    self.groupRole = memberInfo.groupRole;
    self.groupIsInvisible = memberInfo.groupIsInvisible;
    self.plannedGroupID = memberInfo.plannedGroupID;
    self.plannedGroupRole = memberInfo.plannedGroupRole;
    self.plannedGroupIsInvisible = memberInfo.plannedGroupIsInvisible;
    [self.userSettings cloneMemberSettings:memberInfo.userSettings];
    self.equipments = memberInfo.equipments;
    self.alias = memberInfo.alias;
    self.clientType = memberInfo.clientType;
    self.clientOSFlag = memberInfo.clientOSFlag;
    
    self.isAuthorized = memberInfo.isAuthorized;
    self.isOnStage = memberInfo.isOnStage;
    self.isMute = memberInfo.isMute;
    self.isEstoppel = memberInfo.isEstoppel;
    self.trophyCount = memberInfo.trophyCount;
    self.isHandsUp = memberInfo.isHandsUp;
    self.isKickedOut = memberInfo.isKickedOut;
    
    self.isEnableCamera = memberInfo.isEnableCamera;
    self.isEnableCamera2 = memberInfo.isEnableCamera2;
    self.isCameraDisplayin = memberInfo.isCameraDisplayin;
    self.isCamera2Displayin = memberInfo.isCamera2Displayin;
    self.isEnableMicrophone = memberInfo.isEnableMicrophone;
    self.isEnableMicrophone2 = memberInfo.isEnableMicrophone2;
    self.isEnableSpeakers = memberInfo.isEnableSpeakers;
    
    self.userInfo = memberInfo.userInfo;
    
    self.classMemberInfo = memberInfo.classMemberInfo;
}

+ (instancetype)nativeTeacherClassroomMember {
    EEOClassroomMember *result = [[EEOClassroomMember alloc] init];
    result.isOnline = YES;
    result.roleIdentity = RoleTeacher;
    
    result.isAuthorized = YES;
    result.isOnStage = YES;
    result.isMute = NO;
    result.isEstoppel = NO;
    result.trophyCount = 0;
    result.isHandsUp = NO;
    result.isKickedOut = NO;
    return result;
}

+ (BOOL)isAuthorizeWithUserSettings:(NSNumber*)userSettings {
    uint64_t temp = [userSettings unsignedLongLongValue];
    return (temp & ClassAuthBoard) != 0;
}
+ (BOOL)isOnStageWithUserSettings:(NSNumber*)userSettings {
    uint64_t temp = [userSettings unsignedLongLongValue];
    return (temp & ClassOnStage) != 0;
}
+ (BOOL)isMuteWithUserSettings:(NSNumber*)userSettings {
    uint64_t temp = [userSettings unsignedLongLongValue];
    return (temp & ClassMute) != 0;
}
+ (BOOL)isEstoppelWithUserSettings:(NSNumber*)userSettings {
    uint64_t temp = [userSettings unsignedLongLongValue];
    return (temp & ClassEstoppel) != 0;
}
+ (BOOL)isKickoutWithUserSettings:(NSNumber*)userSettings {
    uint64_t temp = [userSettings unsignedLongLongValue];
    return (temp & ClassKickout) != 0;
}

- (void)setUserSettings:(EEOClassroomMemberSettings *)userSettings {
    if(_userSettings == userSettings){
        return;
    }
    _userSettings = userSettings;
    
    NSNumber *userSettingsNum = @(_userSettings.flags);
    self.isAuthorized = [EEOClassroomMember isAuthorizeWithUserSettings:userSettingsNum];
    self.isOnStage = [EEOClassroomMember isOnStageWithUserSettings:userSettingsNum];
    self.isMute = [EEOClassroomMember isMuteWithUserSettings:userSettingsNum];
    self.isEstoppel = [EEOClassroomMember isEstoppelWithUserSettings:userSettingsNum];
    self.isKickedOut = [EEOClassroomMember isKickoutWithUserSettings:userSettingsNum];
}
- (void)setEquipments:(uint64_t)equipments {
    if(_equipments == equipments){
        return;
    }
    _equipments = equipments;
    
    self.isEnableCamera = (_equipments & ClassroomUserEquipmentsSettings_Camera) != 0;
    self.isEnableMicrophone = (_equipments & ClassroomUserEquipmentsSettings_Microphone) != 0;
    self.isEnableSpeakers = (_equipments & ClassroomUserEquipmentsSettings_Speakers) != 0;
    self.isEnableCamera2 = (_equipments & ClassroomUserEquipmentsSettings_Camera2) != 0;
    self.isEnableMicrophone2 = (_equipments & ClassroomUserEquipmentsSettings_Microphone2) != 0;
}

- (BOOL)isTeacher {
    return _roleIdentity == RoleTeacher;
}
- (BOOL)isAssistant {
    return _roleIdentity == RoleAssistant;
}
- (BOOL)isStudent {
    return _roleIdentity == RoleStudent;
}
- (BOOL)isAuditor {
    return _roleIdentity == RoleAuditor || _roleIdentity == RolePublicAuditor || [self isSupervisors];
}
- (BOOL)isSupervisors {
    return _roleIdentity == RoleMaster || _roleIdentity == RoleMasterAssistant || _roleIdentity == RoleAdministrator;
}

- (BOOL)isGroupLeader {
    return _groupID > 0 && _groupRole == ClassroomGroupRole_Leader;
}

- (BOOL)isCompere {
    return [self isTeacher] || [self isAssistant] || [self isGroupLeader];
}

- (BOOL)haveHighestAuthority {
    return [self isTeacher] || [self isAssistant];
}

- (BOOL)isAVSession {
    return [self isStudent] || [self isCompere];
}

- (BOOL)isDisplayToSeat {
    return _isOnline && _isOnStage;/*([self isCompere] || [self isStudent]) &&*/
}
- (BOOL)isDisplayToList {
    return /*_isOnline &&*/ ([self isCompere] || [self isStudent]);
}

- (BOOL)canSendMicrophoneData {
    return _isOnline && _isOnStage && _isEnableMicrophone && !_isMute;
}
- (BOOL)canSendMicrophone2Data {
    return _isOnline && _isOnStage && _isEnableMicrophone2 && !_isMute;
}
- (BOOL)canSendCameraData {
    return _isOnline && _isOnStage && _isEnableCamera;
}
- (BOOL)canSendCamera2Data {
    return _isOnline && _isOnStage && _isEnableCamera2;
}

- (BOOL)isAuthorized {
    if([self isCompere]){
        return YES;
    }
    return _isAuthorized && _isOnStage;
}

- (BOOL)isCameraDisplayin {
    return _isCameraDisplayin && _isOnStage;
}
- (BOOL)isCamera2Displayin {
    return _isCamera2Displayin && _isOnStage;
}

- (void)changeEquipmentIsEnableStatusWithFlag:(NSNumber *)flag isEnable:(BOOL)isEnable {
    uint64_t temp = [flag unsignedLongLongValue];
    if(temp == ClassroomUserEquipmentsSettings_Camera){
        self.isEnableCamera = isEnable;
    }else if(temp == ClassroomUserEquipmentsSettings_Microphone){
        self.isEnableMicrophone = isEnable;
    }else if(temp == ClassroomUserEquipmentsSettings_Speakers){
        self.isEnableSpeakers = isEnable;
    }else if(temp == ClassroomUserEquipmentsSettings_Camera2){
        self.isEnableCamera2 = isEnable;
    }else if(temp == ClassroomUserEquipmentsSettings_Microphone2){
        self.isEnableMicrophone2 = isEnable;
    }else{
    }
}

- (NSNumber *)uid {
    return _userInfo.uid;
}
- (NSString *)displayName {
    NSString *result = _alias;
    if(result.length <= 0){
        if(_classMemberInfo && _classMemberInfo.nickName.length > 0){
            result = _classMemberInfo.nickName;
        }else{
            result = [_userInfo displayName];
        }
    }
    result = result == nil ? @"" : result;
    return result;
}

- (NSUInteger)offStageTime {
    return _userSettings.stageTime;
}

- (BOOL)canCarouselWithIsNeedCamera:(BOOL)isNeedCamera groupID:(NSUInteger)groupID {
    BOOL result = _isOnline && [self isStudent] && !_isOnStage && _groupID == groupID;
    if(result && isNeedCamera){
        result = _isEnableCamera;
    }
    return result;
}

- (BOOL)isAuthorizedByUserSettings {
    return [[self class] isAuthorizeWithUserSettings:@(_userSettings.flags)];
}

- (NSString *)classroomRoleTranslateChinese{
    NSString *chineseRoleName = @"";
    switch (self.roleIdentity) {
        case RoleUnknown:
            chineseRoleName = @"无效身份";
            break;
        case RoleStudent:
            chineseRoleName = @"学生";
            break;
        case RoleAuditor:
            chineseRoleName = @"旁听生";
            break;
        case RoleTeacher:
            chineseRoleName = @"老师";
            break;
        case RoleAssistant:
            chineseRoleName = @"助教";
            break;
        case RolePublicStudent:
            chineseRoleName = @"公开的学生";
            break;
        case RolePublicAuditor:
            chineseRoleName = @"公开的旁听生";
            break;
        case RoleMaster:
            chineseRoleName = @"校长";
            break;
        case RoleMasterAssistant:
            chineseRoleName = @"校长助理";
            break;
        case RoleAdministrator:
            chineseRoleName = @"巡检员";
            break;
        default:
            chineseRoleName = [NSString stringWithFormat:@"未知角色:%ld",self.roleIdentity];
            break;
    }
    return chineseRoleName;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"classMemberUID=%@,groupID=%zi,plannedGroupID=%zi,equipments=%llu,isEnableCamera=%d,isEnableCamera2=%d,isEnableMicrophone=%d,isEnableMicrophone2=%d", _userInfo.uid,_groupID,_plannedGroupID,_equipments,_isEnableCamera,_isEnableCamera2,_isEnableMicrophone,_isEnableMicrophone2];
}

@end

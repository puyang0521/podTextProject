//
//  EEOSchoolInfo.m
//  EEOEntity
//
//  Created by HeQian on 2017/6/16.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import "EEOSchoolInfo.h"
#import "EEOLoginInfo.h"
#import "NSDictionary+EEO.h"
@implementation EEOSchoolFreeVersionCRModeSettingInfo

+ (EEOSchoolFreeVersionCRModeSettingInfo *)schoolCRModeSettingInfoWithDic:(NSDictionary *)dic {
    EEOSchoolFreeVersionCRModeSettingInfo *info = [[EEOSchoolFreeVersionCRModeSettingInfo alloc] init];
    info.onStageCount = [dic safeIntObjectForKey:@"onStageCount"];
    info.classroomTimeLength = [dic safeIntObjectForKey:@"classroomTimeLength"];
    return info;
}

@end

@implementation EEOSchoolSettingInfo

+(EEOSchoolSettingInfo *)schoolSettingInfoWithDic:(NSDictionary *)dic{
    EEOSchoolSettingInfo *schoolSettingInfo = [[EEOSchoolSettingInfo alloc] init];
    schoolSettingInfo.allowAddFriend = [[dic safeNumberObjectForKey:@"allowAddFriend"] boolValue];
    schoolSettingInfo.allowAnyoneJoin = [[dic safeNumberObjectForKey:@"allowAnyoneJoin"] boolValue];
    schoolSettingInfo.allowQuitCourse = [[dic safeNumberObjectForKey:@"allowQuitCourse"] boolValue];
    schoolSettingInfo.allowTeacherAddClass = [[dic safeNumberObjectForKey:@"allowTeacherAddClass"] boolValue];
    schoolSettingInfo.assistant = [[dic safeNumberObjectForKey:@"assistant"] boolValue];
    schoolSettingInfo.authStatus = [dic safeIntObjectForKey:@"authStatus"];
    schoolSettingInfo.clientAddClass = [[dic safeNumberObjectForKey:@"clientAddClass"] boolValue];
    schoolSettingInfo.liveAndPlayback = [[dic safeNumberObjectForKey:@"liveAndPlayback"] boolValue];
    schoolSettingInfo.maxSeatNum = [dic safeIntObjectForKey:@"maxSeatNum"];
    schoolSettingInfo.courseAuditNum = [dic safeIntObjectForKey:@"courseAuditNum"];
    schoolSettingInfo.courseStudentNum = [dic safeIntObjectForKey:@"courseStudentNum"];
    schoolSettingInfo.recordClass = [[dic safeNumberObjectForKey:@"recordClass"] boolValue];
    schoolSettingInfo.webSchoolProperty = (SchoolProperty)[dic safeIntObjectForKey:@"schoolProperty"];
    schoolSettingInfo.webServiceVersion = (WebSchoolServiceVersion)[dic safeIntObjectForKey:@"serviceVersion"];
    schoolSettingInfo.freeClassroomTimeLength = [dic safeIntObjectForKey:@"freeClassroomTimeLength"];
    if ([[dic allKeys] containsObject:@"freeVersionSetting"]) {
        NSDictionary *freeVersionSetting = [dic objectForKey:@"freeVersionSetting"];
        if ([freeVersionSetting isKindOfClass:NSDictionary.class]) {
            schoolSettingInfo.wisdomMode = [EEOSchoolFreeVersionCRModeSettingInfo schoolCRModeSettingInfoWithDic:freeVersionSetting[@"wisdomMode"]];
            schoolSettingInfo.onlineMode = [EEOSchoolFreeVersionCRModeSettingInfo schoolCRModeSettingInfoWithDic:freeVersionSetting[@"onlineMode"]];
        }
    }
    return schoolSettingInfo;
}

@end

static NSMutableDictionary *_cloudDiskIdDic;

@implementation EEOSchoolInfo

static EEOSchoolInfo *_mine = nil;
+ (EEOSchoolInfo *)mine {
    return _mine;
}
+ (void)setMine:(EEOSchoolInfo *)mine {
    if(_mine != mine){
        _mine = mine;
    }
}

+ (void)saveCloudDiskId:(NSNumber *)number withSchoolId:(NSNumber *)schoolId{
    if (!_cloudDiskIdDic) {
        _cloudDiskIdDic = [NSMutableDictionary dictionary];
    }
    [_cloudDiskIdDic setObject:number forKey:schoolId];
}
+ (NSNumber *)cloudDiskIdWithSchoolId:(NSNumber *)schoolId{
    return [_cloudDiskIdDic objectForKey:schoolId];
}

+ (BOOL)isSchoolAssistantsEducationalRight:(NSUInteger)right {
    return (right & SchoolAssistantsRight_Educational) != 0;
}

- (instancetype)init {
    return [self initWithSchoolId:@(0)];
}

- (instancetype)initWithSchoolId:(NSNumber *)schoolId {
    self = [super init];
    if(self){
        self.schoolId = schoolId;
    }
    return self;
}

- (instancetype)initWithSchoolId:(NSNumber *)schoolId webSettingDic:(NSDictionary *)dic{
    self = [[EEOLoginCompleteInfo sharedInstance] getCacheSchoolInfoWithSchoolId:schoolId];
    if (!self) {
        self = [[EEOSchoolInfo alloc] initWithSchoolId:schoolId];
    }
    if (self) {
        EEOSchoolSettingInfo *settingInfo = [EEOSchoolSettingInfo schoolSettingInfoWithDic:dic];
        self.settingInfo = settingInfo;
    }
    return self;
}

- (NSUInteger)hash {
    return [_schoolId hash];
}

- (void)cloneSchoolInfo:(EEOSchoolInfo *)schoolInfo {
    self.schoolId = schoolInfo.schoolId;
    self.timeTag = schoolInfo.timeTag;
    self.status = schoolInfo.status;
    self.type = schoolInfo.type;
    self.authenticationStatus = schoolInfo.authenticationStatus;
    self.attribute = schoolInfo.attribute;
    self.ownerUserName = schoolInfo.ownerUserName;
    self.ownerTrueName = schoolInfo.ownerTrueName;
    self.ownerIDCard = schoolInfo.ownerIDCard;
    self.ownerMobile = schoolInfo.ownerMobile;
    self.name = schoolInfo.name;
    self.photoURL = schoolInfo.photoURL;
    self.notice = schoolInfo.notice;
    self.brief = schoolInfo.brief;
    self.keywords = schoolInfo.keywords;
    self.createTime = schoolInfo.createTime;
    
    if(schoolInfo.coverUrl.length > 0){
        self.coverUrl = schoolInfo.coverUrl;
    }
    if(schoolInfo.settingInfo){
        self.settingInfo = schoolInfo.settingInfo;
    }
}

- (SchoolServiceVersion)serviceVersion {
    unichar *pt = (unichar *)&_attribute;
    SchoolServiceVersion result = pt[0];
    return result;
}

- (BOOL)isTrialVersion {
    return (_attribute & 0x100) != 0;
}

- (BOOL)isLoadedInitialInfo {
    return _timeTag != nil && [_timeTag unsignedLongLongValue] > 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"schoolInfo::schoolID=%@,name=%@,status=%zi,type=%zi", _schoolId,_name,_status,_type];
}

@end

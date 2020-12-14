//
//  EEOCourseScheduleInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOCourseScheduleInfo.h"

#import "EEOUserInfo.h"
#import "EEOClassInfo.h"

#import "NSDictionary+EEO.h"
#import "NSString+EEO.h"

@implementation EEOLessonMemberInfo

- (instancetype)initWithUID:(NSNumber *)uid {
    self = [super init];
    if(self){
        self.userInfo = [[EEOUserInfo alloc] initWithUID:uid];
    }
    return self;
}

- (void)cloneLessonMemberInfo:(EEOLessonMemberInfo *)memberInfo {
    self.userInfo = memberInfo.userInfo;
    self.relationInfo = memberInfo.relationInfo;
    self.classMemberInfo = memberInfo.classMemberInfo;
}

- (NSNumber *)uid {
    return _userInfo.uid;
}
- (NSString *)displayName {
    NSString *result = @"";
    if(_classMemberInfo && _classMemberInfo.nickName.length > 0){
        result = _classMemberInfo.nickName;
    }else{
        result = [_userInfo displayName];
    }
    result = result == nil ? @"" : result;
    return result;
}

- (LessonRole)roleIdentity {
    return _relationInfo.roleIdentity;
}
- (BOOL)isReleased {
    return _relationInfo.isReleased;
}

@end
@interface EEOLessonMemberListInfo (){
    NSArray *_allMember;
}

@end
@implementation EEOLessonMemberListInfo

- (instancetype)initWitAllMember:(NSArray *)memberList {
    self = [super init];
    if(self){
        _allMember = memberList;
    }
    return self;
}

- (NSArray *)teacherList {
    if(_teacherList == nil){
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (EEOLessonMemberInfo *memberInfo in _allMember) {
            if(memberInfo.roleIdentity == LessonRole_Teacher){
                [result addObject:memberInfo];
            }
        }
        _teacherList = [NSArray arrayWithArray:result];
    }
    return _teacherList;
}
- (NSArray *)assistantList {
    if(_assistantList == nil){
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (EEOLessonMemberInfo *memberInfo in _allMember) {
            if(memberInfo.roleIdentity == LessonRole_TeacherAssistant){
                [result addObject:memberInfo];
            }
        }
        _assistantList = [NSArray arrayWithArray:result];
    }
    return _assistantList;
}
- (NSArray *)studentList {
    if(_studentList == nil){
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (EEOLessonMemberInfo *memberInfo in _allMember) {
            if(memberInfo.roleIdentity == LessonRole_Student){
                [result addObject:memberInfo];
            }
        }
        _studentList = [NSArray arrayWithArray:result];
    }
    return _studentList;
}
- (NSArray *)autidorList {
    if(_autidorList == nil){
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (EEOLessonMemberInfo *memberInfo in _allMember) {
            if(memberInfo.roleIdentity == LessonRole_Auditor){
                [result addObject:memberInfo];
            }
        }
        _autidorList = [NSArray arrayWithArray:result];
    }
    return _autidorList;
}

@end

@implementation EEOLessonVODInfo

- (void)cloneLessonVODInfo:(EEOLessonVODInfo *)info {
    self.timeTag = info.timeTag;
    self.activity = info.activity;
    self.vodUpload = info.vodUpload;
    self.vodDownload = info.vodDownload;
}

- (BOOL)isEqual:(id)object {
    BOOL result = [super isEqual:object];
    if(!result && [object isKindOfClass:[self class]]){
        EEOLessonVODInfo *targetVOD = (EEOLessonVODInfo *)object;
        result = targetVOD.timeTag && [_timeTag isEqualToNumber:targetVOD.timeTag];
        if(result){
            result = _activity == targetVOD.activity;
            if(result){
                result = targetVOD.vodUpload && [_vodUpload isEqualToString:targetVOD.vodUpload];
                if(result){
                    result = targetVOD.vodDownload && [_vodDownload isEqualToString:targetVOD.vodDownload];
                }
            }
        }
    }
    return result;
}

@end
@implementation EEOLessonUserRelationInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOLessonUserRelationInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.timeTag = self.timeTag;
    copyObj.roleIdentity = self.roleIdentity;
    copyObj.isReleased = self.isReleased;
    return copyObj;
}

- (void)cloneLessonUserRelationInfo:(EEOLessonUserRelationInfo *)info {
    self.timeTag = info.timeTag;
    self.roleIdentity = info.roleIdentity;
    self.isReleased = info.isReleased;
}

@end
@implementation EEOLessonInfo

static NSDictionary *_kRoleAheadTimeMap = nil;
+ (NSDictionary *)kRoleAheadTimeMap {
    return _kRoleAheadTimeMap;
}
+ (void)setKRoleAheadTimeMap:(NSDictionary *)roleAheadTimeMap {
    if(_kRoleAheadTimeMap != roleAheadTimeMap){
        _kRoleAheadTimeMap = [NSDictionary dictionaryWithDictionary:roleAheadTimeMap];
    }
}

- (instancetype)init {
    self = [super init];
    if(self){
        _courseID = @(0);
        _lessonID = @(0);
//        _globalUserSettings = @(0);
        _teacherUID = @(0);
        _teacherName = @"";
        _name = @"";
    }
    return self;
}

- (NSUInteger)hash {
    return [_lessonID hash];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOLessonInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.courseID = self.courseID;
    copyObj.lessonID = self.lessonID;
    copyObj.timeTag = self.timeTag;
    copyObj.status = self.status;
    copyObj.type = self.type;
    copyObj.lessonIndex = self.lessonIndex;
    copyObj.lessonAttribute = self.lessonAttribute;
    copyObj.publicType = self.publicType;
    copyObj.publicLimit = self.publicLimit;
    copyObj.startTime = self.startTime;
    copyObj.studyType = self.studyType;
    copyObj.prelectTimeLength = self.prelectTimeLength;
    copyObj.prelectStatus = self.prelectStatus;
    copyObj.teacherUID = self.teacherUID;
    copyObj.teacherName = self.teacherName;
    copyObj.name = self.name;
    copyObj.photoURL = self.photoURL;
    copyObj.notice = self.notice;
    copyObj.brief = self.brief;
    copyObj.presetPublicCourseware = self.presetPublicCourseware;
    copyObj.presetPrivateCoursewareList = self.presetPrivateCoursewareList;
    copyObj.lessonSettingsList = self.lessonSettingsList;
    return copyObj;
}

- (BOOL)isEqualToLessonInfo:(EEOLessonInfo *)target {
    if(![self.lessonID isEqualToNumber:target.lessonID]){
        return NO;
    }
    if(self.status != target.status){
        return NO;
    }
    if(self.startTime != target.startTime){
        return NO;
    }
    if(self.publicType != target.publicType){
        return NO;
    }
    if(self.studyType != target.studyType){
        return NO;
    }
//    if(self.liveTimeLength != target.liveTimeLength){
//        return NO;
//    }
//    if(self.liveStatus != target.liveStatus){
//        return NO;
//    }
//    if(self.videoTimeLength != target.videoTimeLength){
//        return NO;
//    }
//    if(self.videoStatus != target.videoStatus){
//        return NO;
//    }
//    if(![self.globalUserSettings isEqualToNumber:target.globalUserSettings]){
//        return NO;
//    }
    if(![self.teacherUID isEqualToNumber:target.teacherUID]){
        return NO;
    }
    if(![self.teacherName isEqualToString:target.teacherName]){
        return NO;
    }
    if(![self.name isEqualToString:target.name]){
        return NO;
    }
//    if(self.isReleased != target.isReleased){
//        return NO;
//    }
    
    if(self.roleIdentity != target.roleIdentity){
        return NO;
    }
    
    return YES;
}
- (void)cloneLessonInfo:(EEOLessonInfo *)info {
    self.courseID = info.courseID;
    self.lessonID = info.lessonID;
    self.timeTag = info.timeTag;
    self.status = info.status;
    self.type = info.type;
    self.lessonIndex = info.lessonIndex;
    self.lessonAttribute = info.lessonAttribute;
    self.publicType = info.publicType;
    self.publicLimit = info.publicLimit;
    self.startTime = info.startTime;
    self.studyType = info.studyType;
    self.prelectTimeLength = info.prelectTimeLength;
    self.prelectStatus = info.prelectStatus;
    self.teacherUID = info.teacherUID;
    self.teacherName = info.teacherName;
    self.name = info.name;
    self.photoURL = info.photoURL;
    self.notice = info.notice;
    self.brief = info.brief;
    self.presetPublicCourseware = info.presetPublicCourseware;
    self.presetPrivateCoursewareList = info.presetPrivateCoursewareList;
    self.lessonSettingsList = info.lessonSettingsList;
}

- (BOOL)isLoadedInitialInfo {
    return _status != LessonStatus_Unknown && _type != LessonType_Unknown && _prelectStatus != LessonPrelectStatus_Unknown;
}
- (BOOL)isLoadedCompleteInfo {
    BOOL result = _timeTag != nil && [_timeTag unsignedLongLongValue] > 0 && _studyType != LessonStudyType_Unknown;
    if(result && _studyType == LessonStudyType_LiveClass){
        result = _prelectTimeLength > 0;
    }
    return result;
}

- (NSString *)displayName {
    NSString *result = _name;
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate lessonInfoNeedToLoadInfo:self];
    }
    return result;
}

- (BOOL)isEffectively {
    BOOL result = NO;
    if(_status == LessonStatus_Normal && !self.isReleased && ![self isUnrelated] && ![self isMasterMember]){
        if(_studyType == LessonStudyType_VideoClass){//视频课(开发测试用)
            result = YES;//TODO...
        }else{//暂时都当成直播课处理 TODO...
            result = _prelectStatus == LessonPrelectStatus_NotStarted || _prelectStatus == LessonPrelectStatus_OnProgress;
            
            if(result && _type == LessonType_ShuangShi){
                if([self isTeacherMember]){
                    result = [self isMasterLesson];
                }else{
                    result = ![self isMasterLesson];
                }
            }
        }
    }
    return result;
}

- (NSUInteger)endTime {
    NSUInteger result = _startTime;
    result += _prelectTimeLength;
    return result;
}
- (NSUInteger)closeTime {
    NSUInteger result = [self endTime];
    if(_studyType == LessonStudyType_VideoClass){//视频课不会被关闭
        result = INT32_MAX;
    }else{
        result += 20 * 60;//直播课节在结束之后的20分钟时关闭
    }
    return result;
}

- (BOOL)isStarted {
    BOOL result = NO;
    if(_studyType == LessonStudyType_VideoClass){//永不结束的测试课
        result = YES;//TODO...
    }else{
        result = _prelectStatus == LessonPrelectStatus_OnProgress;
    }
    return result;
}

- (BOOL)isNotStartedWithNowTime:(NSUInteger)nowTime {
    BOOL result = _prelectStatus == LessonPrelectStatus_NotStarted;
    if(!result){
        result = nowTime < _startTime;
    }
    return result;
}
- (BOOL)isStartedWithNowTime:(NSUInteger)nowTime {
    BOOL result = [self isStarted];
    if(!result){
        NSUInteger endTime = [self endTime];
        result = nowTime >= _startTime && nowTime < endTime;
    }
    return result;
}
- (BOOL)isCanEnterWithNowTime:(NSUInteger)nowTime {
    BOOL result = NO;
    if([self isEffectively]){
        if([self isStartedWithNowTime:nowTime] || [self isStarted]){
            result = YES;
        }else{
            NSUInteger aheadTime = [self aheadTime];
            if(aheadTime == 0){
                result = YES;
            }else if(aheadTime == 1){
                result = NO;
            }else{
                result = nowTime + aheadTime >= _startTime;
            }
        }
    }
    return result;
}
- (BOOL)isStartCountdownWithNowTime:(NSUInteger)nowTime {
    BOOL result = NO;
    if([self isNotStartedWithNowTime:nowTime]){
        NSUInteger aheadTime = [self aheadTime];
        result = nowTime + (24*3600) > (_startTime - aheadTime);//根据可进入教室时间进行判断
    }
    return result;
}
- (BOOL)isFinished {
    BOOL result = YES;
    if(_studyType == LessonStudyType_VideoClass){
        result = NO;//TODO...
    }else{
        result = _prelectStatus == LessonPrelectStatus_Ended || _prelectStatus == LessonPrelectStatus_EndedAndClosed;
    }
    return result;
}
- (BOOL)isFinishedWithNowTime:(NSUInteger)nowTime {
    return [self isFinishedWithNowTime:nowTime leeway:0];
}
- (BOOL)isFinishedWithNowTime:(NSUInteger)nowTime leeway:(NSUInteger)leeway {
    BOOL result = [self isFinished];//先根据状态判断
    if(!result){//如果状态未结束就根据时间判断
        if(_prelectTimeLength <= 0){
            result = NO;
        }else{
            NSUInteger endTime = [self endTime];
            if(nowTime >= endTime){
                result = (nowTime - endTime) >= leeway;
            }else{
                result = NO;
            }
        }
    }
    return result;
}
- (BOOL)isClosed {
    BOOL result = NO;
    if(_studyType == LessonStudyType_VideoClass){
        result = NO;//TODO...
    }else{
        result = _prelectStatus == LessonPrelectStatus_ClosedInAdvance || _prelectStatus == LessonPrelectStatus_EndedAndClosed;
    }
    return result;
}

- (BOOL)isSupportNS {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_NS) != 0;
}
- (BOOL)isSupportHD {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_HD) != 0;
}
- (BOOL)isSupportFHD {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_FHD) != 0;
}
- (BOOL)isSupportCamera2 {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_CAMERA2) != 0 || [self isSupportCamera2HD] || [self isSupportCamera2FHD];
//    return YES;//TEST...
}
- (BOOL)isSupportCamera2HD {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_CAM2_HD) != 0;
}
- (BOOL)isSupportCamera2FHD {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_CAM2_FHD) != 0;
}
- (BOOL)isSupportTeacherInvite {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_Open) != 0;
}
- (BOOL)isSupportAllMemberInvite {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_Open_Invite) != 0;
}
- (BOOL)isSupportHideSeatArea {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_HideSeatArea) != 0;
}
- (BOOL)isSupportLargeScreen {
    uint64_t temp = [_lessonAttribute unsignedLongLongValue];
    return (temp & LessonAttributeFlag_LargeScreen) != 0;
}
- (NSUInteger)maxSeatNum {
    NSUInteger result = 0;
    NSArray *tempList = [_lessonSettingsList copy];
    for (NSArray *configListItem in tempList) {
        uint64_t settingFlag = [configListItem[0] unsignedLongLongValue];
        NSUInteger studentAutoSet = [configListItem[1] unsignedIntegerValue];
        NSUInteger maxSetNum = [configListItem[2] unsignedIntegerValue];
        if((settingFlag & LessonSettingFlag_OnStage) != 0){
            result = maxSetNum;
            break;
        }
    }
    return result;
}
- (BOOL)changeSettingsMaxNumWithFlag:(uint64_t)settingsFlag maxNum:(NSUInteger)maxNum {
    NSMutableArray *finalList = [_lessonSettingsList mutableCopy];
    NSInteger index = NSNotFound;
    NSArray *changedConfigListItem = nil;
    for (int i=0; i<finalList.count; i++) {
        NSArray *configListItem = finalList[i];
        uint64_t settingFlag = [configListItem[0] unsignedLongLongValue];
        NSUInteger studentAutoSet = [configListItem[1] unsignedIntegerValue];
        NSUInteger maxSetNum = [configListItem[2] unsignedIntegerValue];
        if(settingFlag == settingsFlag && maxSetNum != maxNum){
            index = i;
            changedConfigListItem = @[@(settingFlag),@(studentAutoSet),@(maxNum)];
            [finalList replaceObjectAtIndex:index withObject:changedConfigListItem];
            _lessonSettingsList = [finalList copy];
            break;
        }
    }
    return index != NSNotFound;
}

- (BOOL)isRecording {
    return _vodInfo.activity & 4;
}
- (BOOL)isLive {
    return _vodInfo.activity & 2;
}
- (BOOL)isPlayback {
    return _vodInfo.activity & 1;
}
- (NSString *)vodUpload {
    return _vodInfo.vodUpload;
}
- (NSString *)vodDownload {
    return _vodInfo.vodDownload;
}

- (LessonRole)roleIdentity {
    return _relationInfo.roleIdentity;
}
- (BOOL)isTeacherMember {
    return self.roleIdentity == LessonRole_Teacher;
}
- (BOOL)isStudentMember {
    return self.roleIdentity == LessonRole_Student;
}
- (BOOL)isAuditMember {
    return self.roleIdentity == LessonRole_Auditor;
}
- (BOOL)isMasterMember {
    return self.roleIdentity == LessonRole_Master || self.roleIdentity == LessonRole_MasterAssistant || self.roleIdentity == LessonRole_Administrator;
}
- (BOOL)isReleased {
    return _relationInfo.isReleased;
}

//- (NSString *)teacherName {
//    return [self teacherDisplayName];//TODO...
//}
- (NSString *)teacherDisplayName {
    NSString *result = _teacherName;
    if(_teacherClassMemberInfo && _teacherClassMemberInfo.displayName.length > 0){
        result = _teacherClassMemberInfo.displayName;
    }else if(_teacherUserInfo && _teacherUserInfo.displayName.length > 0){
        result = _teacherUserInfo.displayName;
    }
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate lessonInfoNeedToLoadInfo:self];
    }
    if(_teacherClassMemberInfo == nil && [self hasClassByType] && [_teacherUID unsignedLongLongValue] > 0){
        [_delegate lessonTeacherClassMemberInfoNeedToLoadInfo:self];
    }
    return result;
}

- (BOOL)haveLearningDataReports {
    BOOL result = NO;
    if (self.type != LessonType_Meeting) {
        if(_studyType == LessonStudyType_LiveClass && ([self isStudentMember] || [self isTeacherMember] || self.roleIdentity == LessonRole_TeacherAssistant)){
            result = _prelectStatus == LessonPrelectStatus_EndedAndClosed;
        }
    }
    return result;
}
- (BOOL)haveLearningVideo {
    BOOL result = NO;
    if(_studyType == LessonStudyType_LiveClass){
        if(_vodInfo == nil){
            [_delegate lessonVODInfoNeedToLoadInfo:self];
        }else{
            result = _prelectStatus == LessonPrelectStatus_EndedAndClosed && [self isRecording] && self.roleIdentity != LessonRole_Auditor;
        }
    }
    return result;
}

- (BOOL)isDismissed {
    BOOL result = NO;
    if(_studyType != LessonStudyType_VideoClass){
        result = _prelectStatus == LessonPrelectStatus_Ended || _prelectStatus == LessonPrelectStatus_ClosedInAdvance || _prelectStatus == LessonPrelectStatus_EndedAndClosed;
    }
    return result;
}

- (BOOL)isMasterLesson {
    BOOL result = NO;
    if(_type == LessonType_ShuangShi){
        result = _lessonIndex == 1;
        
        if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
            [_delegate lessonInfoNeedToLoadInfo:self];
        }
    }
    return result;
}
- (BOOL)isSpeakerAndMasterLesson {
    return [self isTeacherMember] && [self isMasterLesson];
}

- (BOOL)isUnrelated {
    return self.roleIdentity == LessonRole_Unknown;
}

- (NSUInteger)aheadTime {
    return [self aheadTimeWithRoleIdentity:self.roleIdentity];
}

- (NSUInteger)aheadTimeWithRoleIdentity:(LessonRole)roleIdentity {
    NSUInteger result = 1;
    if (self.type == LessonType_Experience) {//体验教室专用 提前进入教室的时间量，三端统一为 5 分钟
        result = 5*60;
    }else if (self.class.kRoleAheadTimeMap.count > 0) {
        NSNumber *aheadTimeValue = self.class.kRoleAheadTimeMap[@(roleIdentity)];
        if(aheadTimeValue){
            result = [aheadTimeValue unsignedIntegerValue];
        }
    }
    return result;
}

- (NSString *)lessonTypeTranslateChinese{
    NSString *lessonName = @"";
    switch (self.type) {
        case LessonType_Basic:
            lessonName = @"标准教室";
            break;
        case LessonType_Temp:
            lessonName = @"临时教室";
            break;
        case LessonType_Public:
            lessonName = @"公开课";
            break;
        case LessonType_ShuangShi:
            lessonName = @"双师课";
            break;
        case LessonType_Meeting:
            lessonName = @"会议系统";
            break;
        case LessonType_Experience:
            lessonName = @"体验教室";
            break;
        default:
            lessonName = [NSString stringWithFormat:@"未知类型:%ld",self.type];
            break;
    }
    return lessonName;
}

- (BOOL)hasClassByType {
    return _type == LessonType_Basic || _type == LessonType_Temp;
}

#pragma mark - NSObject
- (NSString *)description {
    NSString *result = [NSString stringWithFormat:@"<lessonId:%@,lessonName:%@,identity:%zi,prelectStatus:%zi,startTime:%zi,prelectTimeLength:%zi>,isStartCountdown:%d,isCanEnter:%d,isStartedFlag:%d",_lessonID,_name,self.roleIdentity,_prelectStatus,_startTime,_prelectTimeLength,_isStartCountdown,_isCanEnter,_isStartedFlag];
    return result;
}

@end

@implementation EEOCourseUserRelationInfo

- (void)cloneCourseUserRelationInfo:(EEOCourseUserRelationInfo *)info {
    self.timeTag = info.timeTag;
    self.autoPayIdentity = info.autoPayIdentity;
    self.isReleased = info.isReleased;
    self.isMaster = info.isMaster;
}

@end
@interface EEOCourseInfo (){
    id _syncToken;
}

@property (nonatomic,copy) NSString *originalAvatarURL;
@property (nonatomic,copy) NSString *compressionAvatarURL;
@property (nonatomic,copy) NSString *thumbnailAvatarURL;

@end
@implementation EEOCourseInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _syncToken = [NSObject new];
        
        _courseID = @(0);
        _schoolID = @(0);
        _name = @"";
//        _iconURL = @"";
        _brief = @"";
        
        _lessonList = [[NSMutableArray alloc] init];
        
//        _avatarURLInfo = @"";
    }
    return self;
}

- (NSUInteger)hash {
    return [_courseID hash];
}

- (BOOL)isEqualToCourseInfo:(EEOCourseInfo *)target {
    if(![self.courseID isEqualToNumber:target.courseID]){
        return NO;
    }
    if(![self.schoolID isEqualToNumber:target.schoolID]){
        return NO;
    }
    if(![self.classTeacherUID isEqualToNumber:target.classTeacherUID]){
        return NO;
    }
    if(self.status != target.status){
        return NO;
    }
    if(self.type != target.type){
        return NO;
    }
    if(![self.name isEqualToString:target.name]){
        return NO;
    }
//    if(![self.iconURL isEqualToString:target.iconURL]){
//        return NO;
//    }
    if(![self.brief isEqualToString:target.brief]){
        return NO;
    }
    if(self.createTime != target.createTime){
        return NO;
    }
    if(self.expiryTime != target.expiryTime){
        return NO;
    }
    if(self.publicStudentLimit != target.publicStudentLimit){
        return NO;
    }
    /*
    if(self.fullPayIdentity != target.fullPayIdentity){
        return NO;
    }
    */
//    if(self.isReleased != target.isReleased){
//        return NO;
//    }
    if(![self.autoAppointTeacherUID isEqualToNumber:target.autoAppointTeacherUID]){
        return NO;
    }
    if(![self.autoAppointTeacherName isEqualToString:target.autoAppointTeacherName]){
        return NO;
    }
//    if(![self.avatarURLInfo isEqualToString:target.avatarURLInfo]){
//        return NO;
//    }
    
    return YES;
}
- (void)cloneCourseInfo:(EEOCourseInfo *)courseInfo {
    self.courseID = courseInfo.courseID;
    self.schoolID = courseInfo.schoolID;
    self.timeTag = courseInfo.timeTag;
    self.classTeacherUID = courseInfo.classTeacherUID;
    self.status = courseInfo.status;
    self.type = courseInfo.type;
    self.attribute = courseInfo.attribute;
    self.expiryTime = courseInfo.expiryTime;
    self.publicStudentLimit = courseInfo.publicStudentLimit;
    self.name = courseInfo.name;
    self.autoAppointTeacherUID = courseInfo.autoAppointTeacherUID;
    self.autoAppointTeacherName = courseInfo.autoAppointTeacherName;
    self.photoURL = courseInfo.photoURL;
    self.brief = courseInfo.brief;
    self.keywords = courseInfo.keywords;
    self.courseware = courseInfo.courseware;
    self.createTime = courseInfo.createTime;
}

- (void)setCourseware:(NSString *)courseware {
    if([_courseware isEqualToString:courseware]){
        return;
    }
    
    _courseware = [courseware copy];
    if(_courseware.length <= 0){
        _originalAvatarURL = @"";
        _compressionAvatarURL = @"";
        _thumbnailAvatarURL = @"";
        return;
    }
    NSString *outOriginalURL = @"";
    NSString *outCompressionURL = @"";
    NSString *outThumbnailURL = @"";
    [NSString parseAvatarURLJsonStr:_courseware outOriginalURL:&outOriginalURL outCompressionURL:&outCompressionURL outThumbnailURL:&outThumbnailURL];
    
    _originalAvatarURL = outOriginalURL;
    _compressionAvatarURL = outCompressionURL;
    _thumbnailAvatarURL = outThumbnailURL;
}

- (NSString *)thumbnailAvatarURL {
    NSString *result = _thumbnailAvatarURL;
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate courseInfoNeedToLoadInfo:self];
    }
    return result;
}

- (NSString *)brief {
    NSString *result = _brief;
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate courseInfoNeedToLoadInfo:self];
    }
    return result;
}
- (NSString *)briefNoLoadOnDemand {
    return _brief;
}

- (NSString *)schoolName {
    NSString *result = _schoolName;
    if(result == nil){
        [_delegate courseInfoNeedToLoadSchoolName:self];
    }
    return result;
}

- (NSString *)displayName {
    NSString *result = _name;
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate courseInfoNeedToLoadInfo:self];
    }
    return result;
}

- (BOOL)isLoadedInitialInfo {
    return _status != CourseStatus_Unknown && _type != CourseType_Unknown;
}

- (BOOL)isExpiredWithNowTime:(NSUInteger)nowTime {
    BOOL result = _expiryTime > 0 && nowTime >= _expiryTime;
    return result;
}

- (BOOL)isPublic {
    return _type == CourseType_Public;
}
- (BOOL)isShuangShi {
    return _type == CourseType_ShuangShi;
}

- (BOOL)isDisplay {
    return _status == CourseStatus_Normal && [self lessonListFromNotOver].count > 0;
}

- (BOOL)isTransferStudent {
    return _relationInfo.autoPayIdentity == 0;
}
- (BOOL)isReleased {
    return _relationInfo.isReleased;
}
- (BOOL)mineIsClassTeacher {
    return _relationInfo.isMaster;
}

- (NSUInteger)lessonTotal {
    return _lessonList.count;
}

- (NSArray*)lessonListFromNotOver {
    NSMutableArray *notOverLessonList = [[NSMutableArray alloc] init];
    NSArray *tempList = nil;
    @synchronized(_syncToken){
        tempList = [NSArray arrayWithArray:_lessonList];
    }
    for (EEOLessonInfo *lesson in tempList) {
        if([lesson isEffectively]){
            [notOverLessonList addObject:lesson];
        }
    }
    if(notOverLessonList.count > 1){
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
        NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"lessonIndex" ascending:YES];
        [notOverLessonList sortUsingDescriptors:@[sd1,sd2]];
    }
    return notOverLessonList;
}

- (EEOLessonInfo *)firstNotOverLesson {
    EEOLessonInfo *result = nil;
    NSArray *notOverLessonList = [self lessonListFromNotOver];
    if(notOverLessonList.count > 0){
        result = [notOverLessonList firstObject];
    }
    return result;
}
- (NSUInteger)firstNotOverLessonStartTime {
    NSUInteger startTime = 0;
    EEOLessonInfo *lesson = [self firstNotOverLesson];
    startTime = lesson.startTime;
    return startTime;
}
- (NSUInteger)firstNotOverLessonEndTime {
    NSUInteger endTime = 0;
    EEOLessonInfo *lesson = [self firstNotOverLesson];
    endTime = lesson.endTime;
    return endTime;
}

- (EEOLessonInfo *)lessonWithID:(NSNumber *)lessonId {
    EEOLessonInfo *result = nil;
    NSArray *tempList = [NSArray arrayWithArray:_lessonList];
    for (EEOLessonInfo *lesson in tempList) {
        if([lesson.lessonID isEqualToNumber:lessonId]){
            result = lesson;
            break;
        }
    }
    return result;
}

- (void)addLessonInfoByThreadSafety:(EEOLessonInfo *)lessonInfo {
    @synchronized(_syncToken){
        [_lessonList addObject:lessonInfo];
    }
}
- (void)removeLessonInfoByThreadSafety:(EEOLessonInfo *)lessonInfo {
    @synchronized(_syncToken){
        [_lessonList removeObject:lessonInfo];
    }
}

- (BOOL)hasNotOverLessonAndExistRoleWithNowTime:(NSUInteger)nowTime {
    BOOL result = NO;
    NSArray *tempList = [NSArray arrayWithArray:_lessonList];
    for (EEOLessonInfo *lesson in tempList) {
        if(lesson.status == LessonStatus_Normal && !lesson.isReleased && ![lesson isUnrelated] && ![lesson isMasterMember] && ![lesson isClosed] && ![lesson isFinishedWithNowTime:nowTime]){//不包括监课角色
            result = YES;
            break;
        }
    }
    return result;
}

- (NSNumber *)minTimetag {
    uint64_t result = _relationInfo.timeTag ? [_relationInfo.timeTag unsignedLongLongValue] : 0;
    if(result > 0){
        NSArray *tempList = [_lessonList copy];
        for (EEOLessonInfo *lessonInfo in tempList) {
            if(lessonInfo.relationInfo && [lessonInfo.relationInfo.timeTag unsignedLongLongValue] < result){
                result = [lessonInfo.relationInfo.timeTag unsignedLongLongValue];
            }
        }
    }
    return @(result);
}

- (BOOL)isCompeletedWithNowTime:(NSUInteger)nowTime {
    if ([self isExpiredWithNowTime:nowTime]) {//课程已过期
        return YES;
    }// 曾经购买课程，现在被踢出
    if (self.isReleased && ![self mineIsClassTeacher]) {
        return YES;
    }//公开课结束后即显示在已结
    if (self.type == CourseType_Public) {
        if (_lessonList.count > 0) {
            EEOLessonInfo *displayLessonInfo = [self firstNotOverLesson];
            return displayLessonInfo == nil;
        }
    }else if (![self mineIsClassTeacher] && [self isTransferStudent]) { //判断插班生，并判断他的课是否都上完了
        NSArray *tempList = [_lessonList copy];
        if (tempList.count > 0) {
            BOOL allClosed = YES;
            for (EEOLessonInfo *lessonInfo in tempList) {
                if(lessonInfo.roleIdentity == LessonRole_Teacher || lessonInfo.roleIdentity == LessonRole_TeacherAssistant || lessonInfo.prelectStatus < 3){
                    allClosed = NO;
                    break;
                }
            }
            return allClosed;
        }
    }
    return NO;
}

#pragma mark - NSObject
- (NSString *)description {
    NSMutableString *result = [NSMutableString stringWithFormat:@"<courseId:%@,schoolId:%@,type:%zi,courseName:%@ \n",_courseID,_schoolID,_type,_name];
#if DEBUG
    if(_lessonList.count > 0){
        NSArray *lessonList = [NSArray arrayWithArray:_lessonList];
        for (EEOLessonInfo *lessonInfo in lessonList) {
            [result appendFormat:@"%@ \n",lessonInfo];
        }
        [result appendFormat:@"lessonTotal:%zi>",self.lessonTotal];
    }
#endif
    return result;
}

@end

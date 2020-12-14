//
//  EEOClassroomInfo.m
//  EEOEntity
//
//  Created by 蒋敏 on 17/1/22.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import "EEOClassroomInfo.h"

#import "EEOCourseScheduleInfo.h"
#import "EEOClassroomMember.h"
#import "EEOClassroomBlackboardInfo.h"
#import "EEOClassroomThemeInfo.h"
#import "EEOClassInfo.h"

#import <UIKit/UIColor.h>
#import <AVFoundation/AVFoundation.h>
#import "EEOConstants.h"

@implementation EEOClassroomInfo

static EEOClassroomInfo *_currentClassroomInfo = nil;
+ (EEOClassroomInfo *)currentClassroomInfo {
    if(_currentClassroomInfo == nil){
        _currentClassroomInfo = [[EEOClassroomInfo alloc] init];
    }
    return _currentClassroomInfo;
}
+ (void)setCurrentClassroomInfo:(EEOClassroomInfo *)currentClassroomInfo {
    if(_currentClassroomInfo != currentClassroomInfo){
        _currentClassroomInfo = currentClassroomInfo;
    }
}

- (instancetype)init {
    return [self initWithClassroomID:@(0) courseID:@(0) schoolID:@(0)];
}
- (instancetype)initWithClassroomID:(NSNumber *)classroomID courseID:(NSNumber *)courseID schoolID:(NSNumber *)schoolID {
    self = [super init];
    if(self){
        _classroomID = classroomID;
        _courseID = courseID;
        _schoolID = schoolID;
        
        _memberList = [[NSMutableArray alloc] init];
        
        _isEnableSound = YES;
        _enableVoiceProcessing = YES;
        _enableAudioProcessor = YES;
        _enablePdfKitPlayer = NO;
        _enableVoiceAgc = NO;
        
        _bbOperationMode = BBOperationMode_Pen;
        _bbPenSize = 4.0;
        _bbPenColor = [UIColor colorWithRed:250.9/255.0 green:40.4/255.0 blue:0/255.0 alpha:1.0f];
        _bbPenType = 0;
        _bbFontSize = 14.0f;
        _bbFontColor = [UIColor colorWithRed:250.9/255.0 green:40.4/255.0 blue:0/255.0 alpha:1.0f];
        
        self.themeInfo = [[EEOClassroomThemeInfo alloc] init];
        
        _clientType = ClassroomClientType_Remote;
        
        _alias = @"";
        _classroomAlias = @"";
        
        _flagsMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.lessonInfo = self.lessonInfo;
    
    copyObj.classroomID = self.classroomID;
    copyObj.courseID = self.courseID;
    copyObj.schoolID = self.schoolID;
    copyObj.memberList = self.memberList;
    copyObj.isMuteAll = self.isMuteAll;
    copyObj.isEstoppelAll = self.isEstoppelAll;
    copyObj.isAuthorizationAll = self.isAuthorizationAll;
    
    copyObj.isCamAuthorization = self.isCamAuthorization;
    copyObj.isEnableCamera = self.isEnableCamera;
    copyObj.cameraPosition = self.cameraPosition;
    copyObj.isEnableMirror = self.isEnableMirror;
    copyObj.isMicAuthorization = self.isMicAuthorization;
    copyObj.isEnableMicrophone = self.isEnableMicrophone;
    copyObj.isEnableSpeakers = self.isEnableSpeakers;
    copyObj.isEnableSound = self.isEnableSound;
    
    copyObj.isEnableCamera2 = self.isEnableCamera2;
    copyObj.camera2Position = self.camera2Position;
    copyObj.isEnableMicrophone2 = self.isEnableMicrophone2;
    
    copyObj.onlineStudentCount = self.onlineStudentCount;
    copyObj.handsupCount = self.handsupCount;
    
    copyObj.bbOperationMode = self.bbOperationMode;
    copyObj.bbPenSize = self.bbPenSize;
    copyObj.bbPenColor = self.bbPenColor;
    copyObj.bbPenType = self.bbPenType;
    copyObj.bbFontSize = self.bbFontSize;
    copyObj.bbFontColor = self.bbFontColor;
    
    copyObj.bbInfo = self.bbInfo;
    
    copyObj.themeInfo = self.themeInfo;
    
    copyObj.enableAudioProcessor = self.isEnableAudioProcessor;
    copyObj.enableVoiceProcessing = self.isEnableVoiceProcessing;
    copyObj.enableVoiceAgc = self.isEnableVoiceAgc;
    
    copyObj.recordDirPath = self.recordDirPath;
    
    copyObj.clientType = self.clientType;
    
    copyObj.alias = self.alias;
    copyObj.classroomAlias = self.classroomAlias;
    
    copyObj.enablePdfKitPlayer = self.enablePdfKitPlayer;
    
    copyObj.classID = self.classID;
    
    copyObj.mediaSrvHost = self.mediaSrvHost;
    copyObj.mediaClientIp = self.mediaClientIp;
    
    copyObj.flagsMap = self.flagsMap;
    
    copyObj.enterState = self.enterState;
    
    return copyObj;
}

- (void)cloneClassroomInfo:(EEOClassroomInfo *)info {
    self.lessonInfo = info.lessonInfo;
    
    self.classroomID = info.classroomID;
    self.courseID = info.courseID;
    self.schoolID = info.schoolID;
    self.memberList = info.memberList;
    self.isMuteAll = info.isMuteAll;
    self.isEstoppelAll = info.isEstoppelAll;
    self.isAuthorizationAll = info.isAuthorizationAll;
    
    self.isCamAuthorization = info.isCamAuthorization;
    self.isEnableCamera = info.isEnableCamera;
    self.cameraPosition = info.cameraPosition;
    self.isEnableMirror = info.isEnableMirror;
    self.isMicAuthorization = info.isMicAuthorization;
    self.isEnableMicrophone = info.isEnableMicrophone;
    self.isEnableSpeakers = info.isEnableSpeakers;
    self.isEnableSound = info.isEnableSound;
    
    self.isEnableCamera2 = info.isEnableCamera2;
    self.camera2Position = info.camera2Position;
    self.isEnableMicrophone2 = info.isEnableMicrophone2;
    
    self.onlineStudentCount = info.onlineStudentCount;
    self.handsupCount = info.handsupCount;
    
    self.bbOperationMode = info.bbOperationMode;
    self.bbPenSize = info.bbPenSize;
    self.bbPenColor = info.bbPenColor;
    self.bbPenType = info.bbPenType;
    self.bbFontSize = info.bbFontSize;
    self.bbFontColor = info.bbFontColor;
    
    self.bbInfo = info.bbInfo;
    
    self.themeInfo = info.themeInfo;
    
    self.enableAudioProcessor = info.isEnableAudioProcessor;
    self.enableVoiceProcessing = info.isEnableVoiceProcessing;
    self.enableVoiceAgc = info.enableVoiceAgc;
    
    self.recordDirPath = info.recordDirPath;
    
    self.clientType = info.clientType;
    
    self.alias = info.alias;
    self.classroomAlias = info.classroomAlias;
    
    self.enablePdfKitPlayer = info.enablePdfKitPlayer;
    
    self.classID = info.classID;
    
    self.mediaSrvHost = info.mediaSrvHost;
    self.mediaClientIp = info.mediaClientIp;
    
    self.flagsMap = info.flagsMap;
    
    self.enterState = info.enterState;
}

- (NSString *)title {
    if (self.classroomAlias && self.classroomAlias.length > 0) {
        return self.classroomAlias;
    }
    return [_lessonInfo displayName];
}
- (NSUInteger)startTime {
    return _lessonInfo.startTime;
}
- (NSUInteger)endTime {
    return [_lessonInfo endTime];
}

- (NSUInteger)aheadTime {
    EEOClassroomMember *mine = [EEOClassroomMember mine];
    return [_lessonInfo aheadTimeWithRoleIdentity:(LessonRole)mine.roleIdentity];
}

- (EEOClassroomMember *)teacherInfo {
    EEOClassroomMember *result = nil;
    
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassroomMember *member in tempList) {
        if([member isTeacher]){
            result = member;
            break;
        }
    }
    
    return result;
}
- (NSString *)teacherName {
    NSString *result = @"";
    
    EEOClassroomMember *teacherInfo = [self teacherInfo];
    if(teacherInfo){
        result = teacherInfo.displayName;
    }
    
    return result;
}

- (EEOClassroomMember *)assistantInfo {
    EEOClassroomMember *result = nil;
    
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassroomMember *member in tempList) {
        if([member isAssistant]){
            result = member;
            break;
        }
    }
    
    return result;
}

- (NSNumber *)equipments {
    uint64_t result = 0;
    bit_set(&result, 1, [self finalIsEnableCam]);
    bit_set(&result, 2, [self finalIsEnableMic]);
    bit_set(&result, 3, _isEnableSpeakers);
    bit_set(&result, 4, _isEnableCamera2);
    bit_set(&result, 5, _isEnableMicrophone2);
    return @(result);
}
void bit_set(uint64_t *p_data,unsigned int position, bool flag){
    if(flag){
        *p_data |= (0x01<<(position-1));
    }else{
        int c = (0x01<<(position-1));
        *p_data &= ~c;
    }
}

- (BOOL)isHeadsetPluggedIn {
    AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription* desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones] || [[desc portType] isEqualToString:AVAudioSessionPortBluetoothHFP])
            return YES;
    }
    return NO;
}

- (BOOL)isTempClassroom {
    return _lessonInfo.type == LessonType_Temp;
}

- (BOOL)isFormalClass {
    BOOL result = _lessonInfo.studyType != LessonStudyType_VideoClass && !self.isTempClassroom && _lessonInfo.type != LessonType_Experience && ![self isNativeClassroom];
    return result;
}
- (BOOL)isNeedEvaluation {
    BOOL result = [self isFormalClass];
    if(result){
        EEOClassroomMember *mineInfo = EEOClassroomMember.mine;
        result = mineInfo && ([mineInfo isCompere] || [mineInfo isStudent]);
        if(result){
            result = [self p_allStudent].count > 0;
            if(result && _themeInfo){
                result = [_themeInfo isCommentVisible];
            }
        }
    }
    return result;
}

- (BOOL)finalIsEnableCam {
    return _isEnableCamera && _isCamAuthorization;
}
- (BOOL)finalIsEnableMic {
    return _isEnableMicrophone && _isMicAuthorization;
}

- (BOOL)haveLivePush {
    return _lessonInfo.isRecording && ![self isNativeClassroom];
}

- (EEOClassroomMember *)memberWithUID:(NSNumber *)uid {
    EEOClassroomMember *result = nil;
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassroomMember *member in tempList) {
        if([uid isEqualToNumber:member.uid]){
            result = member;
            break;
        }
    }
    return result;
}

- (void)fillMemberClassMemberInfoWithList:(NSArray *)classMemberList {
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassroomMember *member in tempList) {
        for (EEOClassMemberInfo *classMember in classMemberList) {
            if([member.uid isEqualToNumber:classMember.uid]){
                member.classMemberInfo = classMember;
                break;
            }
        }
    }
}

- (BOOL)isAvailable {
    return [_classroomID unsignedIntegerValue] > 0 && [_courseID unsignedIntegerValue] > 0 && [_schoolID unsignedIntegerValue] > 0;
}

- (BOOL)isNativeClassroom {
    return _clientType != ClassroomClientType_Remote;
}
- (BOOL)isPreparationClassroom {
    return _clientType == ClassroomClientType_Preparation;
}
- (BOOL)isBlackboardClassroom {
    return _clientType == ClassroomClientType_Blackboard;
}

- (void)saveGroupFlags:(NSUInteger)groupID flags:(NSNumber *)flags {
    @synchronized (_flagsMap) {
        _flagsMap[@(groupID)] = flags;
    }
}
- (NSNumber *)getGroupFlags:(NSUInteger)groupID {
    NSNumber *result = @(0);
    @synchronized (_flagsMap) {
        result = _flagsMap[@(groupID)];
    }
    return result;
}
- (void)removeGroupFlags:(NSUInteger)groupID {
    @synchronized (_flagsMap) {
        [_flagsMap removeObjectForKey:@(groupID)];
    }
}
- (BOOL)isHiddenSeatAreaWithGroupID:(NSUInteger)groupID {
    BOOL result = NO;
    @synchronized (_flagsMap) {
        NSNumber *flags = _flagsMap[@(groupID)];
        if(flags){
            result = ([flags unsignedLongLongValue] & ClassroomFlags_HiddenSeatArea) != 0;
        }
    }
    return result;
}

- (BOOL)isContactTempClassroom{
    BOOL result = NO;
    if (self.lessonInfo.type == LessonType_Temp && [self.schoolID isEqualToNumber:@(kTempClassroomCommonSID)]) {
        result = YES;
    }
    return result;
}

- (BOOL)canShowHomeworkInToolbox{
    BOOL result = NO;
    if (self.lessonInfo.type == LessonType_Basic) {
        //正常教室可以显示作业
        result = YES;
    }else if (self.lessonInfo.type == LessonType_Temp){
        //临时教室中，好友之间的临时教室不显示作业入口
        result = ![self isContactTempClassroom];
    }
    
    return result;
}

- (NSArray *)unsupportedToolsInToolbox{
    NSMutableArray *unsupportedTools = [NSMutableArray array];
    
    if (![self canShowHomeworkInToolbox]) {
        [unsupportedTools addObject:@(TeacherToolBoxWidget_Homework)];
    }
    
    //只有正式教室和临时教室,同时是远程教室，不显示测验入口
    if ((self.lessonInfo.type != LessonType_Basic && self.lessonInfo.type != LessonType_Temp) || [self isNativeClassroom]) {
        [unsupportedTools addObject:@(TeacherToolBoxWidget_Examination)];
    }
    
    return [NSArray arrayWithArray:unsupportedTools];
}

- (BOOL)canStudentOnStage {
    if(_lessonInfo && [_lessonInfo maxSeatNum] > 1){
        return YES;
    }
    return NO;
}

#pragma mark - Private Methods
- (NSArray *)p_allStudent {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassroomMember *member in tempList) {
        if([member isStudent]){
            [result addObject:member];
        }
    }
    return result;
}

#pragma mark - NSObject
- (NSString *)description {
    NSString *result = [NSString stringWithFormat:@"<classroomInfo:::classroomID:%@,courseID:%@,schoolID:%@,lessonInfo:%@>",_classroomID,_courseID,_schoolID,_lessonInfo];
    return result;
}

@end

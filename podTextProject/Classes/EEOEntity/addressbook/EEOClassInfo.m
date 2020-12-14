//
//  EEOClassInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassInfo.h"

#import "EEOChatMessageInfo.h"

#import "NSDictionary+EEO.h"
#import "NSString+EEO.h"

@implementation EEOExaminationInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super init];
    if(self){
        self.courseID = [jsonObj safeNumberObjectForKey:@"courseId"];
        self.examID = [jsonObj safeNumberObjectForKey:@"examId"];
        self.uid = [jsonObj safeNumberObjectForKey:@"studentId"];
        if([_uid isEqualToNumber:@(0)]){//TODO...
            self.uid = [jsonObj safeNumberObjectForKey:@"teacherId"];
        }
        self.paperName = [jsonObj safeStringObjectForKey:@"paperName"];
        self.endTime = [jsonObj safeIntObjectForKey:@"endTime"];
        self.redTotal = [jsonObj safeIntObjectForKey:@"redTotal"];
    }
    return self;
}

- (void)cloneExaminationInfo:(EEOExaminationInfo *)examinationInfo {
    self.courseID = examinationInfo.courseID;
    self.examID = examinationInfo.examID;
    self.uid = examinationInfo.uid;
    self.paperName = examinationInfo.paperName;
    self.endTime = examinationInfo.endTime;
    self.redTotal = examinationInfo.redTotal;
}

@end
@implementation EEOStudentExaminationInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super initWithJsonObj:jsonObj];
    if(self){
        self.unreadTotal = [jsonObj safeIntObjectForKey:@"unreadTotal"];
        self.unreadSubmit = [jsonObj safeIntObjectForKey:@"unreadSubmit"];
        self.unreadReview = [jsonObj safeIntObjectForKey:@"unreadReview"];
    }
    return self;
}

- (void)cloneExaminationInfo:(EEOExaminationInfo *)examinationInfo {
    [super cloneExaminationInfo:examinationInfo];
    
    self.unreadTotal = [(EEOStudentExaminationInfo *)examinationInfo unreadTotal];
    self.unreadSubmit = [(EEOStudentExaminationInfo *)examinationInfo unreadSubmit];
    self.unreadReview = [(EEOStudentExaminationInfo *)examinationInfo unreadReview];
}

- (BOOL)isSingle {
    return _unreadTotal == 1;
}
- (BOOL)isShowExamination {
    return _unreadTotal > 0;
}

@end
@implementation EEOTeacherExaminationInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super initWithJsonObj:jsonObj];
    if(self){
        self.inProgress = [jsonObj safeIntObjectForKey:@"inProgress"];
        self.shouldStudent = [jsonObj safeIntObjectForKey:@"shouldStudent"];
        self.endStudent = [jsonObj safeIntObjectForKey:@"endStudent"];
    }
    return self;
}

- (void)cloneExaminationInfo:(EEOExaminationInfo *)examinationInfo {
    [super cloneExaminationInfo:examinationInfo];
    
    self.inProgress = [(EEOTeacherExaminationInfo *)examinationInfo inProgress];
    self.shouldStudent = [(EEOTeacherExaminationInfo *)examinationInfo shouldStudent];
    self.endStudent = [(EEOTeacherExaminationInfo *)examinationInfo endStudent];
}

- (BOOL)isSingle {
    return _inProgress == 1;
}
- (BOOL)isShowExamination {
    return _inProgress > 0;
}

@end

@implementation EEOHomeworkInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super init];
    if(self){
        [self p_parseJsonObj:jsonObj];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOHomeworkInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.homeworkID = self.homeworkID;
    copyObj.courseID = self.courseID;
    copyObj.teacherUID = self.teacherUID;
    copyObj.title = self.title;
    copyObj.status = self.status;
    copyObj.isPublic = self.isPublic;
    copyObj.endTime = self.endTime;
    copyObj.updateTime = self.updateTime;
    copyObj.createTime = self.createTime;
    copyObj.memberNum = self.memberNum;
    copyObj.submittedNum = self.submittedNum;
    copyObj.notMarkingNum = self.notMarkingNum;
    return copyObj;
}

- (void)cloneHomeworkInfo:(EEOHomeworkInfo *)homeworkInfo {
    self.homeworkID = homeworkInfo.homeworkID;
    self.courseID = homeworkInfo.courseID;
    self.teacherUID = homeworkInfo.teacherUID;
    self.title = homeworkInfo.title;
    self.status = homeworkInfo.status;
    self.isPublic = homeworkInfo.isPublic;
    self.endTime = homeworkInfo.endTime;
    self.updateTime = homeworkInfo.updateTime;
    self.createTime = homeworkInfo.createTime;
    self.memberNum = homeworkInfo.memberNum;
    self.submittedNum = homeworkInfo.submittedNum;
    self.notMarkingNum = homeworkInfo.notMarkingNum;
}

- (BOOL)isSingle {
    return self.homeworkID && ![self.homeworkID isEqualToNumber:@(0)];
}

- (NSString *)teacherDisplayName {
    NSString *result = @"";
    if(_teacherUserInfo){
        result = [_teacherUserInfo displayName];
    }
    return result;
}

#pragma mark - Private Methods
- (void)p_parseJsonObj:(NSDictionary *)jsonObj {
    self.homeworkID = [jsonObj safeNumberObjectForKey:@"homework_id"];
    self.courseID = [jsonObj safeNumberObjectForKey:@"client_course_id"];
    self.teacherUID = [jsonObj safeNumberObjectForKey:@"teacher_uid"];
    self.title = [jsonObj safeStringObjectForKey:@"homework_title"];
    self.status = [jsonObj safeIntObjectForKey:@"status"];
    self.isPublic = [jsonObj safeIntObjectForKey:@"is_open"] == 1;
    self.endTime = [jsonObj safeIntObjectForKey:@"end_time"];
    self.updateTime = [jsonObj safeIntObjectForKey:@"update_time"];
    self.createTime = [jsonObj safeIntObjectForKey:@"add_time"];
    self.memberNum = [jsonObj safeIntObjectForKey:@"num"];
    self.submittedNum = [jsonObj safeIntObjectForKey:@"cnum"];
    self.notMarkingNum = [jsonObj safeIntObjectForKey:@"unrnum"];
}

@end
@implementation EEOStudentHomeworkInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super initWithJsonObj:jsonObj];
    if(self){
        self.submitID = [jsonObj safeNumberObjectForKey:@"stu_homework_id"];
        self.submitStatus = [jsonObj safeIntObjectForKey:@"stu_status"];
        self.warnTime = [jsonObj safeIntObjectForKey:@"warn"];
        self.isReform = [jsonObj safeIntObjectForKey:@"reform"] == 1;
        self.isRead = [jsonObj safeIntObjectForKey:@"read_status"] == 1;
        self.markingNum = [jsonObj safeIntObjectForKey:@"th_num"];
        
        self.notSubmittedNum = [jsonObj safeIntObjectForKey:@"uncnum"];
        self.notReadNum = [jsonObj safeIntObjectForKey:@"unrenum"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOStudentHomeworkInfo *copyObj = [super copyWithZone:zone];
    copyObj.submitID = self.submitID;
    copyObj.submitStatus = self.submitStatus;
    copyObj.warnTime = self.warnTime;
    copyObj.isReform = self.isReform;
    copyObj.isRead = self.isRead;
    copyObj.markingNum = self.markingNum;
    
    copyObj.notSubmittedNum = self.notSubmittedNum;
    copyObj.notReadNum = self.notReadNum;
    return copyObj;
}
- (void)cloneHomeworkInfo:(EEOHomeworkInfo *)homeworkInfo {
    [super cloneHomeworkInfo:homeworkInfo];
    
    self.submitID = [(EEOStudentHomeworkInfo *)homeworkInfo submitID];
    self.submitStatus = [(EEOStudentHomeworkInfo *)homeworkInfo submitStatus];
    self.warnTime = [(EEOStudentHomeworkInfo *)homeworkInfo warnTime];
    self.isReform = [(EEOStudentHomeworkInfo *)homeworkInfo isReform];
    self.isRead = [(EEOStudentHomeworkInfo *)homeworkInfo isRead];
    self.markingNum = [(EEOStudentHomeworkInfo *)homeworkInfo markingNum];

    self.notSubmittedNum = [(EEOStudentHomeworkInfo *)homeworkInfo notSubmittedNum];
    self.notReadNum = [(EEOStudentHomeworkInfo *)homeworkInfo notReadNum];
}

@end
@implementation EEOTeacherHomeworkInfo

- (instancetype)initWithJsonObj:(NSDictionary *)jsonObj {
    self = [super initWithJsonObj:jsonObj];
    if(self){
        self.ongoingNum = [jsonObj safeIntObjectForKey:@"hnum"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOTeacherHomeworkInfo *copyObj = [super copyWithZone:zone];
    copyObj.ongoingNum = self.ongoingNum;
    return copyObj;
}
- (void)cloneHomeworkInfo:(EEOHomeworkInfo *)homeworkInfo {
    [super cloneHomeworkInfo:homeworkInfo];
    
    self.ongoingNum = [(EEOTeacherHomeworkInfo *)homeworkInfo ongoingNum];
}

@end

@implementation EEOClassChatMessageReceiptInfo

@end

@implementation EEOClassLastMsgInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassLastMsgInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.lastMsgID = self.lastMsgID;
    copyObj.displayableMsgNum = self.displayableMsgNum;
    copyObj.atMsgID = self.atMsgID;
    copyObj.lastDisplayableMsgID = self.lastDisplayableMsgID;
    copyObj.lastDisplayableMsgSourceUID = self.lastDisplayableMsgSourceUID;
    copyObj.lastDisplayableMsgCommand = self.lastDisplayableMsgCommand;
    copyObj.lastDisplayableMsgData = self.lastDisplayableMsgData;
    copyObj.lastDisplayableMsgTimestamp = self.lastDisplayableMsgTimestamp;
    
    copyObj.chatMessage = self.chatMessage;
    return copyObj;
}

- (NSNumber *)lastMsgID {
    NSNumber *result = _lastMsgID;
    if(_chatMessage.serverMsgID && [_chatMessage.serverMsgID unsignedLongLongValue] > [_lastMsgID unsignedLongLongValue]){
        result = _chatMessage.serverMsgID;
    }
    return result;
}
- (NSNumber *)lastDisplayableMsgSourceUID {
    return _chatMessage.senderId == nil ? _lastDisplayableMsgSourceUID : _chatMessage.senderId;
}
- (NSUInteger)lastDisplayableMsgTimestamp {
    NSUInteger result = _lastDisplayableMsgTimestamp;
    if(_chatMessage.messageTime > _lastDisplayableMsgTimestamp){
        result = _chatMessage.messageTime;
    }
    return result;
}

@end

@implementation EEOClassMemberInfo

static NSMutableDictionary *_otherAllClassMemberCache = nil;
+ (void)saveClassMemberListToCache:(NSArray *)classMemberList classID:(NSNumber *)classID {
    if(_otherAllClassMemberCache == nil){
        _otherAllClassMemberCache = [NSMutableDictionary dictionary];
    }
    @synchronized (_otherAllClassMemberCache) {
        NSMutableDictionary *classMemberMap = _otherAllClassMemberCache[classID];
        if(classMemberMap == nil){
            classMemberMap = [NSMutableDictionary dictionary];
            _otherAllClassMemberCache[classID] = classMemberMap;
        }
        for (EEOClassMemberInfo *classMember in classMemberList) {
            [classMemberMap setObject:classMember forKey:classMember.uid];
        }
    }
}
+ (EEOClassMemberInfo *)classMemberInfoByCacheWithUID:(NSNumber *)uid classID:(NSNumber *)classID {
    EEOClassMemberInfo *result = nil;
    @synchronized (_otherAllClassMemberCache) {
        NSMutableDictionary *classMemberMap = _otherAllClassMemberCache[classID];
        if(classMemberMap){
            result = classMemberMap[uid];
        }
    }
    return result;
}
+ (void)cleanClassMemberCacheWithClassID:(NSNumber *)classID {
    @synchronized (_otherAllClassMemberCache) {
        _otherAllClassMemberCache[classID] = nil;
    }
}
+ (void)cleanAllClassMemberCache {
    @synchronized (_otherAllClassMemberCache) {
        [_otherAllClassMemberCache removeAllObjects];
    }
}

- (instancetype)init {
    self = [super init];
    if(self){
        _userInfo = [[EEOUserInfo alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassMemberInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.timeTag = self.timeTag;
    copyObj.status = self.status;
    copyObj.groupRole = self.groupRole;
    copyObj.role = self.role;
    copyObj.nickName = self.nickName;
    copyObj.gender = self.gender;
    copyObj.tel = self.tel;
    copyObj.email = self.email;
    copyObj.comment = self.comment;
    copyObj.memberSettings = self.memberSettings;
    copyObj.allowSpeakTime = self.allowSpeakTime;

    copyObj.userInfo = [self.userInfo copy];
    copyObj.contactInfo = self.contactInfo;//TODO...
    return copyObj;
}

- (BOOL)isEqualToClassMemberInfo:(EEOClassMemberInfo *)target {
    if(self.groupRole != target.groupRole){
        return NO;
    }
    if(self.role != target.role){
        return NO;
    }
    if(![self.comment isEqualToString:target.comment]){
        return NO;
    }
//    if(self.isLeave != target.isLeave){
//        return NO;
//    }
    
    return YES;
}
- (void)cloneClassMemberInfo:(EEOClassMemberInfo *)classMemberInfo {
    self.timeTag = classMemberInfo.timeTag;
    self.status = classMemberInfo.status;
    self.groupRole = classMemberInfo.groupRole;
    self.role = classMemberInfo.role;
    self.nickName = classMemberInfo.nickName;
    self.gender = classMemberInfo.gender;
    self.tel = classMemberInfo.tel;
    self.email = classMemberInfo.email;
    self.comment = classMemberInfo.comment;
    self.memberSettings = classMemberInfo.memberSettings;
    self.allowSpeakTime = classMemberInfo.allowSpeakTime;
    //TODO...
    
}

- (BOOL)isClassTeacher {
    return _groupRole == GroupRole_Master && _role == ClassRole_Teacher;
}

- (NSUInteger)displayIndex {
    NSUInteger result = 0;
    if([self isClassTeacher]){
        result = 0;
    }else if(_role == ClassRole_Teacher || _role == ClassRole_TeacherAssistant){
        result = 1;
    }else if(_role == ClassRole_Student){
        result = 2;
    }else if(_role == ClassRole_Auditor){
        result = 3;
    }else{
        result = 0xFF;
    }
    return result;
}

- (void)setUID:(NSNumber *)uid {
    if([_userInfo.uid isEqualToNumber:uid]){
        return;
    }
    _userInfo.uid = uid;
}
- (NSNumber *)uid {
    return _userInfo.uid;
}
- (NSString *)displayName {
    NSString *result = @"";
    if (self.nickName.length > 0) {
        result = self.nickName;
    }else{
        result = _userInfo.displayName;
    }
    return result;
}

- (BOOL)isLeave {
    return _status == ClassMemberStatus_Deleted;
}
- (BOOL)isMute {
    return (_memberSettings & ClassMemeberSettingsFlag_Mute) != 0;
}

@end

@implementation EEOClassConfigInfo

- (void)cloneClassConfigInfo:(EEOClassConfigInfo *)configInfo {
    self.timeTag = configInfo.timeTag;
    self.alias = configInfo.alias;
    self.msgSetting = configInfo.msgSetting;
    self.msgFlags = configInfo.msgFlags;
    self.externInfo = configInfo.externInfo;
    self.readCursorMsgID = configInfo.readCursorMsgID;
}

@end

@interface EEOClassInfo (){
}

@property (nonatomic,copy) NSString *originalAvatarURL;
@property (nonatomic,copy) NSString *compressionAvatarURL;
//@property (nonatomic,copy) NSString *thumbnailAvatarURL;

@end
@implementation EEOClassInfo

- (instancetype)init {
    return [self initWithClassID:@(0)];
}
- (instancetype)initWithClassID:(NSNumber *)classID {
    self = [super init];
    if(self){
        _classID = classID;
        _ownerUID = @(0);
        _name = @"";
        _notice = @"";
        _brief = @"";
        _avatarURL = @"";
        
//        _memberList = [[NSMutableArray alloc] init];
        _memberMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSUInteger)hash {
    return [_classID hash];
}

- (BOOL)isEqualToClassInfo:(EEOClassInfo *)target {
    if(![self.ownerUID isEqualToNumber:target.ownerUID]){
        return NO;
    }
    if(self.status != target.status){
        return NO;
    }
    if(![self.name isEqualToString:target.name]){
        return NO;
    }
    if(self.type != target.type){
        return NO;
    }
//    if(self.vipFlag != target.vipFlag){
//        return NO;
//    }
//    if(self.vipLevel != target.vipLevel){
//        return NO;
//    }
    if(![self.brief isEqualToString:target.brief]){
        return NO;
    }
//    if(self.lastMessageTime != target.lastMessageTime){
//        return NO;
//    }
//    if(self.isReminderMessage != target.isReminderMessage){
//        return NO;
//    }
    
    return YES;
}

- (void)cloneClassInfo:(EEOClassInfo *)classInfo {
    self.classID = classInfo.classID;
    self.type = classInfo.type;
    self.timeTag = classInfo.timeTag;
    self.schoolID = classInfo.schoolID;
    self.status = classInfo.status;
    self.ownerUID = classInfo.ownerUID;
    self.name = classInfo.name;
    self.classAttribute = classInfo.classAttribute;
    self.authType = classInfo.authType;
    self.memberCardPermission = classInfo.memberCardPermission;
    self.globalMemberSettings = classInfo.globalMemberSettings;
    self.notice = classInfo.notice;
    self.brief = classInfo.brief;
    self.avatarURL = classInfo.avatarURL;
}

- (void)setAvatarURL:(NSString *)avatarURL {
    if([_avatarURL isEqualToString:avatarURL]){
        return;
    }
    
    _avatarURL = [avatarURL copy];
    if(_avatarURL.length <= 0){
        _originalAvatarURL = @"";
        _compressionAvatarURL = @"";
        _thumbnailAvatarURL = @"";
        return;
    }
    
    NSString *outOriginalURL = @"";
    NSString *outCompressionURL = @"";
    NSString *outThumbnailURL = @"";
    [NSString parseAvatarURLJsonStr:_avatarURL outOriginalURL:&outOriginalURL outCompressionURL:&outCompressionURL outThumbnailURL:&outThumbnailURL];
    
    _originalAvatarURL = outOriginalURL;
    _compressionAvatarURL = outCompressionURL;
    _thumbnailAvatarURL = outThumbnailURL;
}

- (NSString *)displayName {
    NSString *result = _name;
    
    //先判断是否需要从服务器加载详细信息
    if(_timeTag == nil || [_timeTag unsignedLongLongValue] <= 0){
        [_delegate classInfoNeedToLoadInfo:self];
    }
    
    if(_configInfo && _configInfo.alias.length > 0){
        result = _configInfo.alias;
    }else{
        if(_type == ClassType_Contact || [self isSingleClass]){
            NSNumber *uid = EEOUserInfo.mine.uid;
//            NSArray *tempList = [NSArray arrayWithArray:_memberList];
            NSArray *tempList = [self memberList];
            for (EEOClassMemberInfo *info in tempList) {
                if(![info.uid isEqualToNumber:uid] && ![info.uid isEqualToNumber:@(0)]){
                    result = info.displayName;
                    break;
                }
            }
        }else if(_type == ClassType_Common && result.length <= 0 && _courseInfo.displayName.length > 0){
            result = _courseInfo.displayName;
        }else if(_type == ClassType_Group && result.length <= 0 && self.memberMap.count > 0 /*_memberList.count > 0*/){
            NSNumber *uid = EEOUserInfo.mine.uid;
//            NSArray *tempList = [NSArray arrayWithArray:_memberList];
            NSArray *tempList = [self memberList];
            for (EEOClassMemberInfo *info in tempList) {
                if(info.status == ClassMemberStatus_Normal && ![info.uid isEqualToNumber:uid]){
                    NSString *memberDisplayName = [info displayName];
                    if(result.length <= 0){
                        result = memberDisplayName;
                    }else{
                        if(result.length + memberDisplayName.length > 60){//超过最大长度就不用遍历了
                            if(memberDisplayName.length > 3){
                                result = [NSString stringWithFormat:@"%@、%@",result,[memberDisplayName substringToIndex:3]];
                            }
                            //防止大屏幕设备能够显示全60个字符的情况
                            result = [result stringByAppendingString:@"..."];
                            break;
                        }else{
                            result = [NSString stringWithFormat:@"%@、%@",result,[info displayName]];
                        }
                    }
                }
            }
        }else{
            //TODO...
        }
    }
    result = result == nil ? @"" : result;
    return result;
}
- (BOOL)isReminderMessage {
    BOOL result = YES;//默认可打扰
    if(_configInfo){
        result = (_configInfo.msgFlags & ClassMsgFlags_isReminderMessage) == 0;
    }
    return result;
}
- (BOOL)isHidden {
    BOOL result = NO;//默认不隐藏
    if(_configInfo){
        result = (_configInfo.msgFlags & ClassMsgFlags_isHidden) != 0;
    }
    return result;
}

- (BOOL)isGlobalMute {
    return (_globalMemberSettings & ClassMemeberSettingsFlag_Mute) != 0;
}

/*
- (NSString *)name {
    NSString *result = _name;
    if(_type == ClassType_Contact || [self isSingleClass]){
        NSNumber *uid = EEOUserInfo.mine.uid;
        NSArray *tempList = [NSArray arrayWithArray:_memberList];
        for (EEOClassMemberInfo *info in tempList) {
            if(![info.uid isEqualToNumber:uid] && ![info.uid isEqualToNumber:@(0)]){
                result = info.displayName;
                break;
            }
        }
    }else if(_type == ClassType_Common && result.length <= 0 && _courseInfo.name.length > 0){
        result = _courseInfo.name;
    }
    return result;
}
*/
- (NSString *)originalAvatarURL {
    NSString *result = _originalAvatarURL;
    if(_type == ClassType_Common && result.length <= 0 && _courseInfo.originalAvatarURL.length > 0){
        result = _courseInfo.compressionAvatarURL;
    }
    return result;
}
- (NSString *)compressionAvatarURL {
    NSString *result = _compressionAvatarURL;
    if(_type == ClassType_Common && result.length <= 0 && _courseInfo.compressionAvatarURL.length > 0){
        result = _courseInfo.compressionAvatarURL;
    }
    return result;
}
- (NSString *)thumbnailAvatarURL {
    NSString *result = _thumbnailAvatarURL;
    if(_type == ClassType_Contact || [self isSingleClass]){
        NSNumber *uid = EEOUserInfo.mine.uid;
//        NSArray *tempList = [NSArray arrayWithArray:_memberList];
        NSArray *tempList = [self memberList];
        for (EEOClassMemberInfo *info in tempList) {
            if(![info.uid isEqualToNumber:uid] && ![info.uid isEqualToNumber:@(0)]){
                result = info.userInfo.thumbnailAvatarURL;
                break;
            }
        }
    }else if(_type == ClassType_Common && result.length <= 0 && _courseInfo.thumbnailAvatarURL.length > 0){
        result = _courseInfo.thumbnailAvatarURL;
    }
    return result;
}

- (EEOClassMemberInfo *)memberWithUID:(NSNumber *)uid {
    EEOClassMemberInfo *result = nil;
    /*
    NSArray *tempList = [NSArray arrayWithArray:_memberList];
    for (EEOClassMemberInfo *info in tempList) {
        if([info.uid isEqualToNumber:uid]){
            result = info;
            break;
        }
    }
    */
    if(uid){
        result = self.memberMap[uid];
    }
    return result;
}
- (EEOClassMemberInfo *)contactClassMemberInfoWithUID:(NSNumber *)uid {
    EEOClassMemberInfo *result = nil;
    if(_type == ClassType_Contact){
        EEOClassMemberInfo *memberInfo = self.memberMap[uid];
        if(memberInfo && _configInfo && _configInfo.alias.length > 0){
            result = [memberInfo copy];
            result.nickName = _configInfo.alias;
        }
    }
    return result;
}
- (NSArray *)memberList {
    return [self.memberMap.allValues copy];
}

- (EEOClassMemberInfo *)friendsInfo {
    if(self.type == ClassType_Contact || [self isSingleClass]){
//        NSArray *tempList = [_memberList copy];
        NSArray *tempList = [self memberList];
        for(EEOClassMemberInfo *info in tempList){
            if(![info.uid isEqualToNumber:[EEOUserInfo mine].uid] && ![info.uid isEqualToNumber:@(0)]){
                return info;
            }
        }
    }
    return nil;
}

- (BOOL)isSingleClass {
    uint64_t temp = [_classAttribute unsignedLongLongValue];
    return (temp & ClassAttributeFlag_Single) != 0;
}

- (NSUInteger)unreadMsgCount {
    NSUInteger result = 0;
    /*
    if(_lastMsgInfo.lastMsgID && _configInfo.readCursorMsgID){
        if([_lastMsgInfo.lastMsgID unsignedLongLongValue] > [_configInfo.readCursorMsgID unsignedLongLongValue]){
            result = [_lastMsgInfo.lastMsgID unsignedLongLongValue] - [_configInfo.readCursorMsgID unsignedLongLongValue];
        }
    }
    */
    if(_lastMsgInfo){
        result = _lastMsgInfo.displayableMsgNum;
    }
    return result;
}

- (BOOL)isAllowAnyoneJoinClass {
    BOOL result = NO;
    if(_courseInfo){
        result = _courseInfo.attribute & 0x1;
    }
    return result;
}
- (BOOL)isDontAddFriends {
    BOOL result = NO;
    if(_courseInfo){
        result = _courseInfo.attribute & 0x2;
    }
    return result;
}
- (BOOL)isAllowTeachersCreateLesson {
    BOOL result = NO;
    if(_courseInfo){
        result = _courseInfo.attribute & 0x4;
    }
    return result;
}
- (BOOL)isDontCreateTempClassroom {
    BOOL result = NO;
    if(_courseInfo){
        result = _courseInfo.attribute & 0x8;
    }
    return result;
}
- (BOOL)isClassWebPageCanJoinClass {
    BOOL result = NO;
    if(_courseInfo){
        result = _courseInfo.attribute & 0x10;
    }
    return result;
}

- (NSDictionary *)displayLastMessageContentDic {
    NSDictionary *result = _lastMsgInfo.chatMessage.messageContentDic;
    if(result.count > 0){
        id isReadyObj = [_lastMsgInfo.chatMessage getLocalContentValueWithKey:@"isReady"];
        if(isReadyObj && [isReadyObj boolValue] == NO){
            //触发按需加载...
            [_delegate classInfoNeedToLoadLastMsgInfo:self];
        }
    }
    return result;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"classID=%@,timeTag=%@,type=%zi,name=%@", _classID,_timeTag,_type,_name];
}

@end

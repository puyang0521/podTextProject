//
//  EEOClassroomTabBlackboardInfo.m
//  EEOEntity
//
//  Created by HeQian on 16/8/8.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomTabBlackboardInfo.h"

#import "EEOClassroomMember.h"

#import <UIKit/UIColor.h>

@implementation TabBlackboardMember

- (instancetype)initWithUID:(NSNumber *)uid andDisplayName:(NSString *)displayName andIdentity:(NSUInteger)identity {
    self = [super init];
    if(self){
        _uid = uid;
        _displayName = displayName;
        _identity = identity;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    TabBlackboardMember *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.uid = self.uid;
    copyObj.displayName = self.displayName;
    copyObj.identity = self.identity;
    copyObj.isMarked = self.isMarked;
    
    copyObj.isOnline = self.isOnline;
    copyObj.isOnStage = self.isOnStage;
        
    return copyObj;
}

- (BOOL)isTeacher {
    return _identity == 0x03;
}

@end
@implementation EEOClassroomTabBlackboardInfo

- (instancetype)init {
    self = [super init];
    if(self){
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTabBlackboardInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.type = self.type;
    copyObj.memberList = [self.memberList copy];
    copyObj.currentMemberId = self.currentMemberId;
    copyObj.state = self.state;
    copyObj.x = self.x;
    copyObj.y = self.y;
    copyObj.w = self.w;
    copyObj.h = self.h;
    copyObj.zIndex = self.zIndex;
    copyObj.isInitiativeSide = self.isInitiativeSide;
    copyObj.questionData = self.questionData;
    copyObj.isNeedLoadQuestionData = self.isNeedLoadQuestionData;
    
    return copyObj;
}

- (BOOL)isParticipantsRoleWIthUID:(NSNumber *)uid {
    BOOL result = NO;
    NSArray *memberList = [NSArray arrayWithArray:self.memberList];
    for (TabBlackboardMember *member in memberList) {
        if([uid isEqualToNumber:member.uid]){
            result = YES;
            break;
        }
    }
    return result;
}

- (TabBlackboardMember *)teacher {
    __block TabBlackboardMember *teacher = [[TabBlackboardMember alloc] init];
    [self.memberList enumerateObjectsUsingBlock:^(TabBlackboardMember *member, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([member isTeacher]) {
            teacher = member;
        }
    }];
    return teacher;
}

- (NSString *)typeStr {
    NSString *result = @"";
    if(_type == TabBlackboardType_Draw){
        result = @"d";
    }else if(_type == TabBlackboardType_Text){
        result = @"t";
    }else if(_type == TabBlackboardType_Go){
        result = @"s";
    }
    return result;
}

- (void)setXYWHWithRect:(CGRect)rect {
    _x = rect.origin.x;
    _y = rect.origin.y;
    _w = rect.size.width;
    _h = rect.size.height;
}

- (NSArray *)detectNoBoardStudent:(NSArray *)allStudent {
    NSMutableArray *result = [NSMutableArray array];
    for (EEOClassroomMember *member in allStudent) {
        if(![self isParticipantsRoleWIthUID:member.uid]){
            [result addObject:member];
        }
    }
    return [result copy];
}
- (BOOL)isNewProtocolUsed {
    return _questionData != nil;
}

- (NSArray *)displayMemberList {
    NSArray *result = [self.memberList copy];
    NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"isTeacher" ascending:NO];
    NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"isOnline" ascending:NO];
    NSSortDescriptor *sd3 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES comparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
        return [obj1 localizedCompare:obj2];
    }];
    result = [result sortedArrayUsingDescriptors:@[sd1,sd2,sd3]];
    return result;
}

@end

@implementation EEOClassroomDrawTabBlackboardInfo

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = TabBlackboardType_Draw;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomDrawTabBlackboardInfo *copyObj = [super copyWithZone:zone];
    return copyObj;
}

@end

@implementation EEOClassroomTextTabBlackboardInfo

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = TabBlackboardType_Text;
        self.textPlayerInfoDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTextTabBlackboardInfo *copyObj = [super copyWithZone:zone];
    copyObj.textPlayerInfoDic = [self.textPlayerInfoDic mutableCopy];
    
    return copyObj;
}

- (void)safeSetPlayerStatusToDic:(NSNumber *)uid status:(NSString *)status {
    @synchronized (self) {
        self.textPlayerInfoDic[uid] = status;
    }
}
- (NSString *)safeGetPlayerStatusFromDic:(NSNumber *)uid {
    NSString *result = nil;
    @synchronized (self) {
        result = self.textPlayerInfoDic[uid];
    }
    return result;
}

- (NSString *)fileContentFromQuestionData {
    NSString *result = nil;
    if(self.questionData && [self.questionData isKindOfClass:[NSArray class]] && [self.questionData count] > 0){
        result = self.questionData[0];
    }
    return result;
}
- (NSString *)languageFromQuestionData {
    NSString *result = nil;
    if(self.questionData && [self.questionData isKindOfClass:[NSArray class]] && [self.questionData count] > 1){
        result = self.questionData[1];
    }
    return result;
}

@end

@implementation EEOClassroomGoTabBlackboardInfo

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = TabBlackboardType_Go;
        self.goPlayerInfoDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomGoTabBlackboardInfo *copyObj = [super copyWithZone:zone];
    copyObj.pathNumber = self.pathNumber;
    copyObj.isTeacherFirst = self.isTeacherFirst;
    copyObj.goPlayerInfoDic = [self.goPlayerInfoDic mutableCopy];
    
    return copyObj;
}

- (NSUInteger)pathNumberFromQuestionData {
    NSUInteger result = 0;
    if(self.questionData && [self.questionData isKindOfClass:[NSArray class]] && [self.questionData count] > 0){
        result = [self.questionData[0] integerValue];
    }
    return result;
}
- (BOOL)isTeacherFirstFromQuestionData {
    BOOL result = NO;
    if(self.questionData && [self.questionData isKindOfClass:[NSArray class]] && [self.questionData count] > 1){
        result = [self.questionData[1] boolValue];
    }
    return result;
}
- (NSArray *)actionListFromQuestionData {
    NSArray *result = nil;
    if(self.questionData && [self.questionData isKindOfClass:[NSArray class]] && [self.questionData count] > 2){
        result = self.questionData[2];
    }
    return result;
}

@end


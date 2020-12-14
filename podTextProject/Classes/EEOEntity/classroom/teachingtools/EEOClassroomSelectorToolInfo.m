//
//  EEOClassroomSelectorToolInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/10/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomSelectorToolInfo.h"

@implementation SelectorToolStudentAnswerInfo

- (instancetype)initWitUID:(NSNumber *)uid {
    self = [super init];
    if(self){
        _uid = uid;
        _commited = 0;
        _name = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    SelectorToolStudentAnswerInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.uid = self.uid;
    copyObj.selectedItemList = self.selectedItemList;
    copyObj.commited = self.commited;
    copyObj.utcRecvQuestionTime = self.utcRecvQuestionTime;
    copyObj.utcLastCommitTime = self.utcLastCommitTime;
    copyObj.name = self.name;
    return copyObj;
}

- (BOOL)isAnswered {
    return _commited == SelectorToolStudentAnswerCommitedState_Commited;
}

- (NSUInteger)currentCommitedSecondsNum {
    NSUInteger result = 0;
    if(_utcLastCommitTime > _utcRecvQuestionTime){
        result = _utcLastCommitTime - _utcRecvQuestionTime;
    }
    return result;
}

- (NSString *)selectedItemListToString {
    return [NSString stringWithFormat:@"%@",self.selectedItemList];
}

@end

@implementation SelectorToolMember

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
    SelectorToolMember *copyObj = [[self class] allocWithZone:zone];
    copyObj.uid = self.uid;
    copyObj.displayName = self.displayName;
    copyObj.identity = self.identity;
    copyObj.isOnline = self.isOnline;
    copyObj.isOnStage = self.isOnStage;
    return copyObj;
}

- (BOOL)isTeacher {
    return _identity == 0x03;
}

@end

@interface EEOClassroomSelectorToolInfo (){
}
@end

@implementation EEOClassroomSelectorToolInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _memberList = [NSMutableArray array];
        _studentAnswerInfoDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomSelectorToolInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.x = self.x;
    copyObj.y = self.y;
    copyObj.w = self.w;
    copyObj.h = self.h;
    copyObj.zIndex = self.zIndex;
    copyObj.correctItems = [self.correctItems copy];
    copyObj.allItems = [self.allItems copy];
    copyObj.memberList = self.memberList;
    copyObj.questionSentTime = self.questionSentTime;
    copyObj.questionCollectTime = self.questionCollectTime;
    copyObj.state = self.state;
    copyObj.studentAnswerInfoDic = [self.studentAnswerInfoDic copy];
    return copyObj;
}

- (NSUInteger)allItemCount {
    return self.allItems.count;
}

- (SelectorToolMember *)memberWithUID:(NSNumber *)uid {
    SelectorToolMember *result = nil;
    NSArray *tempList = [self.memberList copy];
    for (SelectorToolMember *member in tempList) {
        if([uid isEqualToNumber:member.uid]){
            result = member;
            break;
        }
    }
    return result;
}

- (nullable SelectorToolStudentAnswerInfo *)studentAnswerInfoWithUID:(NSNumber *)uid {
    SelectorToolStudentAnswerInfo *result = nil;
    @synchronized (self) {
        result = self.studentAnswerInfoDic[uid];
    }
    return result;
}

- (NSInteger)calculationAnswerAccuracy:(SelectorToolStudentAnswerInfo *)answerInfo {
    NSInteger accuracy = 0;
    
    NSString *correctItemsString = [NSString stringWithFormat:@"%@",self.correctItems];
    NSString *answerItemsString = [NSString stringWithFormat:@"%@",answerInfo.selectedItemList];
    if ([correctItemsString isEqualToString:answerItemsString]) {
        accuracy = 100;
    } else {
        NSInteger rightCount = 0;
        for (NSNumber *tempAnswer in self.correctItems) {
            for (NSNumber *tempSelected in answerInfo.selectedItemList) {
                if ([tempAnswer isEqualToNumber:tempSelected]) {
                    rightCount++;
                }
            }
        }
        
        accuracy = round(rightCount * 100.0 / (MAX(self.correctItems.count, answerInfo.selectedItemList.count) * 1.0));
        accuracy = MIN(100, accuracy);
    }
    return accuracy;
}

- (BOOL)isAnswerRoleWIthUID:(NSNumber *)uid {
    BOOL result = [self studentAnswerInfoWithUID:uid] != nil;
    /*
    NSArray *tempList = [NSArray arrayWithArray:self.memberList];
    for (SelectorToolMember *member in tempList) {
        if([uid isEqualToNumber:member.uid]){
            result = YES;
            break;
        }
    }
    */
    return result;
}

- (NSUInteger)answeredMemberNum {
    __block NSUInteger result = 0;
    NSDictionary *tempDic = nil;
    @synchronized (self) {
        tempDic = [self.studentAnswerInfoDic copy];
    }
    [tempDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull uid, SelectorToolStudentAnswerInfo * _Nonnull obj, BOOL * _Nonnull stop) {
        if(obj.commited == SelectorToolStudentAnswerCommitedState_Commited){
            result ++;
        }
    }];
    return result;
}

- (NSUInteger)accuracyRate {
    __block NSUInteger result = 0;
    NSString *correctItemsString = [NSString stringWithFormat:@"%@",self.correctItems];
    
    NSDictionary *tempDic = nil;
    @synchronized (self) {
        tempDic = [self.studentAnswerInfoDic copy];
    }
    [tempDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull uid, SelectorToolStudentAnswerInfo * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *selectedItemsString = [NSString stringWithFormat:@"%@",obj.selectedItemList];
        if([correctItemsString isEqualToString:selectedItemsString]){
            result ++;
        }
    }];
    result = (float)result / [self answerMemberTotalNum] * 100;
    return result;
}

- (NSUInteger)answerMemberTotalNum {
    return self.memberList.count;
}

- (void)safetyRemoveStudentAnswerInfoWithUID:(NSNumber *)uid {
    @synchronized (self) {
        [self.studentAnswerInfoDic removeObjectForKey:uid];
    }
}
- (void)safetySetStudentAnswerInfo:(SelectorToolStudentAnswerInfo *)info {
    NSNumber *uid = info.uid;
    if(uid){
        @synchronized (self) {
            self.studentAnswerInfoDic[uid] = info;
        }
    }
}

@end

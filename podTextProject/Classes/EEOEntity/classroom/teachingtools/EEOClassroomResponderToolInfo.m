//
//  EEOClassroomResponderToolInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/11/16.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomResponderToolInfo.h"

@implementation ResponderToolStudentResponderInfo

- (instancetype)initWitUID:(NSNumber *)uid {
    self = [super init];
    if(self){
        _uid = uid;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    ResponderToolStudentResponderInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.uid = self.uid;
    copy.displayName = self.displayName;
    copy.stageState = self.stageState;
    copy.time = self.time;
    copy.isOnline = self.isOnline;
    copy.isOnStage = self.isOnStage;
    return copy;
}

@end

@implementation ResponderToolMember

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
    ResponderToolMember *copy = [[[self class] allocWithZone:zone] init];
    copy.uid = self.uid;
    copy.displayName = self.displayName;
    copy.identity = self.identity;
    return copy;
}

- (BOOL)isTeacher {
    return _identity == 0x03;
}

@end

@implementation EEOClassroomResponderToolInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomResponderToolInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.x = self.x;
    copy.y = self.y;
    copy.w = self.w;
    copy.h = self.h;
    copy.zIndex = self.zIndex;
    
    NSMutableArray *memberList = [[NSMutableArray alloc] init];
    for (ResponderToolMember *member in self.memberList) {
        [memberList addObject:[member copy]];
    }
    copy.memberList = memberList;
    
    copy.state = self.state;
    
    copy.randomTopX = self.randomTopX;
    copy.randomTopY = self.randomTopY;
    copy.endTime = self.endTime;
    
    copy.studentResponderInfo = [self.studentResponderInfo copy];
    
    //TODO...
    copy.studentTimeCostDic = [self.studentTimeCostDic copy];
    
    return copy;
}

- (NSMutableDictionary *)studentTimeCostDic {
    if(_studentTimeCostDic == nil){
        _studentTimeCostDic = [[NSMutableDictionary alloc] init];
    }
    return _studentTimeCostDic;
}

- (BOOL)isResponderRoleWithUID:(NSNumber *)uid {
    BOOL result = NO;
    for (ResponderToolMember *member in _memberList) {
        if([uid isEqualToNumber:member.uid]){
            result = YES;
            break;
        }
    }
    return result;
}

- (BOOL)haveResponderMember {
    return _studentTimeCostDic.count > 0;
}

- (BOOL)isWaitStateWithUID:(NSNumber *)uid {
    return _studentTimeCostDic[uid] != nil;
}

- (ResponderToolStudentResponderInfo *)buidCurrentResponderMember {
    ResponderToolStudentResponderInfo *result = nil;
    if(_studentTimeCostDic.count > 0){
        NSArray *uidList = _studentTimeCostDic.allKeys;
        NSArray *costList = _studentTimeCostDic.allValues;
        
        NSArray *sortedCostList = [costList sortedArrayUsingSelector:@selector(compare:)];
        NSNumber *finalCost = [sortedCostList firstObject];
        NSUInteger uidListIndex = [costList indexOfObject:finalCost];
        NSNumber *finalUID = uidList[uidListIndex];
        ResponderToolMember *member = [self memberWithUID:finalUID];
        if(member){
            result = [[ResponderToolStudentResponderInfo alloc] initWitUID:finalUID];
            result.displayName = member.displayName;
            result.time = 0;
        }
    }
    return result;
}

- (ResponderToolMember *)memberWithUID:(NSNumber *)uid {
    ResponderToolMember *result = nil;
    for (ResponderToolMember *member in _memberList) {
        if([member.uid isEqualToNumber:uid]){
            result = member;
            break;
        }
    }
    return result;
}

@end

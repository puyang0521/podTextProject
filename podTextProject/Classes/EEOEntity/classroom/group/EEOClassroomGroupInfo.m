//
//  EEOClassroomGroupInfo.m
//  EEOEntity
//
//  Created by 蒋敏 on 2020/5/28.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomGroupInfo.h"

#import "EEOClassroomMember.h"

@implementation EEOClassroomGroupForwardingPolicyInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _sourceUID = @(0);
        _targetUIDList = @[];
        _targetGroupList = @[];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomGroupForwardingPolicyInfo *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.packetFamily = self.packetFamily;
    
    copyObj.sourceFlag = self.sourceFlag;
    copyObj.sourceGroupID = self.sourceGroupID;
    copyObj.sourceUID = self.sourceUID;
    
    copyObj.isBroadcast = self.isBroadcast;
    copyObj.targetUIDList = self.targetUIDList;
    copyObj.targetGroupList = self.targetGroupList;
    return copyObj;
}

- (void)cloneForwardingPolicyInfo:(EEOClassroomGroupForwardingPolicyInfo *)info {
    self.packetFamily = info.packetFamily;
    
    self.sourceFlag = info.sourceFlag;
    self.sourceGroupID = info.sourceGroupID;
    self.sourceUID = info.sourceUID;
    
    self.isBroadcast = info.isBroadcast;
    self.targetUIDList = info.targetUIDList;
    self.targetGroupList = info.targetGroupList;
}

- (BOOL)isAudienceWithUID:(NSNumber *)uid {
    BOOL result = NO;
    if(_packetFamily == ClassroomGroupPacketFamilyType_Media_Audio && _sourceFlag == ClassroomGroupForwardingPolicySourceFlag_Group){
        result = [_targetUIDList indexOfObject:uid] != NSNotFound;
    }
    return result;
}

- (BOOL)isBroadcastAudioDataWithUID:(NSNumber *)uid channel:(NSUInteger)channel {
    BOOL result = NO;
    NSUInteger finalPacketFamily = channel == 0 ? ClassroomGroupPacketFamilyType_Media_Audio : ClassroomGroupPacketFamilyType_Media_Audio2;
    if(_packetFamily == finalPacketFamily){
        result = [uid isEqualToNumber:_sourceUID] && _isBroadcast;
    }
    return result;
}
- (BOOL)isBroadcastVideoDataWithUID:(NSNumber *)uid channel:(NSUInteger)channel {
    BOOL result = NO;
    NSUInteger finalPacketFamily = channel == 0 ? ClassroomGroupPacketFamilyType_Media_Video : ClassroomGroupPacketFamilyType_Media_Video2;
    if(_packetFamily == finalPacketFamily){
        result = [uid isEqualToNumber:_sourceUID] && _isBroadcast;
    }
    return result;
}

- (BOOL)isForwardingIMDataWithUID:(NSNumber *)uid {
    BOOL result = NO;
    if(_packetFamily == ClassroomGroupPacketFamilyType_IM && _sourceFlag == ClassroomGroupForwardingPolicySourceFlag_Group){
        result = [_targetUIDList indexOfObject:uid] != NSNotFound;
    }
    return result;
}

@end

@implementation EEOClassroomGroupInfo

static EEOClassroomGroupInfo *_currentGroup = nil;
+ (void)setCurrentGroup:(EEOClassroomGroupInfo *)currentGroup {
    _currentGroup = currentGroup;
}
+ (EEOClassroomGroupInfo *)currentGroup {
    return _currentGroup;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"";
        _memberList = [NSMutableArray array];
        _screenShotMemberId = @(0);
    }
    return self;
}

- (EEOClassroomMember *)memberInfoWithUID:(NSNumber *)uid {
    EEOClassroomMember *result = nil;
    NSArray *tempList = [self.memberList copy];
    for (EEOClassroomMember *memberInfo in tempList) {
        if([uid isEqualToNumber:memberInfo.uid]){
            result = memberInfo;
            break;
        }
    }
    return result;
}

- (EEOClassroomMember *)groupLeaderInfo {
    EEOClassroomMember *result = nil;
    NSArray *tempList = [self.memberList copy];
    for (EEOClassroomMember *memberInfo in tempList) {
        NSUInteger role = memberInfo.groupRole;
        if(_type != ClassroomGroupType_Real){
            role = memberInfo.plannedGroupRole;
        }
        if(role == ClassroomGroupRole_Leader){
            result = memberInfo;
            break;
        }
    }
    return result;
}

- (EEOClassroomMember *)uploadImageMember {
    EEOClassroomMember *result = nil;
    NSArray *tempList = [self.memberList copy];
    NSMutableArray *onLineMembers = [NSMutableArray array];
    for (EEOClassroomMember *member in tempList) {
        if (member.isOnline && member.isStudent) {
            if (member.clientType == ClientType_PC) {
                result = member;
                break;
            } else {
                [onLineMembers addObject:member];
            }
        }
    }
    if (!result && onLineMembers.count > 0) {
        NSMutableArray *ipadMembers = [NSMutableArray array];
        for (EEOClassroomMember *member in onLineMembers) {
            if (member.clientType == ClientType_iPad) {
                [ipadMembers addObject:member];
            }
        }
        if (ipadMembers.count > 0) {
            NSInteger random = arc4random() % ipadMembers.count;
            result = ipadMembers[random];
        } else {
            NSInteger random = arc4random() % onLineMembers.count;
            result = onLineMembers[random];
        }
    }
    return result;
}

- (NSArray *)memberListSorted {
    NSMutableArray *tempMutList = [NSMutableArray arrayWithArray:self.memberList];
    NSSortDescriptor *sd1 = nil;
    if(_type == ClassroomGroupType_Real){
        sd1 = [[NSSortDescriptor alloc] initWithKey:@"groupRole" ascending:NO];
    }else{
        sd1 = [[NSSortDescriptor alloc] initWithKey:@"plannedGroupRole" ascending:NO];
    }
    NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"isOnline" ascending:NO];
    NSSortDescriptor *sd3 = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:YES];
    [tempMutList sortUsingDescriptors:@[sd1,sd2,sd3]];
    NSArray *result = [tempMutList copy];
    return result;
}
- (NSArray *)onStageMemberListSorted {
    NSMutableArray *tempMutList = [NSMutableArray arrayWithArray:self.memberList];
    NSSortDescriptor *sd1 = nil;
    if(_type == ClassroomGroupType_Real){
        sd1 = [[NSSortDescriptor alloc] initWithKey:@"groupRole" ascending:NO];
    }else{
        sd1 = [[NSSortDescriptor alloc] initWithKey:@"plannedGroupRole" ascending:NO];
    }
    NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"isOnline" ascending:NO];
    NSSortDescriptor *sd3 = [[NSSortDescriptor alloc] initWithKey:@"offStageTime" ascending:YES];
    [tempMutList sortUsingDescriptors:@[sd1,sd2,sd3]];
    NSArray *result = [tempMutList copy];
    return result;
}

- (NSArray *)groupOnlinedStudentList {
    NSMutableArray *tempList = [NSMutableArray array];
    for (EEOClassroomMember *member in self.memberList) {
        if (member.isOnline && member.isStudent && member.groupRole != ClassroomGroupRole_Leader) {
            [tempList addObject:member];
        }
    }
    NSArray *result = [tempList copy];
    return result;
}

- (NSArray *)groupOnlinedMemberList {
    NSMutableArray *tempList = [NSMutableArray array];
    for (EEOClassroomMember *member in self.memberList) {
        if (member.isOnline && member.isStudent) {
            [tempList addObject:member];
        }
    }
    NSArray *result = [tempList copy];
    return result;
}

#pragma mark - NSObject
- (NSString *)description {
    return [NSString stringWithFormat:@"groupInfo::groupID=%zi,type=%zi,name=%@,memberCount=%zi", _groupID,_type,_name,_memberList.count];
}

@end

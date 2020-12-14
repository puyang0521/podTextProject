//
//  EEOClassroomGroupInfo.h
//  EEOEntity
//
//  Created by 蒋敏 on 2020/5/28.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ClassroomGroupType){
    ClassroomGroupType_Pre         = 0,     /* 预分组 */
    ClassroomGroupType_Real        = 1,     /* 实时分组 */
};

typedef NS_ENUM(NSUInteger,ClassroomGroupPacketFamilyType){
    ClassroomGroupPacketFamilyType_Mole = 0,     /* Mole族 */
    ClassroomGroupPacketFamilyType_IM,             /* IM族 */
    ClassroomGroupPacketFamilyType_Media_Audio,     /* 音频 */
    ClassroomGroupPacketFamilyType_Media_Video,     /* 视频 */
    ClassroomGroupPacketFamilyType_Media_ShareAudio,     /* 共享音频 */
    ClassroomGroupPacketFamilyType_Media_ShareVideo,     /* 共享视频 */
    ClassroomGroupPacketFamilyType_Media_Velocity,     /* 测速结果 */
    ClassroomGroupPacketFamilyType_Media_Laserpen,     /* 激光笔 */
    ClassroomGroupPacketFamilyType_Media_Audio2,     /* 第二路音频 */
    ClassroomGroupPacketFamilyType_Media_Video2,     /* 第二路视频 */
};
typedef NS_ENUM(NSUInteger,ClassroomGroupForwardingPolicySourceFlag){
    ClassroomGroupForwardingPolicySourceFlag_GroupAndUser,     /* 同时指定 GroupID 和 UID */
    ClassroomGroupForwardingPolicySourceFlag_User,             /* 仅指定用户，不限定分组 */
    ClassroomGroupForwardingPolicySourceFlag_Group,            /* 仅指定分组，不限定用户 */
    ClassroomGroupForwardingPolicySourceFlag_Any,              /* 任意用户 */
};

@interface EEOClassroomGroupForwardingPolicyInfo : NSObject<NSCopying>

@property (nonatomic,assign) ClassroomGroupPacketFamilyType packetFamily;

#pragma mark - 发送源相关
@property (nonatomic,assign) ClassroomGroupForwardingPolicySourceFlag sourceFlag;
@property (nonatomic,assign) NSUInteger sourceGroupID;
@property (nonatomic,copy) NSNumber *sourceUID;

#pragma mark - 接收者相关
@property (nonatomic,assign) BOOL isBroadcast;
@property (nonatomic,copy) NSArray *targetUIDList;
@property (nonatomic,copy) NSArray *targetGroupList;//二维数组:groupID,memberIDNum,memberIDList

- (void)cloneForwardingPolicyInfo:(EEOClassroomGroupForwardingPolicyInfo *)info;

/// 是否为实现旁听功能的转发表
/// @param uid 目标UID
- (BOOL)isAudienceWithUID:(NSNumber *)uid;

/// 是否为广播音频数据的转发表
/// @param uid 源UID
/// @param channel 第几路音频
- (BOOL)isBroadcastAudioDataWithUID:(NSNumber *)uid channel:(NSUInteger)channel;
/// 是否为广播视频数据的转发表
/// @param uid 源UID
/// @param channel 第几路视频
- (BOOL)isBroadcastVideoDataWithUID:(NSNumber *)uid channel:(NSUInteger)channel;

/// 是否正在将IM数据转发给目标
/// @param uid 目标uid
- (BOOL)isForwardingIMDataWithUID:(NSNumber *)uid;

@end

@class EEOClassroomMember;
@interface EEOClassroomGroupInfo : NSObject

/// 当前自己所在的实时分组，如果教室没有分组则返回nil
@property (nullable,class) EEOClassroomGroupInfo *currentGroup;

@property (nonatomic,assign) NSUInteger groupID;
/// 实时分组还是预分组 0=预分组，1=实时分组
@property (nonatomic,assign) ClassroomGroupType type;
@property (nonatomic,copy) NSString *name;
/// EEOClassroomMember数组
@property (atomic,strong) NSMutableArray *memberList;

@property (nonatomic, copy) NSData *imageData;

/// 正在上传截图的组成员id，0:表示当前没有准备上传截图的成员
@property (nonatomic, copy) NSNumber *screenShotMemberId;

- (EEOClassroomMember *)memberInfoWithUID:(NSNumber *)uid;
- (EEOClassroomMember *)groupLeaderInfo;
- (EEOClassroomMember *)uploadImageMember;

/// 排序后的memberList，组长排在第一个
- (NSArray *)memberListSorted;
///上台时用到的排序后memberList，组长排在第一个
- (NSArray *)onStageMemberListSorted;
- (NSArray *)groupOnlinedStudentList;
- (NSArray *)groupOnlinedMemberList;

@end

NS_ASSUME_NONNULL_END

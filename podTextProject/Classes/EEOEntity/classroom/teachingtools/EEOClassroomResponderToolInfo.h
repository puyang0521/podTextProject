//
//  EEOClassroomResponderToolInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/11/16.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ResponderToolState) {
    ResponderToolState_InitState = 0,
    ResponderToolState_StartState,
    ResponderToolState_ResponderState,
    ResponderToolState_WaitState,
    ResponderToolState_EndState,
};

@interface ResponderToolStudentResponderInfo : NSObject<NSCopying>

- (instancetype)initWitUID:(NSNumber *)uid;

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSString *displayName;
@property (nonatomic,assign) NSUInteger stageState;
@property (nonatomic,assign) NSUInteger time;

@property (nonatomic,assign) BOOL isOnStage;
@property (nonatomic,assign) BOOL isOnline;

@end

@interface ResponderToolMember : NSObject<NSCopying>

- (instancetype)initWithUID:(NSNumber*)uid
             andDisplayName:(NSString*)displayName
                andIdentity:(NSUInteger)identity;

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSString *displayName;
@property (nonatomic,assign) NSUInteger identity;

- (BOOL)isTeacher;

@end

@interface EEOClassroomResponderToolInfo : NSObject<NSCopying>

@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;
@property (nonatomic,assign) NSInteger zIndex;

@property (nonatomic,copy) NSArray *memberList;//参与者

@property (nonatomic,assign) ResponderToolState state;

//startState
@property (nonatomic,assign) NSInteger randomTopX;
@property (nonatomic,assign) NSInteger randomTopY;
@property (nonatomic,copy) NSNumber *endTime;

//endState(最终抢答成功的学生信息)
@property (nonatomic,strong) ResponderToolStudentResponderInfo *studentResponderInfo;

//所有学生的抢答信息(key:uid,value:timeCost)
@property (nonatomic,strong) NSMutableDictionary *studentTimeCostDic;

- (BOOL)isResponderRoleWithUID:(NSNumber *)uid;

- (BOOL)haveResponderMember;

- (BOOL)isWaitStateWithUID:(NSNumber *)uid;

- (ResponderToolStudentResponderInfo *)buidCurrentResponderMember;

- (ResponderToolMember *)memberWithUID:(NSNumber *)uid;

@end

//
//  EEOClassroomSelectorToolInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/10/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SelectorToolState) {
    SelectorToolState_PrepareState,
    SelectorToolState_AnswerState,
    SelectorToolState_ExplainState,
};

typedef NS_ENUM(NSUInteger,SelectorToolStudentAnswerCommitedState) {
    SelectorToolStudentAnswerCommitedState_Init,
    SelectorToolStudentAnswerCommitedState_Answering,
    SelectorToolStudentAnswerCommitedState_Commited,
};
@interface SelectorToolStudentAnswerInfo : NSObject<NSCopying>
NS_ASSUME_NONNULL_BEGIN
- (instancetype)initWitUID:(NSNumber *)uid;

@property (atomic,copy) NSNumber *uid;
@property (atomic,copy) NSArray *selectedItemList;
@property (nonatomic,assign) NSInteger commited;// 0:init, 1: answering, 2: commited
@property (nonatomic,assign) NSUInteger utcRecvQuestionTime;
@property (nonatomic,assign) NSUInteger utcLastCommitTime;
@property (atomic,copy) NSString *name;

- (BOOL)isAnswered;

- (NSUInteger)currentCommitedSecondsNum;

- (NSString *)selectedItemListToString;
NS_ASSUME_NONNULL_END
@end

@interface SelectorToolMember : NSObject<NSCopying>
NS_ASSUME_NONNULL_BEGIN
- (instancetype)initWithUID:(NSNumber*)uid
             andDisplayName:(NSString*)displayName
                andIdentity:(NSUInteger)identity;

@property (atomic,copy) NSNumber *uid;
@property (atomic,copy) NSString *displayName;
@property (nonatomic,assign) NSUInteger identity;

@property (nonatomic,assign) BOOL isOnStage;
@property (nonatomic,assign) BOOL isOnline;

- (BOOL)isTeacher;
NS_ASSUME_NONNULL_END
@end

@interface EEOClassroomSelectorToolInfo : NSObject<NSCopying>
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;
@property (nonatomic,assign) NSInteger zIndex;

@property (atomic,copy) NSArray *correctItems;//正确答案
@property (atomic,copy) NSArray *allItems;//可选项

@property (atomic,strong) NSMutableArray *memberList;//参与者

@property (nonatomic,assign) NSUInteger questionSentTime;
@property (nonatomic,assign) NSUInteger questionCollectTime;

@property (nonatomic,assign) SelectorToolState state;

@property (atomic,strong) NSMutableDictionary *studentAnswerInfoDic;

- (NSUInteger)allItemCount;

- (SelectorToolMember *)memberWithUID:(NSNumber *)uid;

- (nullable SelectorToolStudentAnswerInfo *)studentAnswerInfoWithUID:(NSNumber *)uid;

- (NSInteger)calculationAnswerAccuracy:(SelectorToolStudentAnswerInfo *)answerInfo;

- (BOOL)isAnswerRoleWIthUID:(NSNumber *)uid;

- (NSUInteger)answeredMemberNum;
- (NSUInteger)accuracyRate;

- (NSUInteger)answerMemberTotalNum;

- (void)safetyRemoveStudentAnswerInfoWithUID:(NSNumber *)uid;
- (void)safetySetStudentAnswerInfo:(SelectorToolStudentAnswerInfo *)info;

NS_ASSUME_NONNULL_END
@end

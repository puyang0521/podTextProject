//
//  EEOClassroomTabBlackboardInfo.h
//  EEOEntity
//
//  Created by HeQian on 16/8/8.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,TabBlackboardType) {
    TabBlackboardType_Unknown,
    TabBlackboardType_Draw,
    TabBlackboardType_Text,
    TabBlackboardType_Go,
};

typedef NS_ENUM(NSUInteger,TabBlackboardState) {
    TabBlackboardState_PrepareState,
    TabBlackboardState_AnswerState,
    TabBlackboardState_ExplainState,
};

@interface TabBlackboardMember : NSObject<NSCopying>

- (instancetype)initWithUID:(NSNumber*)uid
             andDisplayName:(NSString*)displayName
                andIdentity:(NSUInteger)identity;

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSString *displayName;
@property (nonatomic,assign) NSUInteger identity;
@property (nonatomic,assign) BOOL isMarked;

@property (nonatomic,assign) BOOL isOnStage;
@property (nonatomic,assign) BOOL isOnline;

- (BOOL)isTeacher;

@end
@interface EEOClassroomTabBlackboardInfo : NSObject<NSCopying>

@property (nonatomic,assign) TabBlackboardType type;

@property (atomic,copy) NSArray *memberList;
@property (nonatomic,copy) NSNumber *currentMemberId;

@property (nonatomic,assign) TabBlackboardState state;

@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;

@property (nonatomic,assign) NSInteger zIndex;

@property (nonatomic,assign) BOOL isInitiativeSide;

/// 原题数据
@property (nonatomic,copy) id questionData;
/// 是否需要加载原题数据，只在初始化小黑板时使用
@property (nonatomic,assign) BOOL isNeedLoadQuestionData;

- (BOOL)isParticipantsRoleWIthUID:(NSNumber *)uid;
- (TabBlackboardMember *)teacher;

- (NSString *)typeStr;

- (void)setXYWHWithRect:(CGRect)rect;

/// 返回不在memberList中的member列表
/// @param allStudent 所有学生(有排序规则的)
- (NSArray *)detectNoBoardStudent:(NSArray *)allStudent;
/// 是否使用新协议(根据是否存在问题数据来判断)
- (BOOL)isNewProtocolUsed;

/// 小黑板下拉列表的数据源，排序逻辑跟花名册一致
- (NSArray *)displayMemberList;

@end

@interface EEOClassroomDrawTabBlackboardInfo : EEOClassroomTabBlackboardInfo



@end

@interface EEOClassroomTextTabBlackboardInfo : EEOClassroomTabBlackboardInfo

@property (atomic,strong) NSMutableDictionary *textPlayerInfoDic;

- (void)safeSetPlayerStatusToDic:(NSNumber *)uid status:(NSString *)status;
- (NSString *)safeGetPlayerStatusFromDic:(NSNumber *)uid;

- (nullable NSString *)fileContentFromQuestionData;
- (nullable NSString *)languageFromQuestionData;

@end

@interface EEOClassroomGoTabBlackboardInfo : EEOClassroomTabBlackboardInfo

@property (atomic,strong) NSMutableDictionary *goPlayerInfoDic;
@property (nonatomic, assign) int pathNumber;
@property (nonatomic, assign) BOOL isTeacherFirst;

- (NSUInteger)pathNumberFromQuestionData;
- (BOOL)isTeacherFirstFromQuestionData;
- (nullable NSArray *)actionListFromQuestionData;

@end

NS_ASSUME_NONNULL_END

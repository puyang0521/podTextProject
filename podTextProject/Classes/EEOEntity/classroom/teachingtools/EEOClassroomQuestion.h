//
//  EEOClassroomQuestion.h
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/7.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,QuestionStatus){
    QuestionStatus_NotSolve,
    QuestionStatus_Solving,
};

@class EEOClassroomMember;
@interface EEOClassroomQuestion : NSObject<NSCopying>

@property (nonatomic,copy) NSString *questionId;
@property (nonatomic,copy) NSNumber *askerId;
@property (nonatomic,strong) EEOClassroomMember *askerMember;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) NSUInteger likedMemberNum;
@property (nonatomic,copy) NSArray *likedMemberIdList;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;
@property (nonatomic,assign) NSInteger zIndex;

@property (nonatomic,assign) BOOL hasRead;
@property (nonatomic,assign) BOOL lastUpdateIsGlobal;

- (instancetype)initWithQuestionId:(NSString*)questionId
                        andAskerId:(NSNumber*)askerId
                        andContent:(NSString*)content;

- (void)cloneQuestionInfo:(EEOClassroomQuestion*)source;

- (BOOL)isEqualToQuestionInfo:(EEOClassroomQuestion *)info;

@end

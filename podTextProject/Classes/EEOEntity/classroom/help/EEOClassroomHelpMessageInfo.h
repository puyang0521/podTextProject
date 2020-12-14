//
//  EEOClassroomHelpMessageInfo.h
//  EEOEntity
//
//  Created by HeQian on 2017/10/26.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HelpQuesiontAnswerStatus) {
    HelpQuesiontAnswerStatus_Unknown = -1,
    HelpQuesiontAnswerStatus_Notnswered,//未解答
    HelpQuesiontAnswerStatus_Answered,//已解答
};

@interface EEOClassroomHelpQuesiontUserInfo : NSObject

@property (nonatomic,copy) NSString *phpId;
@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,assign) NSUInteger roleIdentity;//暂时没用

- (NSString *)displayName;

@end

@interface EEOClassroomHelpMessageInfo : NSObject

@property (nonatomic,copy) NSString *helpId;
@property (nonatomic,assign) NSInteger helpType;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *askName;
@property (nonatomic,copy) NSNumber *askUID;
@property (nonatomic,copy) NSString *askTime;

@property (nonatomic,assign) HelpQuesiontAnswerStatus answerStatus;
@property (nonatomic,copy) NSString *answerContent;
@property (nonatomic,copy) NSNumber *answerUID;
@property (nonatomic,copy) NSString *answerTime;
@property (nonatomic,copy) NSString *answerName;

@property (nonatomic,copy) NSArray<EEOClassroomHelpQuesiontUserInfo *> *questionUserList;

- (instancetype)initWithHelpId:(NSString *)helpId;

@end

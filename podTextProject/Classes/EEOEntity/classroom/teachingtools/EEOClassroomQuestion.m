//
//  EEOClassroomQuestion.m
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/7.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomQuestion.h"

#import "EEOClassroomMember.h"

@implementation EEOClassroomQuestion

- (instancetype)initWithQuestionId:(NSString *)questionId andAskerId:(NSNumber *)askerId andContent:(NSString *)content {
    self = [super init];
    if(self){
        _questionId = questionId;
        _askerId = askerId;
        _content = content;
        _likedMemberNum = 0;
        _likedMemberIdList = [[NSMutableArray alloc] init];
        _status = QuestionStatus_NotSolve;
        _x = _y = _w = _h = 0;
        _zIndex = 0;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomQuestion *question = [[[self class] allocWithZone:zone] init];
    question.questionId = self.questionId;
    question.askerId = self.askerId;
    question.askerMember = self.askerMember;
    question.content = self.content;
    question.likedMemberNum = self.likedMemberNum;
    question.likedMemberIdList = self.likedMemberIdList;
    question.status = self.status;
    question.x = self.x;
    question.y = self.y;
    question.w = self.w;
    question.h = self.h;
    question.zIndex = self.zIndex;
    
    question.hasRead = self.hasRead;
    question.lastUpdateIsGlobal = self.lastUpdateIsGlobal;
    return question;
}

- (void)cloneQuestionInfo:(EEOClassroomQuestion *)source {
    self.questionId = source.questionId;
    self.askerId = source.askerId;
    self.askerMember = source.askerMember;
    self.content = source.content;
    self.likedMemberNum = source.likedMemberNum;
    self.likedMemberIdList = source.likedMemberIdList;
    self.status = source.status;
    self.x = source.x;
    self.y = source.y;
    self.w = source.w;
    self.h = source.h;
    self.zIndex = source.zIndex;
    
    self.hasRead = source.hasRead;
    self.lastUpdateIsGlobal = source.lastUpdateIsGlobal;
}

- (BOOL)isEqualToQuestionInfo:(EEOClassroomQuestion *)info {
    if(![self.questionId isEqualToString:info.questionId]){
        return NO;
    }
    if(![self.askerId isEqualToNumber:info.askerId]){
        return NO;
    }
    if(self.askerMember != info.askerMember){
        return NO;
    }
    if(![self.content isEqualToString:info.content]){
        return NO;
    }
    if(self.likedMemberNum != info.likedMemberNum){
        return NO;
    }
    if(self.likedMemberIdList != info.likedMemberIdList){
        return NO;
    }
    if(self.status != info.status){
        return NO;
    }
    if(self.x != info.x){
        return NO;
    }
    if(self.y != info.y){
        return NO;
    }
    if(self.w != info.w){
        return NO;
    }
    if(self.h != info.h){
        return NO;
    }
    if(self.zIndex != info.zIndex){
        return NO;
    }
    return YES;
}

@end

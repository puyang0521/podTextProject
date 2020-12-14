//
//  EEOClassroomHelpMessageInfo.m
//  EEOEntity
//
//  Created by HeQian on 2017/10/26.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import "EEOClassroomHelpMessageInfo.h"

@implementation EEOClassroomHelpQuesiontUserInfo

- (NSString *)displayName {
    NSString *result = @"";
    if(_nickName.length > 0){
        result = _nickName;
    }else if(_userName.length > 0){
        result = _userName;
    }else if(_account.length > 0){//TODO...
        result = _account;
    }
    return result;
}

@end

@implementation EEOClassroomHelpMessageInfo

- (instancetype)initWithHelpId:(NSString *)helpId {
    self = [super init];
    if(self){
        self.helpId = helpId;
    }
    return self;
}

@end

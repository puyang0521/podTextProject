//
//  EEOMessageInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOMessageInfo.h"

@implementation EEOMessageInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _messageContent = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOMessageInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.messageId = self.messageId;
    copyObj.messageTime = self.messageTime;
    copyObj.messageContent = self.messageContent;
    return copyObj;
}

- (NSString *)messageContent {
    NSString *result = _messageContent;
    result = result == nil ? @"" : result;
    return result;
}

- (NSDictionary *)messageContentDic {
    return nil;//由子类实现
}
- (id)contentDic {
    return nil;//由子类实现
}

@end

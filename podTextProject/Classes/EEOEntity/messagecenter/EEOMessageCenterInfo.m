//
//  EEOMessageCenterInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOMessageCenterInfo.h"

@implementation EEOMessageCenterInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOMessageCenterInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.messageId = self.messageId;
    copyObj.messageTime = self.messageTime;
    copyObj.readStatus = self.readStatus;
    return copyObj;
}

@end

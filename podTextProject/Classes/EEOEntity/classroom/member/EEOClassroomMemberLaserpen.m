//
//  EEOClassroomLaserpen.m
//  EEOEntity
//
//  Created by HeQian on 16/5/23.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomMemberLaserpen.h"

#import "EEOClassroomMember.h"

@implementation EEOClassroomMemberLaserpen

- (instancetype)init {
    self = [super init];
    if (self) {
        _lastPlayTime = 0.0;
    }
    return self;
}

- (NSNumber*)memberUID {
    return _member.uid;
}

@end

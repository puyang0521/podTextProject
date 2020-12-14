//
//  EEOClassroomCloudResourceAudio.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceAudio.h"

@implementation EEOClassroomCloudResourceAudio

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_AudioWidget;
        self.playSpeed = 1.0;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceAudio *result = [super copyWithZone:zone];
    result.title = self.title;
    result.playSpeed = self.playSpeed;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceAudio *target = (EEOClassroomCloudResourceAudio *)info;
    if(![self.title isEqualToString:target.title]){
        return NO;
    }
    if(self.playSpeed != target.playSpeed){
        return NO;
    }
    
    return YES;
}

@end

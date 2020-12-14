//
//  EEOClassroomCloudResourceVideo.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceVideo.h"

@implementation EEOClassroomCloudResourceVideo

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_VideoWidget;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceVideo *result = [super copyWithZone:zone];
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    return YES;
}

@end

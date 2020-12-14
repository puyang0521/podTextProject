//
//  EEOClassroomCloudResourceHomework.m
//  EEOEntity
//
//  Created by wangpengfei on 2019/7/16.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceHomework.h"

@implementation EEOClassroomCloudResourceHomework

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_Homework;
        self.homeworkUrl = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceHomework *result = [super copyWithZone:zone];
    result.homeworkUrl = self.homeworkUrl;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceHomework *target = (EEOClassroomCloudResourceHomework *)info;
    if(![self.homeworkUrl isEqualToString:target.homeworkUrl]){
        return NO;
    }
    
    return YES;
}

@end

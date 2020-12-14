//
//  EEOClassroomCloudResourceImageEditor.m
//  EEOEntity
//
//  Created by wangpengfei on 2019/7/17.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceImageEditor.h"

@implementation EEOClassroomCloudResourceImageEditor


- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_imageEditor;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceImageEditor *cloudResource = [super copyWithZone:zone];
    cloudResource.index = self.index;

    return cloudResource;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    EEOClassroomCloudResourceImageEditor *cloudResource = (EEOClassroomCloudResourceImageEditor *)info;
    
    if (self.index != cloudResource.index) {
        return NO;
    }
    return YES;
}

@end

//
//  EEOClassroomCloudResourceCloudImage.m
//  EEOEntity
//
//  Created by wangpengfei on 2020/3/30.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceCloudImage.h"

@implementation EEOClassroomCloudResourceCloudImage

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_CloudImageEditor;
        self.index = 0;
    }
    return self;
}

@end

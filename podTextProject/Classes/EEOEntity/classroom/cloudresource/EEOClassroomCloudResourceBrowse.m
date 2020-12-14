//
//  EEOClassroomCloudResourceBrowse.m
//  EEOEntity
//
//  Created by 蒋敏 on 2019/3/18.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceBrowse.h"

@implementation EEOClassroomCloudResourceBrowse

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_Browse;
    }
    return self;
}

@end

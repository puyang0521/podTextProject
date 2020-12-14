//
//  EEOClassroomCloudResourceImage.m
//  EEOEntity
//
//  Created by wangpengfei on 2020/4/8.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceImage.h"

@implementation EEOClassroomCloudResourceImage

- (id)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceImage *cloudResource = [super copyWithZone:zone];
    
    cloudResource.jsContent = self.jsContent;
    cloudResource.rotate = self.rotate;
    cloudResource.imageX = self.imageX;
    cloudResource.imageY = self.imageY;
    cloudResource.imageH = self.imageH;
    cloudResource.imageW = self.imageW;
    
    return cloudResource;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    EEOClassroomCloudResourceImage *cloudResource = (EEOClassroomCloudResourceImage *)info;
    if (![cloudResource.jsContent isEqualToString:self.jsContent]) {
        return NO;
    }
    if (self.rotate != cloudResource.rotate || self.imageW != cloudResource.imageW || self.imageH != cloudResource.imageH || self.imageY != cloudResource.imageY || self.imageX != cloudResource.imageX) {
        return NO;
    }
    return YES;
}

@end

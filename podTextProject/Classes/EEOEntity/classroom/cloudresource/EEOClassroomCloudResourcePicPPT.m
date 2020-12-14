//
//  EEOClassroomCloudResourcePicPPT.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourcePicPPT.h"

@implementation EEOClassroomCloudResourcePicPPT

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_PicPptWidget;
        
        _currentPage = 0;
        _pptStyle = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourcePicPPT *result = [super copyWithZone:zone];
    result.currentPage = self.currentPage;
    result.totalPage = self.totalPage;
    result.pptStyle = self.pptStyle;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourcePicPPT *target = (EEOClassroomCloudResourcePicPPT *)info;
    if(self.currentPage != target.currentPage){
        return NO;
    }
    if(self.totalPage != target.totalPage){
        return NO;
    }
    if(![self.pptStyle isEqualToString:target.pptStyle]){
        return NO;
    }
    
    return YES;
}

@end

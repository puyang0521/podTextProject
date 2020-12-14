//
//  EEOClassroomCloudResourceH5PPT.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceH5PPT.h"

@implementation EEOClassroomCloudResourceH5PPT

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_HtmlPptWidget;
        
        _statusMsg = @"";
        _fileUrl = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceH5PPT *result = [super copyWithZone:zone];
    result.totalPage = self.totalPage;
    result.statusMsg = self.statusMsg;
    result.fileUrl = self.fileUrl;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceH5PPT *target = (EEOClassroomCloudResourceH5PPT *)info;
    if(self.totalPage != target.totalPage){
        return NO;
    }
    if(![self.statusMsg isEqualToString:target.statusMsg]){
        return NO;
    }
    if (![self.fileUrl isEqualToString:target.fileUrl]) {
        return NO;
    }
    return YES;
}

@end

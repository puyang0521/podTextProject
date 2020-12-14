//
//  EEOClassroomCloudResourceCode.m
//  EEOEntity
//
//  Created by HeQian on 16/6/20.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceCode.h"

@implementation EEOClassroomCloudResourceCode

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_CodeWidget;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceCode *result = [super copyWithZone:zone];
    result.fileUrl = self.fileUrl;
    result.paletteStatus = self.paletteStatus;
    result.isSyncScroll = self.isSyncScroll;
    result.fileContent = self.fileContent;
    return result;
}

- (BOOL)isNativeTextFile {
    return [self.fileUrl isEqualToString:@""];
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceCode *target = (EEOClassroomCloudResourceCode *)info;
    if(![self.fileUrl isEqualToString:target.fileUrl]){
        return NO;
    }
    if(![self.paletteStatus isEqualToString:target.paletteStatus]){
        return NO;
    }
    if(self.isSyncScroll != target.isSyncScroll){
        return NO;
    }
    if(![self.fileContent isEqualToString:target.fileContent]){
        return NO;
    }
    
    return YES;
}

@end

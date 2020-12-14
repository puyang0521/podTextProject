//
//  EEOClassroomCloudResourceAV.m
//  EEOEntity
//
//  Created by HeQian on 16/6/3.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceAV.h"

@implementation EEOClassroomCloudResourceAV

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceAV *result = [super copyWithZone:zone];
    result.playbackStatus = self.playbackStatus;
    result.playPosition = self.playPosition;
    result.fileUrl = self.fileUrl;
    result.duration = self.duration;
    result.thumbnailUrl = self.thumbnailUrl;
    return result;
}

- (NSString *)fileUrl {
    if (!_fileUrl) {
        _fileUrl = @"";
    }
    return _fileUrl;
}

- (NSString *)thumbnailUrl {
    if (!_thumbnailUrl) {
        _thumbnailUrl = @"";
    }
    return _thumbnailUrl;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceAV *target = (EEOClassroomCloudResourceAV *)info;
    if(self.playbackStatus != target.playbackStatus){
        return NO;
    }
    if(self.playPosition != target.playPosition){
        return NO;
    }
    if(![self.fileUrl isEqualToString:target.fileUrl]){
        return NO;
    }
    if(self.duration != target.duration){
        return NO;
    }
    
    return YES;
}

@end

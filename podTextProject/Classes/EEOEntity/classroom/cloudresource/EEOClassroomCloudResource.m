//
//  EEOClassroomCloudResource.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@implementation EEOClassroomCloudResource

- (instancetype)init {
    if(self = [super init]){
        self.resourceId = @"";
        self.resourceName = @"";
        self.uid = @(0);
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResource *result = [[[self class] allocWithZone:zone] init];
    result.type = self.type;
    result.zIndex = self.zIndex;
    result.x = self.x;
    result.y = self.y;
    result.w = self.w;
    result.h = self.h;
    result.originalW = self.originalW;
    result.originalH = self.originalH;
    result.resourceId = self.resourceId;
    result.resourceName = self.resourceName;
    result.uid = self.uid;
    result.isFullScreen = self.isFullScreen;
    result.isHidden = self.isHidden;
    result.resourceTitle = self.resourceTitle;
    result.updateTime = self.updateTime;
    result.useLoaclly = self.useLoaclly;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(self.type != info.type){
        return NO;
    }
    if(self.zIndex != info.zIndex){
        return NO;
    }
    if(self.x != info.x){
        return NO;
    }
    if(self.y != info.y){
        return NO;
    }
    if(self.w != info.w){
        return NO;
    }
    if(self.h != info.h){
        return NO;
    }
    if(self.originalW != info.originalW){
        return NO;
    }
    if(self.originalH != info.originalH){
        return NO;
    }
    if(![self.resourceId isEqualToString:info.resourceId]){
        return NO;
    }
    if(![self.resourceName isEqualToString:info.resourceName]){
        return NO;
    }
    if(![self.uid isEqualToNumber:info.uid]){
        return NO;
    }
    if(self.isFullScreen != info.isFullScreen){
        return NO;
    }
    if(self.isHidden != info.isHidden){
        return NO;
    }
    if(self.useLoaclly != info.useLoaclly){
        return NO;
    }
    return YES;
}

- (NSString*)displayName {
    NSString *result = _resourceName;
    if(_resourceTitle.length > 0){
        result = _resourceTitle;
    }
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@,resourceId=%@", [self displayName],_resourceId];
}

@end

@implementation EEOClassroomCloudResourceMirror

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_AppleMirror;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceMirror *result = [super copyWithZone:zone];
    result.mirroring = self.mirroring;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceMirror *target = (EEOClassroomCloudResourceMirror *)info;
    if(self.mirroring != target.mirroring){
        return NO;
    }
    
    return YES;
}

@end
#pragma mark - 苹果投屏
@implementation EEOClassroomCloudResourceAppleMirror

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_AppleMirror;
    }
    return self;
}

@end

#pragma mark - 新投屏
@implementation EEOClassroomCloudResourceEEOMirror

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_EEOMirror;
    }
    return self;
}

@end

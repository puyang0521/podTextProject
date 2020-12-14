//
//  EEOClassroomCloudResourceCourseware.m
//  EEOEntity
//
//  Created by HeQian on 2016/10/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceCourseware.h"

@interface EEOClassroomCloudResourceCourseware () {
    
    CGSize _recommendedSize;
    CGSize _minimumSize;
}

@end

@implementation EEOClassroomCloudResourceCourseware

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_CoursewareWidget;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceCourseware *result = [super copyWithZone:zone];
    result.appUrl = self.appUrl;
    result.fileUrl = self.fileUrl;
    result.appStatus = self.appStatus;
    result.fileContent = self.fileContent;
    result.widgetSize = self.widgetSize;
    result.isTeacherFisrtPrepare = self.isTeacherFisrtPrepare;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceCourseware *target = (EEOClassroomCloudResourceCourseware *)info;
    if(![self.fileUrl isEqualToString:target.fileUrl]){
        return NO;
    }
    if(![self.appUrl isEqualToString:target.appUrl]){
        return NO;
    }
    if(![self.appStatus isEqualToString:target.appStatus]){
        return NO;
    }
    if(![self.fileContent isEqualToString:target.fileContent]){
        return NO;
    }
    if(![self.widgetSize isEqualToString:target.widgetSize]) {
        return NO;
    }
    if (self.isTeacherFisrtPrepare != target.isTeacherFisrtPrepare) {
        return NO;
    }
    return YES;
}

- (void)setWidgetSize:(NSString *)widgetSize {
    if (![_widgetSize isEqualToString:widgetSize]) {
        _widgetSize = widgetSize;
        NSArray *sizeStrList = [widgetSize componentsSeparatedByString:@","];
        for (int i=0; i<sizeStrList.count; i++) {
            NSString *sizeStr = sizeStrList[i];
            NSArray *sizeWHStr = [sizeStr componentsSeparatedByString:@"x"];
            if(sizeWHStr.count == 2){
                float w = [sizeWHStr[0] floatValue];
                float h = [sizeWHStr[1] floatValue];
                if(!isnan(w) && !isnan(h)){
                    if(i == 0){//推荐size
                        _recommendedSize = CGSizeMake(w,h);
                    }else if(i == 1){//最小size
                        _minimumSize = CGSizeMake(w,h);
                    }else{
                        //暂时不用
                    }
                }
            }
        }
    }
}

- (CGSize)recommendedSize {
    return _recommendedSize;
}

- (CGSize)minimumSize {
    return _minimumSize;
}

@end

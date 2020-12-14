//
//  EEOClassroomTeacherWidgetTimer.m
//  EEOEntity
//
//  Created by wangpengfei on 2019/8/19.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidgetTimer.h"

NSString * const TEACHERWIDGET_TIMER = @"Timer2";

@implementation EEOClassroomTeacherWidgetTimer

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidgetTimer *copyObj = [super copyWithZone:zone];
    copyObj.currentStatus = self.currentStatus;
    copyObj.startTime = self.startTime;
    copyObj.pauseTime = self.pauseTime;
    copyObj.currentTime = self.currentTime;
    
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(![super isEqualToTeacherWidget:info]){
        return NO;
    }
    
    EEOClassroomTeacherWidgetTimer *target = (EEOClassroomTeacherWidgetTimer *)info;
    if(self.currentStatus != target.currentStatus){
        return NO;
    }
    if (![self.startTime isEqualToNumber:target.startTime]) {
        return NO;
    }
    if (self.pauseTime != target.pauseTime) {
        return NO;
    }
    if (self.currentTime != target.currentTime) {
        return NO;
    }
    
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    [super cloneWitgetInfo:widgetInfo];
    
    self.currentStatus = [(EEOClassroomTeacherWidgetTimer *)widgetInfo currentStatus];
    self.startTime = [(EEOClassroomTeacherWidgetTimer *)widgetInfo startTime];
    self.pauseTime = [(EEOClassroomTeacherWidgetTimer *)widgetInfo pauseTime];
    self.currentTime = [(EEOClassroomTeacherWidgetTimer *)widgetInfo currentTime];
}

- (NSString*)toolName {
    return TEACHERWIDGET_TIMER;
}

@end

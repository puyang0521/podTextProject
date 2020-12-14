//
//  EEOTeacherToolClock.m
//  EEOEntity
//
//  Created by HeQian on 16/5/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidgetClock.h"

NSString * const TEACHERWIDGET_CLOCK = @"Clock";

@implementation EEOClassroomTeacherWidgetClock

static NSUInteger _initialTime;
+ (NSUInteger)initialTime {
    if(_initialTime == 0){
        _initialTime = 300000;
    }
    return _initialTime;
}
+ (void)setInitialTime:(NSUInteger)initialTime {
    _initialTime = initialTime;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidgetClock *copyObj = [super copyWithZone:zone];
    copyObj.targetTime = self.targetTime;
    copyObj.mode = self.mode;
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(![super isEqualToTeacherWidget:info]){
        return NO;
    }
    
    EEOClassroomTeacherWidgetClock *target = (EEOClassroomTeacherWidgetClock *)info;
    if([self.targetTime isEqualToNumber:target.targetTime]){
        return NO;
    }
    if(self.mode != target.mode){
        return NO;
    }
    
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    [super cloneWitgetInfo:widgetInfo];
    
    self.targetTime = [(EEOClassroomTeacherWidgetClock *)widgetInfo targetTime];
    self.mode = [(EEOClassroomTeacherWidgetClock *)widgetInfo mode];
}

- (NSString*)toolName {
    return TEACHERWIDGET_CLOCK;
}

@end

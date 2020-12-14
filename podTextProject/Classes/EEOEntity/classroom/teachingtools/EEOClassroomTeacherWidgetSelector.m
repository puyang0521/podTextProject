//
//  EEOClassroomTeacherWidgetSelector.m
//  EEOEntity
//
//  Created by wangpengfei on 2019/8/24.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidgetSelector.h"

NSString * const TEACHERWIDGET_SELECTOR = @"Lottery3";

@implementation EEOClassroomTeacherWidgetSelector

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidgetSelector *copyObj = [super copyWithZone:zone];
    copyObj.startTime = self.startTime;
    copyObj.selectedUid1 = self.selectedUid1;
    copyObj.selectedUid2 = self.selectedUid2;
    copyObj.selectedUid3 = self.selectedUid3;
    copyObj.selectorMode = self.selectorMode;
    
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(![super isEqualToTeacherWidget:info]){
        return NO;
    }
    
    EEOClassroomTeacherWidgetSelector *target = (EEOClassroomTeacherWidgetSelector *)info;
    if (![self.startTime isEqualToNumber:target.startTime]) {
        return NO;
    }
    if (![self.selectedUid1 isEqualToNumber:target.selectedUid1]) {
        return NO;
    }
    if (![self.selectedUid2 isEqualToNumber:target.selectedUid2]) {
        return NO;
    }
    if (![self.selectedUid3 isEqualToNumber:target.selectedUid3]) {
        return NO;
    }
    if (self.selectorMode != target.selectorMode) {
        return NO;
    }
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    [super cloneWitgetInfo:widgetInfo];
    
    self.startTime = [(EEOClassroomTeacherWidgetSelector *)widgetInfo startTime];
    self.selectedUid1 = [(EEOClassroomTeacherWidgetSelector *)widgetInfo selectedUid1];
    self.selectedUid2 = [(EEOClassroomTeacherWidgetSelector *)widgetInfo selectedUid2];
    self.selectedUid3 = [(EEOClassroomTeacherWidgetSelector *)widgetInfo selectedUid3];
    self.selectorMode = [(EEOClassroomTeacherWidgetSelector *)widgetInfo selectorMode];
}

- (NSString*)toolName {
    return TEACHERWIDGET_SELECTOR;
}

@end

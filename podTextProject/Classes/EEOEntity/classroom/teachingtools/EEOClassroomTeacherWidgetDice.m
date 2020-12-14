//
//  EEOTeacherToolDice.m
//  EEOEntity
//
//  Created by HeQian on 16/5/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidgetDice.h"

NSString * const TEACHERWIDGET_DICE = @"Dice";

@implementation EEOClassroomTeacherWidgetDice

- (instancetype)init{
    if (self = [super init]) {
        self.targetNum = 1;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidgetDice *copyObj = [super copyWithZone:zone];
    copyObj.targetNum = self.targetNum;
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(![super isEqualToTeacherWidget:info]){
        return NO;
    }
    
    EEOClassroomTeacherWidgetDice *target = (EEOClassroomTeacherWidgetDice *)info;
    if(self.targetNum != target.targetNum){
        return NO;
    }
    
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    [super cloneWitgetInfo:widgetInfo];
    
    self.targetNum = [(EEOClassroomTeacherWidgetDice *)widgetInfo targetNum];
}

- (NSString*)toolName {
    return TEACHERWIDGET_DICE;
}

@end

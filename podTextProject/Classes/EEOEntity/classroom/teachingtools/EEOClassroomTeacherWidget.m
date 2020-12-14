//
//  EEOTeacherTool.m
//  EEOEntity
//
//  Created by HeQian on 16/5/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidget.h"

@implementation EEOClassroomTeacherWidget

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidget *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.version = self.version;
    copyObj.x = self.x;
    copyObj.y = self.y;
    copyObj.zIndex = self.zIndex;
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(self.version != info.version){
        return NO;
    }
    if(self.x != info.x){
        return NO;
    }
    if(self.y != info.y){
        return NO;
    }
    if(self.zIndex != info.zIndex){
        return NO;
    }
    
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    self.version = widgetInfo.version;
    self.x = widgetInfo.x;
    self.y = widgetInfo.y;
    self.zIndex = widgetInfo.zIndex;
}

@end

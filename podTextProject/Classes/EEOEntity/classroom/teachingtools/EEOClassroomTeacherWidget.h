//
//  EEOTeacherTool.h
//  EEOEntity
//
//  Created by HeQian on 16/5/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOClassroomTeacherWidget : NSObject<NSCopying>

@property (nonatomic,copy,readonly) NSString *toolName;

@property (nonatomic,assign) NSUInteger version;
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger zIndex;

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info;

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo;

@end

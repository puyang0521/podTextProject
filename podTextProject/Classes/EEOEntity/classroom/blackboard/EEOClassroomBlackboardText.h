//
//  EEOClassroomBlackboardText.h
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardElement.h"

@interface EEOClassroomBlackboardText : EEOClassroomBlackboardElement

@property (nonatomic,copy) NSArray *fontColorRGBA;
@property (nonatomic,assign) double_t fontSize;
@property (nonatomic,copy) NSString *text;

@end

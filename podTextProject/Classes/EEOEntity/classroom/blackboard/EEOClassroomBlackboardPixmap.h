//
//  EEOClassroomBlackboardPixmap.h
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardElement.h"

@interface EEOClassroomBlackboardPixmap : EEOClassroomBlackboardElement

@property (nonatomic,copy) NSData *pixmapData;

@property (nonatomic,assign) double_t xScale;
@property (nonatomic,assign) double_t yScale;
@property (nonatomic,assign) double_t vScale;

@end

//
//  EEOClassroomBlackboardTraceLine.h
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardElement.h"

@interface EEOClassroomBlackboardTraceLine : EEOClassroomBlackboardElement

@property (nonatomic,copy) NSArray *lineColorRGBA;
@property (nonatomic,assign) double_t lineWeight;

@property (nonatomic,strong) NSMutableArray *pointList;
@property (nonatomic,strong) NSMutableArray *movePointList;

@end

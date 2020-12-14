//
//  EEOClassroomBlackboardElement.m
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardElement.h"

@implementation EEOClassroomBlackboardElement

- (instancetype)init {
    self = [super init];
    if(self){
        _movePointX = INT_MIN;
        _movePointY = INT_MIN;
    }
    return self;
}

- (BOOL)isMoved {
    return _movePointX != INT_MIN || _movePointY != INT_MIN;
}

@end

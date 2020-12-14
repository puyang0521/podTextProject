//
//  EEOClassroomBlackboardTraceLine.m
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardTraceLine.h"

@implementation EEOClassroomBlackboardTraceLine

- (NSMutableArray*)pointList {
    if(_pointList == nil){
        _pointList = [[NSMutableArray alloc] init];
    }
    return _pointList;
}
- (NSMutableArray*)movePointList {
    if(_movePointList == nil){
        _movePointList = [[NSMutableArray alloc] init];
    }
    return _movePointList;
}

@end

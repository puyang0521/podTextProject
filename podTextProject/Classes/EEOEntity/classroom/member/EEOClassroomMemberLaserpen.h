//
//  EEOClassroomLaserpen.h
//  EEOEntity
//
//  Created by HeQian on 16/5/23.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EEOClassroomMember;
@interface EEOClassroomMemberLaserpen : NSObject

@property (nonatomic,strong) EEOClassroomMember *member;

//@property (nonatomic,assign) double_t pointX;
//@property (nonatomic,assign) double_t pointY;

@property (nonatomic,assign) NSTimeInterval lastPlayTime;

- (NSNumber*)memberUID;

@end

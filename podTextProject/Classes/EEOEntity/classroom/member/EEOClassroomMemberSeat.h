//
//  EEOClassroomSeat.h
//  EEOEntity
//
//  Created by HeQian on 16/5/16.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EEOClassroomMember;
@interface EEOClassroomMemberSeat : NSObject<NSCopying>

@property (nonatomic,strong) EEOClassroomMember *member;
@property (nonatomic,assign) NSUInteger seatIndex;
@property (nonatomic,assign) BOOL isLeaveSeat;

@property (nonatomic,assign) NSInteger zIndex;
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;

@property (nonatomic,assign) NSInteger pitIndex;
@property (nonatomic,assign) BOOL isAutoArrange;

@property (nonatomic,assign) NSInteger originalX;
@property (nonatomic,assign) NSInteger originalY;
@property (nonatomic,assign) NSInteger originalW;
@property (nonatomic,assign) NSInteger originalH;

- (instancetype)initWithMember:(EEOClassroomMember*)member
                     seatIndex:(NSUInteger)seatIndex
                        zIndex:(NSInteger)zIndex
                             x:(int)x
                             y:(int)y
                             w:(int)w
                             h:(int)h;

- (void)cloneSeatInfo:(EEOClassroomMemberSeat *)seatInfo;

- (NSNumber*)memberUID;
- (BOOL)isTeacher;
- (BOOL)isAssistant;
- (BOOL)isGroupLeader;
- (BOOL)isCompere;//教室主持人:老师和助教
- (NSUInteger)offStageTime;

- (BOOL)isMainSeat;
- (NSString *)memberKey;

@end

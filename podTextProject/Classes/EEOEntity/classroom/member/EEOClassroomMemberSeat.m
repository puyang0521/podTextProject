//
//  EEOClassroomSeat.m
//  EEOEntity
//
//  Created by HeQian on 16/5/16.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomMemberSeat.h"

#import "EEOClassroomMember.h"

@interface EEOClassroomMemberSeat (){
    NSString *_memberKey;
}

@end
@implementation EEOClassroomMemberSeat

- (instancetype)init {
    if (self = [super init]) {
        _pitIndex = 0xFF;//默认未分配
    }
    return self;
}

- (instancetype)initWithMember:(EEOClassroomMember *)member seatIndex:(NSUInteger)seatIndex zIndex:(NSInteger)zIndex x:(int)x y:(int)y w:(int)w h:(int)h {
    if(self = [self init]){
        _member = member;
        _seatIndex = seatIndex;
        
        _zIndex = zIndex;
        _x = x;
        _y = y;
        _w = w;
        _h = h;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomMemberSeat *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.member = self.member;
    copyObj.seatIndex = self.seatIndex;
    copyObj.isLeaveSeat = self.isLeaveSeat;
    copyObj.zIndex = self.zIndex;
    copyObj.x = self.x;
    copyObj.y = self.y;
    copyObj.w = self.w;
    copyObj.h = self.h;
    copyObj.pitIndex = self.pitIndex;
    copyObj.isAutoArrange = self.isAutoArrange;
    copyObj.originalX = self.originalX;
    copyObj.originalY = self.originalY;
    copyObj.originalW = self.originalW;
    copyObj.originalH = self.originalH;
    return copyObj;
}

- (void)cloneSeatInfo:(EEOClassroomMemberSeat *)seatInfo {
    self.member = seatInfo.member;
    self.seatIndex = seatInfo.seatIndex;
    self.isLeaveSeat = seatInfo.isLeaveSeat;
    self.zIndex = seatInfo.zIndex;
    self.x = seatInfo.x;
    self.y = seatInfo.y;
    self.w = seatInfo.w;
    self.h = seatInfo.h;
    self.pitIndex = seatInfo.pitIndex;
    self.isAutoArrange = seatInfo.isAutoArrange;
    self.originalX = seatInfo.originalX;
    self.originalY = seatInfo.originalY;
    self.originalW = seatInfo.originalW;
    self.originalH = seatInfo.originalH;
}

- (NSNumber*)memberUID {
    return _member.uid;
}
- (BOOL)isTeacher {
    return _member.isTeacher;
}
- (BOOL)isAssistant {
    return _member.isAssistant;
}
- (BOOL)isGroupLeader {
    return _member.isGroupLeader;
}
- (BOOL)isCompere {
    return [_member isCompere];
}
- (NSUInteger)offStageTime {
    return _member.offStageTime;
}

- (BOOL)isMainSeat {
    return _seatIndex == 0;
}
- (NSString *)memberKey {
    if(_memberKey == nil){
        _memberKey = [NSString stringWithFormat:@"%@_%zi",_member.uid,_seatIndex];
    }
    return _memberKey;
}

- (void)setIsAutoArrange:(BOOL)isAutoArrange {
    if(_isAutoArrange == isAutoArrange){
        return;
    }
    _isAutoArrange = isAutoArrange;
    if(isAutoArrange){//保存原始frame
        _originalX = self.x;
        _originalY = self.y;
        _originalW = self.w;
        _originalH = self.h;
    }else{//清空原始frame
        _originalX = 0;
        _originalY = 0;
        _originalW = 0;
        _originalH = 0;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name=%@,seatIndex=%zi,isLeaveSeat=%d,zIndex=%zi,x=%zi,y=%zi,w=%zi,h=%zi", [_member displayName],_seatIndex,_isLeaveSeat,_zIndex,_x,_y,_w,_h];
}

@end

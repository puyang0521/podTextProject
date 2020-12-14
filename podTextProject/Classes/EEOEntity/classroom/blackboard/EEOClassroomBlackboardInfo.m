//
//  EEOClassroomBlackboardInfo.m
//  EEOEntity
//
//  Created by HeQian on 16/8/18.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomBlackboardInfo.h"
#import "EEOConstants.h"


@implementation EEOClassroomBBBasicCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.version = MOLE_BLACKBOAR_VERSATION;//TODO...
    }
    return self;
}

@end
#pragma mark - Draw Command
@implementation EEOClassroomBBDrawBasicCommandInfo

@end
@implementation EEOClassroomBBStartDrawCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = StartDraw;
        self.pointPressure = 0;
    }
    return self;
}

@end
@implementation EEOClassroomBBDrawingCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = Drawing;
        self.pointPressure = 0;
    }
    return self;
}

- (NSMutableArray *)pointList {
    if(_pointList == nil){
        _pointList = [NSMutableArray array];
    }
    return _pointList;
}

- (NSMutableArray *)pointPressureList {
    if (_pointPressureList == nil) {
        _pointPressureList = [NSMutableArray new];
    }
    return _pointPressureList;
}

@end
@implementation EEOClassroomBBFinishDrawCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = FinishDraw;
    }
    return self;
}

@end
#pragma mark - Move Command
@implementation EEOClassroomBBMoveCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = Move;
    }
    return self;
}

@end
#pragma mark - NewMove Command
@implementation EEOClassroomBBNewMoveCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = NewMove;
    }
    return self;
}

@end
#pragma mark - Remove Command
@implementation EEOClassroomBBRemoveCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = Remove;
    }
    return self;
}

@end
#pragma mark - ChangePage Command
@implementation EEOClassroomBBChangePageCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = ChangePage;
    }
    return self;
}

@end
#pragma mark - ChangeSize Command
@implementation EEOClassroomBBChangeSizeCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = ChangeSize;
    }
    return self;
}

@end
#pragma mark - ChangeRotation Command
@implementation EEOClassroomBBChangeRotateAngleCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = RotateAngle;
    }
    return self;
}

@end
#pragma mark - LockOrUnlock Command
@implementation EEOClassroomBBLockOrUnlockCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = LockOrUnlock;
    }
    return self;
}

@end
#pragma mark - ChangeZValue Command
@implementation EEOClassroomBBChangeZValueCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = ChangeZValue;
    }
    return self;
}

@end
#pragma mark - Undo(撤销) Command
@implementation EEOClassroomBBUndoCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = Undo;
    }
    return self;
}

@end
#pragma mark - Redo(恢复) Command
@implementation EEOClassroomBBRedoCommandInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commandId = Redo;
    }
    return self;
}

@end

@implementation EEOClassroomBlackboardInfo

- (instancetype)init {
    self = [super init];
    if(self){
        _isComeBack = YES;
        
        _isCanScrollWhileBroswer = YES;
        
        _classroomScale = 1.0;
        
        self.inputTextScale = -1;
    }
    return self;
}

@end

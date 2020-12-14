//
//  EEOClassroomBlackboardInfo.h
//  EEOEntity
//
//  Created by HeQian on 16/8/18.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIColor.h>
#import "EEOClassroomMember.h"

typedef NS_ENUM(NSUInteger,BlackboardCommand){
    StartDraw = 0,
    Drawing,
    FinishDraw,
    Move,
    Remove,
    ChangePage,
    ChangeSize,
    LockOrUnlock,
    ChangeZValue,
    AbsoluteMove,
    Undo = 10,
    Redo = 11,
    NewMove = 12,
    RotateAngle,
};

typedef NS_ENUM(NSUInteger, BBElementLockType) {
    BBElementLockTypeNone,
    BBElementLockTypeFrame,
    BBElementLockTypeSize,
};

@class EEOClassroomMember;
@interface EEOClassroomBBBasicCommandInfo : NSObject

@property (nonatomic,assign) NSUInteger commandId;
@property (nonatomic,assign) NSUInteger version;

/**
 仅用作界面显示,不会被传输
 */
@property (nonatomic,strong) EEOClassroomMember *operatorInfo;

/**
 仅在批量处理数据时使用,界面上无需使用
 */
@property (nonatomic,assign) NSUInteger cmdIndex;

@end
#pragma mark - Draw Command
@interface EEOClassroomBBDrawBasicCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,assign) NSUInteger elementType;
@property (nonatomic,copy) NSData *elementId;

/**
 该点在黑板画布上的水平与垂直占比值(0-1之间)
 */
@property (nonatomic,assign) CGPoint point;

/// 采样点的压力值
@property (nonatomic,assign) CGFloat pointPressure;

@end
@interface EEOClassroomBBStartDrawCommandInfo : EEOClassroomBBDrawBasicCommandInfo

@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,assign) NSInteger zValue;
//@property (nonatomic,assign) BOOL isLocked;
@property (nonatomic,assign) BOOL isTipVisible;

@property (nonatomic, assign) double rorateAngle;
@property (nonatomic, assign) double scaleFactor;

@property (nonatomic, assign) BBElementLockType lockType;

//TraceLine、BBElementTypeCircular和Text共有
@property (nonatomic,copy) UIColor *drawColor;
@property (nonatomic,assign) NSInteger sizeIndex;

//TraceLine特有

//BBElementTypeCircular特有

//Text特有


//Image特有
@property (nonatomic,assign) double_t xScale;
@property (nonatomic,assign) double_t yScale;
@property (nonatomic,assign) double_t vScale;//不用了...
@property (nonatomic,assign) CGSize imageSize;
@property (nonatomic,copy) NSData *imageData;

@end
@interface EEOClassroomBBDrawingCommandInfo : EEOClassroomBBDrawBasicCommandInfo

//TraceLine特有
@property (nonatomic,strong) NSMutableArray *pointList;
@property (nonatomic,strong) NSMutableArray *pointPressureList;

//BBElementTypeCircular特有

//Text特有
@property (nonatomic,copy) NSString *text;

//Image特有


@end
@interface EEOClassroomBBFinishDrawCommandInfo : EEOClassroomBBDrawBasicCommandInfo

@end
#pragma mark - Move Command
@interface EEOClassroomBBMoveCommandInfo : EEOClassroomBBBasicCommandInfo

/**
 表示移动了多少
 */
@property (nonatomic,assign) CGPoint point;
/**
 当前所有被移动对象的外接矩形
 */
@property (nonatomic,assign) CGRect boundingRect;

@property (nonatomic,copy) NSArray *elementIdList;

@end

#pragma mark - NewMove Command
@interface EEOClassroomBBNewMoveCommandInfo : EEOClassroomBBBasicCommandInfo

/**
 item:[0:elementId,1:point(NSString)]
 */
@property (nonatomic,copy) NSArray<NSArray *> *elementInfoList;

@end

#pragma mark - Remove Command
@interface EEOClassroomBBRemoveCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,copy) NSArray *elementIdList;

@property (nonatomic,assign) BOOL atomicAction; //是否是批量删除

@end

#pragma mark - ChangePage Command
@interface EEOClassroomBBChangePageCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,assign) CGFloat pageIndex;

@end

#pragma mark - ChangeSize Command
@interface EEOClassroomBBChangeSizeCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,assign) NSUInteger elementType;
@property (nonatomic,copy) NSData *elementId;
@property (nonatomic,assign) CGPoint point;
@property (nonatomic,assign) CGFloat vScale;//不再使用
@property (nonatomic,assign) CGSize imageSize;

@end

#pragma mark - LockOrUnlock Command
@interface EEOClassroomBBLockOrUnlockCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,assign) NSUInteger elementType;
@property (nonatomic,copy) NSData *elementId;
@property (nonatomic, assign) BBElementLockType lockType;

@end

#pragma mark - ChangeRotation Command
@interface EEOClassroomBBChangeRotateAngleCommandInfo : EEOClassroomBBBasicCommandInfo

@property (nonatomic,assign) NSUInteger elementType;
@property (nonatomic,copy) NSData *elementId;
@property (nonatomic,assign) double rotateAngle;

@end

#pragma mark - ChangeZValue Command
@interface EEOClassroomBBChangeZValueCommandInfo : EEOClassroomBBBasicCommandInfo

/**
 二维数组:@[elementId,zValue],@[elementId,zValue], + ...
 */
@property (nonatomic,copy) NSArray *elementInfoList;

@end

#pragma mark - Undo(撤销) Command
@interface EEOClassroomBBUndoCommandInfo : EEOClassroomBBBasicCommandInfo

@end

#pragma mark - Redo(恢复) Command
@interface EEOClassroomBBRedoCommandInfo : EEOClassroomBBBasicCommandInfo

@end

typedef NS_ENUM(NSUInteger, BBOperationMode) {
    BBOperationMode_Pen = 0,
    BBOperationMode_Text,
    BBOperationMode_Choose,
    BBOperationMode_Browse,
    BBOperationMode_LaserPen
};

@interface EEOClassroomBlackboardInfo : NSObject

@property (nonatomic,copy) NSString *bbId;
@property (nonatomic,assign) NSUInteger pageNum;

@property (nonatomic,assign) CGRect logicalFrame;

@property (nonatomic,assign) BOOL isComeBack;
@property (nonatomic,assign) BOOL isCanScrollWhileBroswer;
@property (nonatomic,assign) BOOL isOnlyApplePencil;
@property (nonatomic,assign) BOOL isCanOpenImage;

@property (nonatomic,assign) BBOperationMode bbOperationMode;
@property (nonatomic,assign) double_t bbPenSize;
@property (nonatomic,copy) id bbPenColor;
@property (nonatomic, assign) double_t bbTextSize;
@property (nonatomic, copy) id bbTextColor;
@property (nonatomic, assign) NSInteger bbPenType;
@property (nonatomic, assign) CGFloat classroomScale;

@property (nonatomic, assign) CGFloat inputTextScale;   //影响插入的文本的字体大小

/**
 当前页数
 */
@property (nonatomic,assign) CGFloat currentPageIndex;

/**
 当前可见元素个数
 */
@property (nonatomic,assign) NSUInteger currentVisibleElementCount;

@end

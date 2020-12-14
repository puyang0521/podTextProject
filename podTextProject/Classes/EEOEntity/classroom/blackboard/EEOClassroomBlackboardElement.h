//
//  EEOClassroomBlackboardElement.h
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BBElementType){
    BBElementTypeTraceline = 0,   //跟踪线
    BBElementTypeRectangle = 1,   //矩形
    BBElementTypeCircular = 2,    //圆形
    BBElementTypeText = 3,        //文字
    BBElementTypePixmap = 4,      //图片
//    BBElementTypeTriangle = 5,    //三角形,已废弃
    BBElementTypeEllipse = 6,     //椭圆
    BBElementTypeSimpleLine = 7,  //两点组成的直线段
    BBElementTypePressureLine = 10, //触控笔
    
    BBElementTypeEraser = 200,      //橡皮
    
    BBElementTypeNone = 255
};

@interface EEOClassroomBlackboardElement : NSObject

//@property (nonatomic,copy) NSString *elementId;
@property (nonatomic,copy) NSData *elementId;
@property (nonatomic,assign) BBElementType type;

@property (nonatomic,copy) NSNumber *uid;

@property (nonatomic,assign) BOOL isSelect;

//元素的起始位置
@property (nonatomic,assign) double_t pointX;
@property (nonatomic,assign) double_t pointY;

@property (nonatomic,assign) NSUInteger zIndex;

@property (nonatomic,assign) double_t movePointX;
@property (nonatomic,assign) double_t movePointY;

- (BOOL)isMoved;

@end

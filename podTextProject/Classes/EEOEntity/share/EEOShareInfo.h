//
//  EEOShareInfo.h
//  EEOEntity
//
//  Created by eeo开发-东哥 on 2019/7/1.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EEOEnums.h"

typedef NS_ENUM(NSUInteger, SharedTargetType) {
    SharedTargetType_Unknown,
    SharedTargetType_NativeConversion,//本地会话
    SharedTargetType_WX,//微信
    SharedTargetType_Message,//短信
};

typedef NS_ENUM(NSUInteger, SharedContentType) {
    SharedContentType_Unknown,
    SharedContentTypeURL,//分享URL
    SharedContentTypeImage,//分享图片
    SharedContentTypeText,//分享文本
    SharedContentTypeHomeworkTemplate,//分享作业模版
};

typedef void(^shareInfoBlock)(id result);

@interface EEOShareInfo : NSObject

@property (nonatomic, assign) SharedTargetType targetType;

@property (nonatomic, assign) SharedContentType contentType;

@property (nonatomic, strong) UIViewController *shareFromController;

@property (nonatomic, strong) UIView *shareFromView;

@property (nonatomic, assign) NSInteger scene;

@property (nonatomic, assign) ShareTagType shareTagType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSData *imageData;

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, strong) NSNumber * fileId;

/*
 分享到...
 */
@property (nonatomic, copy) NSArray *shareToUsers;
/*
 分享回调
 */
@property (nonatomic, copy) shareInfoBlock shareBlock;

@end

//
//  EEOClassroomCloudResource.h
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,CloudResourceType) {
    CloudResourceType_PicPptWidget,//不再使用
    CloudResourceType_HtmlPptWidget,//h5 ppt
    CloudResourceType_VideoWidget,//视频课件
    CloudResourceType_AudioWidget,//音频课件
    CloudResourceType_PdfWidget,//pdf课件
    CloudResourceType_CodeWidget,//文本编辑器
    CloudResourceType_CoursewareWidget,//webapp
    CloudResourceType_NewHtmlPptWidget,//暂时没用
    CloudResourceType_WebPageWidget = 8,//edu
    CloudResourceType_Browse = 10,//浏览器(多向屏幕共享)
    CloudResourceType_VNC = 11,//VNC(多向屏幕共享)
    CloudResourceType_Homework,//作业讲解(多向屏幕共享)
    CloudResourceType_imageEditor = 14,//作业图片编辑器
    CloudResourceType_AppleMirror,//苹果投屏
    CloudResourceType_CloudImageEditor,//云盘图片编辑器
    CloudResourceType_htmlExcelWidget = 17,//H5 Excel课件
    CloudResourceType_EEOMirror = 18,//新投屏
    CloudResourceType_Exam = 19,//发布测验
    CloudResourceType_CloudExam = 20,//云盘打开的试题资源
    CloudResourceType_ExplainExam = 21,//讲解测验
};

@interface EEOClassroomCloudResource : NSObject<NSCopying>

@property (nonatomic,assign) CloudResourceType type;
@property (nonatomic,assign) NSInteger zIndex;
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;
@property (nonatomic,assign) NSInteger originalW;
@property (nonatomic,assign) NSInteger originalH;
@property (nonatomic,copy) NSString *resourceId;
@property (nonatomic,copy) NSString *resourceName;
@property (nonatomic,copy) NSNumber *uid;

@property (nonatomic,assign) BOOL isFullScreen;
@property (nonatomic,assign) BOOL isHidden;
@property (nonatomic,assign) BOOL isInitiativeSide;

/// 部分课件需要为该属性赋值,比如:作业、浏览器、投屏
@property (nonatomic,copy) NSString *resourceTitle;

@property (nonatomic,assign) NSTimeInterval updateTime;
///是否仅本地使用 default:NO
@property (nonatomic,assign) BOOL useLoaclly;

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info;

- (NSString*)displayName;

@end

@interface EEOClassroomCloudResourceMirror : EEOClassroomCloudResource

@property (nonatomic,assign) BOOL mirroring;//投屏中...

@end
#pragma mark - 苹果投屏
@interface EEOClassroomCloudResourceAppleMirror : EEOClassroomCloudResourceMirror

@end

#pragma mark - 新投屏
@interface EEOClassroomCloudResourceEEOMirror : EEOClassroomCloudResourceMirror

@end

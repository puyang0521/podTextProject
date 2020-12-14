//
//  EEOClassroomInfo.h
//  EEOEntity
//
//  Created by 蒋敏 on 17/1/22.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ClassroomClientType) {
    ClassroomClientType_Remote = 0,
    ClassroomClientType_Preparation = 1,//备课教室
    ClassroomClientType_Blackboard = 2,//板书编辑器
};

/// 教室功能独占权
typedef NS_ENUM(NSUInteger, ClassroomSeveraltyFlag) {
    ClassroomSeveraltyFlag_ScreenSharing = 0,//屏幕共享(所有方式的屏幕共享)
};

/// 教室自定义消息类型
typedef NS_ENUM(NSUInteger, ClassroomCustomMessageType) {
    ClassroomCustomMessageType_ChatMessageRevoke = 100,//聊天消息撤回
    ClassroomCustomMessageType_ChatMessageDelete = 101,//聊天消息删除
};

/// 教室自定义消息类型
typedef NS_ENUM(NSUInteger, ClassroomFlags) {
    ClassroomFlags_Unknown = 0x0,
    ClassroomFlags_HiddenSeatArea = 0x1,//隐藏座席区
};

/// 教室自定义消息类型
typedef NS_ENUM(NSUInteger, ClassroomEnterState) {
    ClassroomEnterState_WillEnter = 0,//将要进入，成功后会打开设备检测页面
    ClassroomEnterState_StartEnter,//开始进入，成功后打开教室界面
    ClassroomEnterState_EnterComplete,//表示进入完成
};

@class EEOLessonInfo;
@class EEOClassroomMember;
@class EEOClassroomBlackboardInfo;
@class EEOClassroomThemeInfo;
@class EEOClassMemberInfo;
@interface EEOClassroomInfo : NSObject<NSCopying>

@property (class) EEOClassroomInfo *currentClassroomInfo;

@property (atomic,strong) EEOLessonInfo *lessonInfo;

@property (nonatomic,copy) NSNumber *classroomID;
@property (nonatomic,copy) NSNumber *courseID;
@property (nonatomic,copy) NSNumber *schoolID;
@property (atomic,strong) NSMutableArray *memberList;

@property (nonatomic,assign) BOOL isMuteAll;
@property (nonatomic,assign) BOOL isEstoppelAll;
@property (nonatomic,assign) BOOL isAuthorizationAll; //服务器还未下发

@property (readonly) BOOL isTempClassroom;

//教室内音视频设备选项
@property (nonatomic,assign) BOOL isCamAuthorization;
@property (nonatomic,assign) BOOL isEnableCamera;
@property (nonatomic,assign) NSInteger cameraPosition;
@property (nonatomic,assign) BOOL isEnableMirror;
@property (nonatomic,assign) BOOL isMicAuthorization;
@property (nonatomic,assign) BOOL isEnableMicrophone;
@property (nonatomic,assign) BOOL isEnableSpeakers;
@property (nonatomic,assign) BOOL isEnableSound;
@property (nonatomic,assign,readonly) BOOL isHeadsetPluggedIn;

@property (nonatomic,assign) BOOL isEnableCamera2;
@property (nonatomic,assign) NSInteger camera2Position;
@property (nonatomic,assign) BOOL isEnableMicrophone2;

//学生举手统计
@property (nonatomic,assign) NSUInteger onlineStudentCount;
@property (nonatomic,assign) NSUInteger handsupCount;

//黑板相关操作选项
@property (nonatomic,assign) NSUInteger bbOperationMode;
@property (nonatomic,assign) double_t bbPenSize;
@property (nonatomic,copy) id bbPenColor;
@property (nonatomic, assign) NSInteger bbPenType;
@property (nonatomic,assign) double_t bbFontSize;
@property (nonatomic,copy) id bbFontColor;

//大黑板
@property (atomic,strong) EEOClassroomBlackboardInfo *bbInfo;

/// 教室皮肤信息
@property (atomic,strong) EEOClassroomThemeInfo *themeInfo;

/**
 是否启用AVPlayer的AudioProcessor
 */
@property (nonatomic,assign,getter=isEnableAudioProcessor) BOOL enableAudioProcessor;
/**
 是否启用高级PDF播放器
 */
@property (nonatomic,assign,getter=isEnablePdfKitPlayer) BOOL enablePdfKitPlayer;
/**
 是不是启用了回音消除组件
 */
@property (nonatomic,assign,getter=isEnableVoiceProcessing) BOOL enableVoiceProcessing;
/**
是否启用麦克风自动增益
*/
@property (nonatomic,assign,getter=isEnableVoiceAgc) BOOL enableVoiceAgc;

//录课相关
@property (nonatomic,copy) NSString *recordDirPath;

@property (nonatomic,assign) ClassroomClientType clientType;

@property (nonatomic,copy) NSString *alias;//进教室时设置的别名(给游客用户使用)

/**
 教室的别名，取教室名称时会优先取教室别名，如果没设置，则从lessonInfo取
*/
@property (nonatomic,copy) NSString *classroomAlias;

/// 班级(群)id，只有临时教室的classID与courseID不一致
@property (nonatomic,copy) NSNumber *classID;

@property (nonatomic,copy) NSString *mediaSrvHost;
@property (nonatomic,copy) NSString *mediaClientIp;

/// 教室所有分组的标志(注意:需要调用saveGroupFlags和removeGroupFlags方法来管理)
@property (nonatomic,strong) NSMutableDictionary *flagsMap;

/// 教室进入状态，主要用来区分是预备进入还是正式进入教室
@property (nonatomic,assign) ClassroomEnterState enterState;

- (instancetype)initWithClassroomID:(NSNumber*)classroomID courseID:(NSNumber*)courseID schoolID:(NSNumber*)schoolID;

- (void)cloneClassroomInfo:(EEOClassroomInfo *)info;

- (NSString *)title;
- (NSUInteger)startTime;
- (NSUInteger)endTime;
- (NSUInteger)aheadTime;

- (EEOClassroomMember *)teacherInfo;
- (NSString *)teacherName;

- (EEOClassroomMember *)assistantInfo;

- (NSNumber *)equipments;

- (BOOL)isFormalClass;
- (BOOL)isNeedEvaluation;

- (BOOL)finalIsEnableCam;
- (BOOL)finalIsEnableMic;

/**
 有实时推流能力

 @return YES/NO
 */
- (BOOL)haveLivePush;

- (EEOClassroomMember *)memberWithUID:(NSNumber *)uid;

- (void)fillMemberClassMemberInfoWithList:(NSArray *)classMemberList;

- (BOOL)isAvailable;

- (BOOL)isNativeClassroom;
- (BOOL)isPreparationClassroom;
- (BOOL)isBlackboardClassroom;

- (void)saveGroupFlags:(NSUInteger)groupID flags:(NSNumber *)flags;
- (NSNumber *)getGroupFlags:(NSUInteger)groupID;
- (void)removeGroupFlags:(NSUInteger)groupID;
/// 是否隐藏座位席区域
- (BOOL)isHiddenSeatAreaWithGroupID:(NSUInteger)groupID;
///是否是好友之间的临时教室
- (BOOL)isContactTempClassroom;
///小工具是否显示作业入口
- (BOOL)canShowHomeworkInToolbox;
///当前教室工具箱不支持的工具
- (NSArray *)unsupportedToolsInToolbox;
/// 用于判断教室里的学生是否能上台
- (BOOL)canStudentOnStage;

@end

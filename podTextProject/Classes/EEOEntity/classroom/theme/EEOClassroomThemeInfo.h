//
//  EEOClassroomTheme.h
//  EEOEntity
//
//  Created by 蒋敏 on 2017/12/28.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TeacherToolBoxWidget) {
    TeacherToolBoxWidget_SaveEdbFile,
    TeacherToolBoxWidget_ScreenShare,
    TeacherToolBoxWidget_Clock,
    TeacherToolBoxWidget_Dice,
    TeacherToolBoxWidget_SmallBlackboard,
    TeacherToolBoxWidget_Responder,
    TeacherToolBoxWidget_AnswerDevice,
    TeacherToolBoxWidget_TextCollaboration,
    TeacherToolBoxWidget_Browser,
    TeacherToolBoxWidget_AwardLeaderboard,
    TeacherToolBoxWidget_Homework,
    TeacherToolBoxWidget_GoSmallBoard,
    TeacherToolBoxWidget_Selector,
    TeacherToolBoxWidget_Timer,
    TeacherToolBoxWidget_Group,
    TeacherToolBoxWidget_Examination,
};

typedef NS_ENUM(NSInteger, ClassroomCloudDefaultList) {
    ClassroomCloudDefaultList_Authod,
    ClassroomCloudDefaultList_MyCloud,
    ClassroomCloudDefaultList_Library,
};

typedef NS_ENUM(NSInteger, ClassroomHeadActionType) {
    //学生事件
    ClassroomHeadActionTypeMute = 0,
    ClassroomHeadActionTypeUnmute,
    ClassroomHeadActionTypeDownStage,
    ClassroomHeadActionTypeSendReward,
    ClassroomHeadActionTypeAuthorize,
    ClassroomHeadActionTypeUnauthorize,
    //教师事件
    ClassroomHeadActionTypeResetAll,
    ClassroomHeadActionTypeMuteAll,
    ClassroomHeadActionTypeUnmuteAll,
    ClassroomHeadActionTypeDownStageAll,
    ClassroomHeadActionTypeSendRewardAll,
    ClassroomHeadActionTypeReplaceAll,
    ClassroomHeadActionTypeAuthorizeAll,
    ClassroomHeadActionTypeUnauthorizeAll,
    ClassroomHeadActionTypeFreeRegionAll,
};

@interface EEOClassroomSkinInfo : NSObject

@property (nonatomic,assign) float alpha;
@property (nonatomic,copy) NSString *colorStr;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *imageBase64Str;
@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSData *imageData;

- (instancetype)initWithinfoDic:(NSDictionary *)infoDic;

- (void)cloneSkinInfo:(EEOClassroomSkinInfo *)info;

- (BOOL)existImage;
- (BOOL)existBGColor;

@end
@interface EEOClassRoomHeadToolbarInfo : NSObject

@property (nonatomic, strong, readonly) NSArray<NSNumber *> *teacherActions;
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *studentActions;

- (instancetype)initWithInfoDic:(NSDictionary *)infoDic;


@end
@interface EEOClassroomThemeInfo : NSObject

@property (nonatomic,assign) NSUInteger edtVersion;
@property (nonatomic,copy) NSString *edtFileName;
@property (nonatomic,copy) NSData *edtImageData;

@property (nonatomic,strong) EEOClassroomSkinInfo *titleSkinInfo;
@property (nonatomic,strong) EEOClassroomSkinInfo *seatAreaSkinInfo;
@property (nonatomic,strong) EEOClassroomSkinInfo *bgSkinInfo;
@property (nonatomic,strong) EEOClassroomSkinInfo *outBGSkinInfo;
@property (nonatomic,strong) EEOClassRoomHeadToolbarInfo *headImageToolbarInfo;

@property (nonatomic,copy) NSDictionary *commentWindowInfo;
@property (nonatomic,copy) NSDictionary *chatWindowInfo;
@property (nonatomic,copy) NSDictionary *boardToolbarInfo;
@property (nonatomic, copy) NSDictionary *clouddiskInfo;
@property (nonatomic, copy) NSDictionary *recordInfo;
@property (nonatomic, copy) NSDictionary *blackboardInfo;
@property (nonatomic, copy) NSDictionary *handsupInfo;
@property (nonatomic, copy) NSDictionary *classroomWindow;

@property (nonatomic, assign) BOOL authoredCloudIsEmpty;

/// 学生拖到板书区自动授权
@property (nonatomic, assign) BOOL isDropBlackboardAuthority;
/// 拖动回台上给学生取消授权
@property (nonatomic, assign) BOOL isDropBackStageCancelAuthority;
///打开小黑板限制人数
@property (nonatomic, copy) id tabBBMemberLimitInfo;

///  机构后台设置特定奖杯
@property (nonatomic, copy) NSDictionary *awardAnimationInfo;
///  求助
@property (nonatomic, copy) NSDictionary *skinHelpInfo;

/// 关闭回音消除
@property (nonatomic, assign) BOOL isCloseEchoCancellation;

- (BOOL)existEdt;

- (NSData *)bgImageData;
- (NSString *)bgColorStr;

- (BOOL)isCommentVisible;

- (BOOL)canSendChatImage;
- (NSUInteger)minSendChatMessageTimeInterval;

- (BOOL)isRosterVisibleByStudent;
/**
 老师端是否显示工具箱
 */
- (BOOL)isToolboxVisibleByTeacher;

/**
 老师端是否显示聊天按钮
 */
- (BOOL)isChatButtonVisibleByTeacher;

/**
 学生端是否显示聊天按钮
 */
- (BOOL)isChatButtonVisibleByStudent;

/**
 工具箱显示的内容
 unsupportTools: 工具箱中不显示的工具
 */
- (NSArray *)teacherToolboxListWithUnsupportTools:(NSArray *)unsupportTools;
/**
 教室云盘默认显示
 */
- (ClassroomCloudDefaultList)classroomDefaultList;
/**
 问题列表是否可见
 */
- (BOOL)isQuestionListVisible;
/**
 录课倒计时时间
 */
- (NSUInteger)recordTimeInterval;
/**
 学生是否可以滚动大黑板
 */
- (BOOL)canScrollBigBlackboardByStudent;
/**
 学生是否可以关闭课件
 */
- (BOOL)canCloseCoursewareByStudent;
/**
是否显示举手按钮
 */
- (BOOL)isHandsupVisible;
/**
 是否课节延时
 */
- (BOOL)isLessonOverTime;
/**
 是否同步摄像头镜像
 */
- (BOOL)isSyncCameraMirroring;
/**
 是否打开屏幕共享
 */
- (BOOL)canOpenScreenShare;
/**
 机构后台设置花名册是否显示移除学生一栏
*/
- (BOOL)isShowMoveStudentOut;
/**
小黑板人数限制
 */
- (NSUInteger)tabBBMemberLimit;
/**
 学生求助
 */
- (BOOL)isStudentHelpVisible;
/**
 学生教室显示跑马灯
 */
- (BOOL)isMarqueeVisible;
/// 是否针对学生开启专注模式
- (BOOL)isStudentFrontLock;

@end

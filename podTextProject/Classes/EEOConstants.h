//
//  EEOConstants.h
//  EEOCommon
//
//  Created by HeQian on 2017/9/6.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#ifndef EEOConstants_h
#define EEOConstants_h

#import <Foundation/Foundation.h>

extern NSString * const kEEODomain;

extern NSString * const kClassInAppBundleID;

extern NSString * const kClassInAppId;

extern NSString * const kAppURLScheme;

extern NSString * const kKeychainServiceName;
extern NSString * const kKeychainGUIDDefaultAccount;

extern NSString * const kWelcomePageChangedVersion;

/************************** 语言 ************************************************/
extern NSString * const kClassInAppLanguage_En;
extern NSString * const kClassInAppLanguage_Hans;
extern NSString * const kClassInAppLanguage_HantTW;
extern NSString * const kClassInAppLanguage_Spa;
extern NSString * const kClassInAppLanguage_JaPan;
extern NSString * const kClassInAppLanguage_Korea;
extern NSString * const kClassInAppLanguage_Vietnamese;
extern NSString * const kClassInAppLanguage_Arabic;
extern NSString * const kClassInAppLanguage_Indonesia;
extern NSString * const kClassInAppLanguage_Hungary;
/***************************   MTA   ***********************************************/
extern NSString * const kReportErrorNotifName;
extern NSString * const kReportLogNotifName;
extern NSString * const kReportMTAPageViewBeginNotifName;
extern NSString * const kReportMTAPageViewEndNotifName;
extern NSString * const kReportMTACustomEventNotifName;

extern NSString * const kMTAEvent_ClassInPage;

extern NSString * const kMTAEvent_FreeMeeting;
extern NSString * const kMTAEvent_AddFriends;
extern NSString * const kMTAEvent_CreateClass;
extern NSString * const kMTAEvent_Scan;
extern NSString * const kMTAEvent_SearchPublicClass;
extern NSString * const kMTAEvent_CreatePublicClass;

extern NSString * const kMTAEvent_MessageCenter;

extern NSString * const kMTAEvent_AddressbookPage;

extern NSString * const kMTAEvent_LearnPage;
extern NSString * const kMTAEvent_CreateLesson;
extern NSString * const kMTAEvent_ShareLearningReport;
extern NSString * const kMTAEvent_CloudUploading;
extern NSString * const kMTAEvent_CloudFilePreView;
extern NSString * const kMTAEvent_SharePublicClass;
extern NSString * const kMTAEvent_CourseDetails;
extern NSString * const kMTAEvent_OpenLearningReport;
extern NSString * const kMTAEvent_OpenVedioReplay;
extern NSString * const kMTAEvent_GrowingMenu;

extern NSString * const kMTAEvent_MinePage;
extern NSString * const kMTAEvent_InstitutionEntry;
extern NSString * const kMTAEvent_ClearCache;
extern NSString * const kMTAEvent_MessageNotif;
extern NSString * const kMTAEvent_Language;
extern NSString * const kMTAEvent_AdvancedSetting;
extern NSString * const kMTAEvent_Logout;

extern NSString * const kMTAEvent_CloudDiskPage;

extern NSString * const kMTAEvent_ChatPage;
extern NSString * const kMTAEvent_PersonChat;
extern NSString * const kMTAEvent_ClassChat;
extern NSString * const kMTAEvent_ClassroomChat;

extern NSString * const kMTAEvent_HomeworkPage;
extern NSString * const kMTAEvent_HomeworkAssignment;
extern NSString * const kMTAEvent_HomeworkEditImage;
extern NSString * const kMTAEvent_HomeworkUploadFile;

extern NSString * const kMTAEvent_ClassroomPage;
extern NSString * const kMTAEvent_ClassroomClosePage;
extern NSString * const kMTAEvent_ClassroomRecord;
extern NSString * const kMTAEvent_ClassroomGroup;

extern NSString * const kMTAEvent_EvokeFromWeb;
extern NSString * const kMTAEvent_EvokeFromNotif;

extern NSString * const kMTAEvent_AppFileShared;
extern NSString * const kMTAEvent_CloudFileShareToOtherApp;
extern NSString * const kMTAEvent_LocalFileUpload;

extern NSString * const kMTAEvent_FreeMeetingInvite;

/**************************************************************************/
extern NSUInteger const kTempClassroomCommonSID;
extern NSUInteger const kTempClassroomMaxOnStageNum;

extern NSString * const kWebReqUAPrefix;

extern NSString * const kGeneralWebVersion;

extern NSString * const kOriginalImageSuffix;

extern NSString * const kShrinkImageSuffix;

extern NSString * const kHomeworkPublicPath;

extern NSString * const kAwardAnimatedAdd_CH;
extern NSString * const kAwardAnimatedAdd_EN;
extern NSString * const kAwardAnimatedReduce_CH;
extern NSString * const kAwardAnimatedReduce_EN;

static NSUInteger const kChatMessagePageNum = 30;

extern float const kImageCompressQuality;

extern uint8_t const MOLE_BLACKBOAR_VERSATION;

extern NSString * const kLessonSNFlag;
extern NSString * const kLessonSNFlagNew;
extern NSString * const kOpenClassFlag;
extern NSString * const kScanLoginFlag;

extern NSUInteger const kSpecialSID;



extern NSString * const kURLPath_Webschoolauthinfo;
extern NSString * const kURLPath_Webschoolauthinfo_en;

//提交机构认证资料的页面
extern NSString * const kURLPath_Register;
extern NSString * const kURLPath_Register_en;

//用户协议
extern NSString * const kURLPath_Agreement;
extern NSString * const kURLPath_Agreement_en;

//隐私政策
extern NSString * const kURLPath_PrivacyPolicy;
extern NSString * const kURLPath_PrivacyPolicy_en;

//观看App Store升级操作视频
extern NSString * const kURLPath_UpdateVideo;
//引导下载企业版
extern NSString * const kURLPath_EntInstallGuide;

//机构入驻协议
extern NSString * const kURLPath_InstitutionAgreement;
extern NSString * const kURLPath_InstitutionAgreement_en;

//常见问题
extern NSString * const kURLPath_CommonFaq;
extern NSString * const kURLPath_CommonFaq_en;

//功能介绍
extern NSString * const kURLPath_ProductUpdates;
extern NSString * const kURLPath_ProductUpdates_en;

//官网
extern NSString * const kURLPath_OfficialWebsite;
extern NSString * const kURLPath_OfficialWebsite_en;




//老师角色作业详情
extern NSString * const kURLPath_HomeworkDetailTeacher;
//学生角色作业详情
extern NSString * const kURLPath_HomeworkDetailStudent;
//聊天作业模板预览
extern NSString * const kURLPath_HomeworkChat_Preview;
//聊天工具菜单布置作业
extern NSString * const kURLPath_HomeworkChat_Tool;
//作业主窗口(作业列表)
extern NSString * const kURLPath_HomeworkList;
//添加作业模板页面
extern NSString * const kURLPath_HomeworkTemplate_Editor;
//作业模板详情页面
extern NSString * const kURLPath_HomeworkDetail_Template;
//测验详情页
extern NSString * const kURLPath_ExamDetail;
//测验列表
extern NSString * const kURLPath_ExamList;

//从聊天中打开预览试题页面
extern NSString * const kURLPath_QuestionView_Chat;
//打开添加试题资源页面
extern NSString * const kURLPath_QuestionEditorAdd;
//编辑试题
extern NSString * const kURLPath_QuestionEditor;
//打开预览试题页面
extern NSString * const kURLPath_QuestionView;


/**  教室内用到的url Path*/
//教室内作业主窗口
extern NSString * const kURLPath_Classroom_Homework;

//教室创建测验
extern NSString * const kURLPath_Classroom_ExamEditor;
//ipad端学生答题
extern NSString * const kURLPath_Classroom_ExamJoin;
//手机端学生答题
extern NSString * const kURLPath_Classroom_ExamJoin_Room_mb;
//教室教师监考
extern NSString * const kURLPath_Classroom_ExamInvigilation;
//教室答题完讲解
extern NSString * const kURLPath_Classroom_ExamMark;
//教室讲解测验
extern NSString * const kURLPath_Classroom_ExamList;

//edp PPT播放器
extern NSString * const kURLPath_Classroom_EdpPlayer;
//围棋播放器
extern NSString * const kURLPath_Classroom_EdaGoboardPlayer;
//代码查看器
extern NSString * const kURLPath_Classroom_CodeeditorPlayer;
//Excel播放器
extern NSString * const kURLPath_Classroom_ExcelUrlPlayer;


//教室云盘 - 授权资源
extern NSString * const kURLPath_Classroom_ClouddiskLessonId;
//教室云盘 - 我的云盘
extern NSString * const kURLPath_Classroom_ClouddiskIndexRoom;
//教室云盘 - 资源库
extern NSString * const kURLPath_Classroom_ClouddiskSchoolNamePublic;
//教室云盘 - 我的云盘 - 作业资源
extern NSString * const kURLPath_Classroom_HomeworkClouddiskIndexRoom;
//教室云盘 - 试题资源
extern NSString * const kURLPath_Classroom_ClouddiskQuestionsResources;

/**  教室内用到的url Path*/

#endif /* EEOConstants_h */

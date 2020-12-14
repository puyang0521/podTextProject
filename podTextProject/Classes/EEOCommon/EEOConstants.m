//
//  EEOConstants.m
//  EEOCommon
//
//  Created by 蒋敏 on 2018/11/26.
//  Copyright © 2018 jiangmin. All rights reserved.
//

#import "EEOConstants.h"

#import "EEOMacros.h"

#if USE_LBSERVER_FLAG == 1
NSString * const kEEODomain = @"www.eeo.cn";
#elif USE_LBSERVER_FLAG == 2
NSString * const kEEODomain = @"www.eeo.im";
#elif USE_LBSERVER_FLAG == 3
NSString * const kEEODomain = @"www13.eeo.im";
#elif USE_LBSERVER_FLAG == 4
NSString * const kEEODomain = @"www14.eeo.im";
#endif

NSString * const kClassInAppBundleID = @"com.eeoa.ClassIn-iOS";

NSString * const kClassInAppId = @"1226361488";

NSString * const kAppURLScheme = @"classin";

NSString * const kKeychainServiceName = @"com.eeo.classin";
NSString * const kKeychainGUIDDefaultAccount = @"com.eeo.classin.appGUID";

NSString * const kWelcomePageChangedVersion = @"4.0.0.3";

/************************** 语言 ************************************************/
NSString * const kClassInAppLanguage_En = @"en";
NSString * const kClassInAppLanguage_Hans = @"zh-Hans";
NSString * const kClassInAppLanguage_HantTW = @"zh-Hant-TW";
NSString * const kClassInAppLanguage_Spa = @"es";
NSString * const kClassInAppLanguage_JaPan = @"ja";
NSString * const kClassInAppLanguage_Korea = @"ko";
NSString * const kClassInAppLanguage_Vietnamese = @"vi";
NSString * const kClassInAppLanguage_Arabic = @"ar";
NSString * const kClassInAppLanguage_Indonesia = @"id-ID";
NSString * const kClassInAppLanguage_Hungary = @"hu-HU";
/***************************   MTA   ***********************************************/
NSString * const kReportErrorNotifName = @"eeo.notif.reportError";
NSString * const kReportLogNotifName = @"eeo.notif.reportLog";
NSString * const kReportMTAPageViewBeginNotifName = @"eeo.notif.mta.reportPageViewBegin";
NSString * const kReportMTAPageViewEndNotifName = @"eeo.notif.mta.reportPageViewEnd";
NSString * const kReportMTACustomEventNotifName = @"eeo.notif.mta.reportCustomEvent";

NSString * const kMTAEvent_ClassInPage = @"ClassInPage";

NSString * const kMTAEvent_FreeMeeting = @"NavMenu_FreeMeeting";
NSString * const kMTAEvent_AddFriends = @"NavMenu_AddFriends";
NSString * const kMTAEvent_CreateClass = @"NavMenu_CreateClass";
NSString * const kMTAEvent_Scan = @"NavMenu_Scan";
NSString * const kMTAEvent_SearchPublicClass = @"NavMenu_SearchPublicClass";
NSString * const kMTAEvent_CreatePublicClass = @"NavMenu_CreatePublicClass";

NSString * const kMTAEvent_MessageCenter = @"MessageCenterPage";

NSString * const kMTAEvent_AddressbookPage = @"AddressbookPage";

NSString * const kMTAEvent_LearnPage = @"LearnPage";
NSString * const kMTAEvent_CreateLesson = @"Learn_CreateLesson";
NSString * const kMTAEvent_ShareLearningReport = @"Learn_ShareLearningReport";
NSString * const kMTAEvent_CloudUploading = @"Learn_CloudUploading";
NSString * const kMTAEvent_CloudFilePreView = @"Learn_CloudFilePreView";
NSString * const kMTAEvent_SharePublicClass = @"Learn_SharePublicClass";
NSString * const kMTAEvent_CourseDetails = @"Learn_CourseDetails";
NSString * const kMTAEvent_OpenLearningReport = @"Learn_OpenLearningReport";
NSString * const kMTAEvent_OpenVedioReplay = @"Learn_OpenVedioReplay";
NSString * const kMTAEvent_GrowingMenu = @"Learn_Menu";

NSString * const kMTAEvent_MinePage = @"MinePage";
NSString * const kMTAEvent_InstitutionEntry = @"Mine_InstitutionEntry";
NSString * const kMTAEvent_ClearCache = @"Mine_ClearCache";
NSString * const kMTAEvent_MessageNotif = @"Mine_MessageNotif";
NSString * const kMTAEvent_Language = @"Mine_Language";
NSString * const kMTAEvent_AdvancedSetting = @"Mine_AdvancedSetting";
NSString * const kMTAEvent_Logout = @"Mine_Logout";

NSString * const kMTAEvent_CloudDiskPage = @"CloudDiskPage";

NSString * const kMTAEvent_ChatPage = @"ChatPage";
NSString * const kMTAEvent_PersonChat = @"Chat_Person";
NSString * const kMTAEvent_ClassChat = @"Chat_Class";
NSString * const kMTAEvent_ClassroomChat = @"Chat_Classroom";

NSString * const kMTAEvent_HomeworkPage = @"HomeworkPage";
NSString * const kMTAEvent_HomeworkAssignment = @"Homework_Assignment";
NSString * const kMTAEvent_HomeworkEditImage = @"Homework_EditImage";
NSString * const kMTAEvent_HomeworkUploadFile = @"Homework_UploadFile";

NSString * const kMTAEvent_ClassroomPage = @"ClassroomPage";
NSString * const kMTAEvent_ClassroomClosePage = @"Classroom_Close";
NSString * const kMTAEvent_ClassroomRecord = @"Classroom_Record";
NSString * const kMTAEvent_ClassroomGroup = @"Classroom_Group";

NSString * const kMTAEvent_EvokeFromWeb = @"Evoke_Web";
NSString * const kMTAEvent_EvokeFromNotif = @"Evoke_Notif";

NSString * const kMTAEvent_AppFileShared = @"AppFileShared";
NSString * const kMTAEvent_CloudFileShareToOtherApp = @"CloudFileShareToOtherApp";
NSString * const kMTAEvent_LocalFileUpload = @"LocalFileUpload";

NSString * const kMTAEvent_FreeMeetingInvite = @"FreeMeeting_Invite";

/**************************************************************************/
NSUInteger const kTempClassroomCommonSID = 1000077;
NSUInteger const kTempClassroomMaxOnStageNum = 4;

NSString * const kWebReqUAPrefix = @"ClassIn";

NSString * const kGeneralWebVersion = @"3";

NSString * const kOriginalImageSuffix = @"_original";

NSString * const kShrinkImageSuffix = @"_shrink";

NSString * const kHomeworkPublicPath = @"homework";

NSString * const kAwardAnimatedAdd_CH = @"awardAnimation_ch.gif";
NSString * const kAwardAnimatedAdd_EN = @"awardAnimation_en.gif";
NSString * const kAwardAnimatedReduce_CH = @"awardAnimation_reduce_ch.gif";
NSString * const kAwardAnimatedReduce_EN = @"awardAnimation_reduce_en.gif";

float const kImageCompressQuality = 0.48f;

uint8_t const MOLE_BLACKBOAR_VERSATION = 0x1e;

NSString * const kLessonSNFlag = @"classSN";
NSString * const kLessonSNFlagNew = @"sn";
NSString * const kOpenClassFlag = @"cid";
NSString * const kScanLoginFlag = @"loginQRCodeUUID";

/**
 一个特殊的机构id,该机构的公开课都标识为普通课
 */
NSUInteger const kSpecialSID = 2574554;


/************************************ web URL ****************************************/
//学校信息认证
NSString * const kURLPath_Webschoolauthinfo = @"%@/client/viewpage.html?action=webschoolauthinfo";
NSString * const kURLPath_Webschoolauthinfo_en = @"%@/client/viewpage.html?action=webschoolauthinfo_en";

//提交机构认证资料的页面
NSString * const kURLPath_Register = @"%@/cn/register.html";
NSString * const kURLPath_Register_en = @"%@/en/register.html";

//用户协议
NSString * const kURLPath_Agreement = @"%@/client/viewpage.html?action=agreement";
NSString * const kURLPath_Agreement_en = @"%@/client/viewpage.html?action=agreement_en";

//隐私政策
NSString * const kURLPath_PrivacyPolicy = @"%@/client/viewpage.html?action=classin_privacy_policy";
NSString * const kURLPath_PrivacyPolicy_en = @"%@/client/viewpage.html?action=classin_privacy_policy_en";

//观看App Store升级操作视频
NSString * const kURLPath_UpdateVideo = @"%@/client/viewpage.html?action=app_store_update_video";
//引导下载企业版
NSString * const kURLPath_EntInstallGuide = @"https://%@/client/viewpage.html?action=classin_ent_install_guide";

//机构入驻协议
NSString * const kURLPath_InstitutionAgreement = @"%@/client/viewpage.html?action=institution_agreement";
NSString * const kURLPath_InstitutionAgreement_en = @"%@/client/viewpage.html?action=institution_agreement_en";

//常见问题
NSString * const kURLPath_CommonFaq = @"%@/client/viewpage.html?action=common_faq";
NSString * const kURLPath_CommonFaq_en = @"%@/client/viewpage.html?action=common_faq_en";

//功能介绍
NSString * const kURLPath_ProductUpdates = @"%@/client/viewpage.html?action=product_updates";
NSString * const kURLPath_ProductUpdates_en = @"%@/client/viewpage.html?action=product_updates_en";

//官网
NSString * const kURLPath_OfficialWebsite = @"%@/cn";
NSString * const kURLPath_OfficialWebsite_en = @"%@/en";




//老师角色作业详情
NSString * const kURLPath_HomeworkDetailTeacher = @"%@/client/homework/index_im_m.html?courseId=%@&role=%@&routerTo=teacher_popuperHomeworkView%%3FhomeworkId%%3D%@";
//学生角色作业详情
NSString * const kURLPath_HomeworkDetailStudent = @"%@/client/homework/index_im_m.html?courseId=%@&role=%@&routerTo=student_popuperHomeworkView%%3FhomeworkId%%3D%@%%26homeworkStudentId%%3D%@";
//聊天作业模板预览
NSString * const kURLPath_HomeworkChat_Preview = @"%@/client/homework/index_im_m.html?courseId=0&isShare=true#/teacher_popuperHomeworktemplateView?homeworkId=%@";
//聊天工具菜单布置作业
NSString * const kURLPath_HomeworkChat_Tool= @"%@/client/homework/index_im_m.html?courseId=%@&role=%@&popuperName=teacher_popuperHomeworkEditor&popuperData=%%7B%%7D";
//作业主窗口(作业列表)
NSString * const kURLPath_HomeworkList = @"%@/client/homework/index_im_m.html?courseId=%@&role=%@";
//添加作业模板页面
NSString * const kURLPath_HomeworkTemplate_Editor = @"%@/client/homework/index_im_m.html?courseId=0&foderId=%@#/teacher_popuperHomeworktemplateEditor";
//作业模板详情页面
NSString * const kURLPath_HomeworkDetail_Template = @"%@/client/homework/index_im_m.html?courseId=0#/teacher_popuperHomeworktemplateView?homeworkId=%@";


//测验详情页
NSString * const kURLPath_ExamDetail = @"%@/client/pages/qbank/mb/?routerTo=ExamDetail&id=%@&role=%@&courseId=%@&examId=%@#/ExamDetail";
//测验列表
NSString * const kURLPath_ExamList = @"%@/client/pages/qbank/mb/?routerTo=ExamList&role=%@&courseId=%@";

//从聊天中打开预览试题页面
NSString * const kURLPath_QuestionView_Chat = @"%@/client/pages/qbank/mb/?routerTo=QuestionView&questionId=%@&isChat=true";
//打开添加试题资源页面
NSString * const kURLPath_QuestionEditorAdd = @"%@/client/pages/qbank/mb/?routerTo=QuestionEditor&role=teacher&courseId=0&questionType=1&parentId=%@&parentPath=%@";
//编辑试题
NSString * const kURLPath_QuestionEditor = @"%@/client/pages/qbank/mb/?routerTo=QuestionEditor&questionId=%@";
//打开预览试题页面
NSString * const kURLPath_QuestionView = @"%@/client/pages/qbank/mb/?routerTo=QuestionView&questionId=%@";

/**  教室内用到的url Path*/
//教室内作业主窗口
NSString * const kURLPath_Classroom_Homework = @"%@/client/homework/index_room_m.html?courseId=%@&role=%@";
//教室创建测验
NSString * const kURLPath_Classroom_ExamEditor = @"%@/client/pages/qbank/room/?routerTo=ExamEditor&role=%@&courseId=%@";
//ipad端学生答题
NSString * const kURLPath_Classroom_ExamJoin = @"%@/client/pages/qbank/room/?routerTo=examJoin&role=%@&courseId=%@&examId=%@";
//手机端学生答题
NSString * const kURLPath_Classroom_ExamJoin_Room_mb = @"%@/client/pages/qbank/room_mb/?routerTo=examJoin&role=%@&courseId=%@&examId=%@";
//教室教师监考
NSString * const kURLPath_Classroom_ExamInvigilation = @"%@/client/pages/qbank/room/?routerTo=ExamInvigilation&role=%@&courseId=%@&examId=%@&apiRole=%@";
//教室答题完讲解
NSString * const kURLPath_Classroom_ExamMark = @"%@/client/pages/qbank/room/?routerTo=ExamMark&role=%@&courseId=%@&examId=%@";
//教室讲解测验
NSString * const kURLPath_Classroom_ExamList = @"%@/client/pages/qbank/room/?routerTo=ExamList&role=%@&courseId=%@";

//edp PPT播放器
NSString * const kURLPath_Classroom_EdpPlayer = @"/client/widget/edp/edpplayer.html";
//围棋播放器
NSString * const kURLPath_Classroom_EdaGoboardPlayer = @"/client/eda/goboard/index.html";
//代码查看器
NSString * const kURLPath_Classroom_CodeeditorPlayer = @"/client/widget/codeeditor/index.html?%@";
//Excel播放器
NSString * const kURLPath_Classroom_ExcelUrlPlayer = @"/client/eda/h5excel/index.html?excelUrl=";


//教室云盘 - 授权资源
NSString * const kURLPath_Classroom_ClouddiskLessonId = @"%@/client/clouddisk/index_room_m.html?lessonId=%@";
//教室云盘 - 我的云盘
NSString * const kURLPath_Classroom_ClouddiskIndexRoom = @"%@/client/clouddisk/index_room_m.html";
//教室云盘 - 资源库
NSString * const kURLPath_Classroom_ClouddiskSchoolNamePublic = @"%@/client/clouddisk/index_room_m.html?schoolName=public";
//教室云盘 - 我的云盘 - 作业资源
NSString * const kURLPath_Classroom_HomeworkClouddiskIndexRoom = @"%@/client/homework_cloud/index_room_m.html";
//教室云盘 - 试题资源
NSString * const kURLPath_Classroom_ClouddiskQuestionsResources = @"%@/client/pages/qbank/room_mb/?routerTo=QuestionsResources";


/************************************ web URL ****************************************/

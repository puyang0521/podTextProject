//
//  EEOEnums.h
//  EEOCommon
//
//  Created by HeQian on 2016/12/6.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#ifndef EEOEnums_h
#define EEOEnums_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GetWebServerAddressProcess) {
    GetWebServerAddressProcess_Unknown = 0,
    GetWebServerAddressProcess_GetAccessServerAddress,
    GetWebServerAddressProcess_ClientAccessRequest,
    GetWebServerAddressProcess_GetWebServerAddress,
};
typedef NS_ENUM(NSUInteger, GetWebServerAddressFailed) {
    GetWebServerAddressFailed_Unknown = 0,
    GetWebServerAddressFailed_GetAccessServerAddressFailed,
    GetWebServerAddressFailed_ConnectToAccessServerFailed,
    GetWebServerAddressFailed_GetWebServerAddressFailed,
    GetWebServerAddressFailed_OperationTimeout,
    GetWebServerAddressFailed_InMaintain,
};

typedef NS_ENUM(NSUInteger, LoginProcess) {
    LoginProcess_Unknown = 0,
    LoginProcess_GetAccessServerAddress,
    LoginProcess_ConnectToAccessServer,
    LoginProcess_ClientAccessRequest,
    LoginProcess_GetWebServerAddress,
    LoginProcess_Login,
};
typedef NS_ENUM(NSUInteger, LoginFailed) {
    LoginFailed_Unknown = 0,
    LoginFailed_GetAccessServerAddressFailed,
    LoginFailed_ConnectToAccessServerFailed,
    LoginFailed_ClientNewVersionExists,
    LoginFailed_ClientVersionNotSupported,
    LoginFailed_ClientTypeNotSupported,
    LoginFailed_ClientVersionIsLower,
    LoginFailed_GetWebServerAddressFailed,
    LoginFailed_RepeatedLogin,
    LoginFailed_AccountUnknown,
    LoginFailed_AccountIncorrectFormat,
    LoginFailed_AccountNotExisting,
    LoginFailed_PasswordIncorrect,
    LoginFailed_AccountLocked,
    LoginFailed_AccountUnactivated,
    LoginFailed_AccountToBeValidated,
    LoginFailed_LoginFailed,
    LoginFailed_OperationTimeout,
    LoginFailed_InMaintain,
};

typedef NS_ENUM(NSUInteger, LogoutProcess) {
    LogoutProcess_Unknown = 0,
    LogoutProcess_LogoutDeviceToken,
    LogoutProcess_Logout,
    LogoutProcess_CloseBasicConnection,
};

typedef NS_ENUM(NSUInteger, EnterClassroomProcess) {
    EnterClassroomProcess_Unknown = 0,
    EnterClassroomProcess_CheckClassroomAvailable,
    EnterClassroomProcess_GetClassroomEquipments,
    EnterClassroomProcess_EnterClassroom,
    EnterClassroomProcess_GetMediaServer,
    EnterClassroomProcess_ConnectToMediaClassroom,
};
typedef NS_ENUM(NSUInteger, EnterClassroomFailed) {
    EnterClassroomFailed_Unknown = 0,
    EnterClassroomFailed_LoginFailed,
    EnterClassroomFailed_SchoolNotExisted,
    EnterClassroomFailed_SchoolWasReported,
    EnterClassroomFailed_SchoolOweFee,
    EnterClassroomFailed_SchoolIsLocked,
    EnterClassroomFailed_SchoolIsInvalid,
    EnterClassroomFailed_CourseNotExisted,
    EnterClassroomFailed_CourseIsReported,
    EnterClassroomFailed_CourseDeleted,
    EnterClassroomFailed_CourseExpired,
    EnterClassroomFailed_CourseIsInvalid,
    EnterClassroomFailed_CourseNotPurchased,
    EnterClassroomFailed_LessonNotExisted,
    EnterClassroomFailed_LessonIsEnded,
    EnterClassroomFailed_LessonWasReported,
    EnterClassroomFailed_LessonDeleted,
    EnterClassroomFailed_LessonTimeNotArrived,
    EnterClassroomFailed_LessonAlreadyDismissed,
    EnterClassroomFailed_LessonReachTrialUpLimit,
    EnterClassroomFailed_LessonReachStudentUpLimit,
    EnterClassroomFailed_UserIsKickedOutFromClass,
    EnterClassroomFailed_NumberedMode,
    EnterClassroomFailed_NoRight,
    EnterClassroomFailed_MediaServerNotAvailable,
    EnterClassroomFailed_GetMediaServerFailed,
    EnterClassroomFailed_ConnectToMediaServerFailed,
    EnterClassroomFailed_EnterClassroomFailed,
    EnterClassroomFailed_OperationTimeout,
};

typedef NS_ENUM(NSUInteger, EnterPublicClassroomProcess) {
    EnterPublicClassroomProcess_Unknown = 0,
    EnterPublicClassroomProcess_GetPublicLessonInfo,
    EnterPublicClassroomProcess_Registration,
    EnterPublicClassroomProcess_EnterClassroom,
};
typedef NS_ENUM(NSUInteger, EnterPublicClassroomFailed) {
    EnterPublicClassroomFailed_Unknown = 0,
    EnterPublicClassroomFailed_LoginFailed,
    EnterPublicClassroomFailed_GetPublicLessonInfoFailed,
    EnterPublicClassroomFailed_RegistrationFailed,
    EnterPublicClassroomFailed_EnterClassroomFailed,
    EnterPublicClassroomFailed_OperationTimeout,
};

typedef NS_ENUM(NSUInteger, EnterExperienceClassroomProcess) {
    EnterExperienceClassroomProcess_Unknown = 0,
    EnterExperienceClassroomProcess_Registration,
    EnterExperienceClassroomProcess_EnterClassroom,
};
typedef NS_ENUM(NSUInteger, EnterExperienceClassroomFailed) {
    EnterExperienceClassroomFailed_Unknown = 0,
    EnterExperienceClassroomFailed_LoginFailed,
    EnterExperienceClassroomFailed_RegistrationFailed,
    EnterExperienceClassroomFailed_EnterClassroomFailed,
    EnterExperienceClassroomFailed_OperationTimeout,
};

typedef NS_ENUM(NSUInteger, EnterTempClassroomProcess) {
    EnterTempClassroomProcess_Unknown = 0,
    EnterTempClassroomProcess_Registration,
    EnterTempClassroomProcess_EnterClassroom,
};
typedef NS_ENUM(NSUInteger, EnterTempClassroomFailed) {
    EnterTempClassroomFailed_Unknown = 0,
    EnterTempClassroomFailed_LoginFailed,
    EnterTempClassroomFailed_RegistrationFailed,
    EnterTempClassroomFailed_EnterClassroomFailed,
    EnterTempClassroomFailed_OperationTimeout,
};

typedef NS_ENUM(NSUInteger, QuitClassroomProcess) {
    QuitClassroomProcess_Unknown = 0,
    QuitClassroomProcess_CloseMediaConnection,
    QuitClassroomProcess_QuitClassroom,
};

typedef NS_ENUM(NSUInteger, SetUserBasicInfoFailed) {
    SetUserBasicInfoFailed_Unknown = 0,
    SetUserBasicInfoFailed_SensitiveWordFoundInNickName,
    SetUserBasicInfoFailed_SensitiveWordFoundInTrueName,
};
typedef NS_ENUM(NSUInteger, SetUserAvatarInfoFailed) {
    SetUserAvatarInfoFailed_Unknown = 0,
    SetUserAvatarInfoFailed_ItemParsingError,
};

typedef NS_ENUM(NSUInteger, WebAPIResponseCode) {
    WebAPIResponseCode_NoError = 1,
    WebAPIResponseCode_TelephoneNotPass = 100,
    WebAPIResponseCode_KeyIsIllegal = 102,
    WebAPIResponseCode_UnKnownError = 104,
    WebAPIResponseCode_NickNameIsEmpty = 106,
    WebAPIResponseCode_TimesUpperLimit = 108,
    WebAPIResponseCode_Frequently = 109,
    WebAPIResponseCode_Failed = 110,
    WebAPIResponseCode_ProvInputIllegal = 111,
    WebAPIResponseCode_TwoPasswordInconsistent = 112,
    WebAPIResponseCode_TelephoneNotRegistered = 113,
    WebAPIResponseCode_ICEServerUnconnected = 114,
    WebAPIResponseCode_TelephoneIsIllegal = 134,
    WebAPIResponseCode_TelephoneHasRegistered = 135,
    WebAPIResponseCode_PasswordLengthIsIllegal = 137,
};

typedef NS_ENUM(NSUInteger, TPPayPurposeType) {
    TPPayPurposeType_Recharge = 0,
    TPPayPurposeType_AYuanPayment,
};

typedef NS_ENUM(NSUInteger, TempClassroomType) {
    TempClassroomType_Default = 0,
    TempClassroomType_Class = 1,//班级
    TempClassroomType_Contact = 2,//好友
};

typedef NS_ENUM(NSInteger, NetworkStatusType) {
    NetworkStatusType_Unknown = -1,
    NetworkStatusType_NotReachable = 0,
    NetworkStatusType_ReachableViaWiFi,
    NetworkStatusType_ReachableViaWWAN
};

typedef NS_ENUM(NSInteger, CRMediaConnectionNetworkQualityLevel) {
    CRMediaConnectionNetworkQualityLevel_Unknown = -1,
    CRMediaConnectionNetworkQualityLevel_Good,
    CRMediaConnectionNetworkQualityLevel_Normal,
    CRMediaConnectionNetworkQualityLevel_Bad,
    CRMediaConnectionNetworkQualityLevel_Poor,
    CRMediaConnectionNetworkQualityLevel_NotReach,
};

typedef NS_ENUM(NSInteger, AutoCheckInfoSource) {
    AutoCheckInfoSource_Unknown = 0,
    AutoCheckInfoSource_DeviceChange = 2,//切换
    AutoCheckInfoSource_LoginAutoCheck = 3,//登录自检
    AutoCheckInfoSource_DevicePlug = 4,//插拔
    AutoCheckInfoSource_DeviceSwitch = 5,//开关
    AutoCheckInfoSource_LoginComplete = 6,//登录完成
};

typedef NS_ENUM(NSInteger, AppLanguageType) {
    AppLanguageType_EN = 0,
    AppLanguageType_ZH = 1,
};

typedef NS_ENUM(NSUInteger, CustomMsgTag) {
    CustomMsgTag_Unknown,
    CustomMsgTag_LearningDataReports,
    CustomMsgTag_TeachingDataReport,
    CustomMsgTag_CollectClientLog,
    CustomMsgTag_Homework,
    CustomMsgTag_InvitesByExperienceClassroom,
    CustomMsgTag_DepartmentStaffChanges,
    CustomMsgTag_AboutToBeMaintained,
    CustomMsgTag_Examination,
};
typedef NS_ENUM(NSUInteger, CustomPushCommandOption) {
    CustomPushCommandOption_LearningDataReports = 0,
    CustomPushCommandOption_TeachingDataReport = 1,
    CustomPushCommandOption_ExpeditingHomework = 3,
    CustomPushCommandOption_ExpeditingExam = 4,
};

typedef NS_ENUM(NSInteger, PushMessageCertType) {
    PushMessageCertType_Unknown = -1,
    PushMessageCertType_AppStoreRelease = 0,
    PushMessageCertType_EnterpriseRelease = 1,
    PushMessageCertType_AppStoreSandbox = 2,
    PushMessageCertType_EnterpriseSandbox = 3,
};

typedef NS_ENUM(NSInteger, LiveMediaDataType) {
    LiveMediaDataType_Unknown = -1,
    LiveMediaDataType_Audio = 0,
    LiveMediaDataType_AudioShared,
    LiveMediaDataType_Video,
    LiveMediaDataType_VideoShared,
    LiveMediaDataType_Laserpen,
};

typedef NS_ENUM(NSInteger, ShareTagType) {
    ShareTagTypeDefault = 0,
    ShareTagTypeLearnReport,
    ShareTagTypeCourseLive,
};

typedef NS_ENUM(NSUInteger, CSSOpenWebAPIReqFailed) {
    CSSOpenWebAPIReqFailed_ParameterNotValid = 1,
    CSSOpenWebAPIReqFailed_ResponseDataNotValid,
    CSSOpenWebAPIReqFailed_ReqError,
};

typedef NS_ENUM(NSUInteger, CRQuitClassroomReason) {
    CRQuitClassroomReason_ActiveQuit = 1,//主动退出
    CRQuitClassroomReason_Closed = 2,//教室关闭
    CRQuitClassroomReason_ClientException = 3,//客户端程序异常
    CRQuitClassroomReason_Kickout = 4,//被踢出教室
    CRQuitClassroomReason_ServerClosed = 5,//服务关闭
    CRQuitClassroomReason_DisconnectedConnection = 6,//断线重连
    CRQuitClassroomReason_Unsubscribe = 7,//用户退课
    CRQuitClassroomReason_RoleChanged = 8,//用户角色转换
    
    CRQuitClassroomReason_ServerException = 50,//服务端内部异常
    CRQuitClassroomReason_ServerNetworkSuspend = 51,//服务间网络中断
    CRQuitClassroomReason_ClientNormalLogin = 52,//客户端正常登录
    CRQuitClassroomReason_ClientLoginInPlaces = 53,//客户端异地强制登录
    CRQuitClassroomReason_ClientLoginInLocal = 54,//客户端本机重复登录
    CRQuitClassroomReason_ClientNormalLogout = 55,//客户端正常登出
    CRQuitClassroomReason_ServerAndClientNetBetween = 56,//服务端与客户端网络连接中断
    CRQuitClassroomReason_ServerSideLosesClientHeartbeat = 57,//服务端失去客户端心跳
    CRQuitClassroomReason_ServerForcesClientToLogout = 58,//服务端强制客户端登出
    
    CRQuitClassroomReason_CallStateIncoming = 102,//接到电话
    CRQuitClassroomReason_LockScreen = 104,//锁屏
    CRQuitClassroomReason_LessonStatusChanged = 107,//课节状态改变
    CRQuitClassroomReason_AppDidEnterBackground = 111,//App进入后台
};

typedef NS_ENUM(NSUInteger, ChatMediaDataType) {
    ChatMediaDataType_Image = 2,//原图
    ChatMediaDataType_Voice = 4,//语音
    ChatMediaDataType_Thumbnail = 5,//缩略图
    ChatMediaDataType_ProblemSolving = 6,//问题求解中的图片
};

typedef  NS_ENUM(NSInteger, FileExtensionType){
    FileExtensionType_unKnow = 0,
    FileExtensionType_EEO,
    FileExtensionType_ppt,
    FileExtensionType_excel,
    FileExtensionType_word,
    FileExtensionType_pdf,
    FileExtensionType_jpg,
    FileExtensionType_mp3,
    FileExtensionType_video,
    FileExtensionType_txt,
    FileExtensionType_chess,   //国际象棋
    FileExtensionType_go,       //围棋
    FileExtensionType_homeworkTemplate //作业模版
};

typedef  NS_ENUM(NSInteger, FileSupportPreViewType){
    FileSupportPreViewType_unKnow,
    FileSupportPreViewType_pdf_word,
    FileSupportPreViewType_ppt,
    FileSupportPreViewType_execl,
    FileSupportPreViewType_jpg,
    FileSupportPreViewType_mp3,
    FileSupportPreViewType_video,
    FileSupportPreViewType_txt,
    FileSupportPreViewType_edb,
};

typedef  NS_ENUM(NSInteger, ShortchtItemActionType){
    ShortchtItemActionType_Unknown = 0,
    ShortchtItemActionType_Scan,//扫一扫
};

typedef  NS_ENUM(NSInteger, RecordInfoEvent){
    RecordInfoEvent_Start = 0,//开始录课
    RecordInfoEvent_Stop = 1,//停止录课
    RecordInfoEvent_Exception = 2,//录课异常
    RecordInfoEvent_Config = 3,//录课配置信息
    RecordInfoEvent_Network = 4//录课推流网络信息
};
typedef  NS_ENUM(NSInteger, RecordExceptionType){
    RecordExceptionType_Unknown = 0,
    RecordExceptionType_OutputChanged = 1,
    RecordExceptionType_AudioCapture = 2,
    RecordExceptionType_MicData = 3,
    RecordExceptionType_AudioOpen = 4
};

#endif /* EEOEnums_h */

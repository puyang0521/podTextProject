//
//  NSString+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/4/13.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EEOCheckPasswordErrorType) {
    EEOCheckPasswordErrorTypeNone,
    EEOCheckPasswordErrorTypeLengthIsNotInRange,
    EEOCheckPasswordErrorTypeNotHasNumbersAndLetters,
    EEOCheckPasswordErrorTypeOnlyNumbers,
    EEOCheckPasswordErrorTypeOnlyLetters,
    EEOCheckPasswordErrorTypeContainsChinese,
    EEOCheckPasswordErrorTypeContainsSpaces,
    EEOCheckPasswordErrorTypeInvalidSymbol
};

@interface NSString (EEO)
NS_ASSUME_NONNULL_BEGIN
@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1sumString;
/**
 *  校正手机号码
 */
+ (BOOL)checkIfVaildPhoneNumber:(NSString*)string;
/**
 校验邮箱
 */
+ (BOOL)checkEmailAddress:(NSString *)string;

/**
 *  @brief  获取随机 UUID 例如 E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 *
 *  @return 随机 UUID
 */
+ (NSString *)UUID;

+ (NSString *)base64String:(NSString *)source;

+ (NSString*)stringWithSeconds:(NSTimeInterval)seconds;
+ (NSString*)HHMMSSStringWithSeconds:(NSTimeInterval)seconds;

+ (NSString*)ipaddressWithUInt32:(NSUInteger)ipaddressNum;

- (NSUInteger)ipaddressNum;

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithDictionaryNonRedundantCharacters:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

+ (BOOL)isPureInt:(NSString*)string;

/**
 手机号隐藏中间位数

 @param phoneNum 手机号
 @return 7~11位手机号格式 188***8、188***88、188****88、188****888、188****8888
 */
+ (NSString *)phoneNumToAsterisk:(NSString *)phoneNum;

/**
 是否有特殊字符
 */
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;

/**
 根据后缀名判断文件类型
 */
+(NSUInteger)getFileTypeWithPathExtension:(NSString *)pathExtension;
/**
 根据后缀名返回支持预览的类型
 */
+ (NSUInteger)preViewFileTypeWithPathExtension:(NSString *)pathExtension;

//过滤表情
+ (NSString *)filterEmoji:(NSString *)text;

/**
 规则 数字 符号 中英混
 @param aClassName 类名
 @param propertyName 属性名 或 返回值为需要排序的属性名的方法名
 @return 混排后对象数组
 */
+(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr ClassName:(Class)aClassName PropertyName:(NSString *)propertyName;

/**
 url格式验证

 @param url 网址
 @return 返回是否格式正确
 */
+ (BOOL)checkUrlValidation:(NSString *)url;

+ (BOOL)isNum:(NSString *)checkedNumString;

+ (BOOL)isHasNumberAndWord:(NSString *)string;

+ (BOOL)hasChinese:(NSString *)str;//是否还有中文

+ (BOOL)hasEnglish:(NSString *)str;//是否含有英文
/**
 过滤字符串首尾空白字符和换行符
 */
+ (NSString *)filterWhitespaceAndNewlineCharacter:(NSString *)string;

+ (NSString *)networkStatusDescribeWithNetStatus:(NSInteger)netStatus;

/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2;

/**
 优先使用utf8编码其次使用gbk最后使用ASCII

 @param data 字符数据
 @return 有可能为nil
 */
+ (nullable NSString *)stringWithDataByMultiCoding:(NSData *)data;

/*
 转为拼音
 */
+ (NSArray *)transformToPinyin:(NSString *)aString;
/**
 拼音搜索

 @param displayName 原字符串
 @param name 搜索字段
 @return 搜索字段所在的位置，默认为-1
 */

+ (NSInteger)pinyinSearchWithString:(NSString *)displayName searchName:(NSString *)name;
/*
 搜索结果高亮
 */
+ (NSDictionary *)pinyinSearchWithString:(NSString *)displayName searchName:(NSString *)name textColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor;

+ (NSRange)fuzzySearchWithSearchString:(NSString *)searchKeyWord originString:(NSString *)originString;
+(NSString *)getPublicKeyWordFromUrl:(NSString *_Nonnull)urlStr;
+(NSNumber *)getOpenClassIDFromUrl:(NSString *_Nonnull)urlStr;
+(BOOL)checkPublicKeyWordFormatWithSN:(NSString *)sn;
/**
 解析头像URL

 @param jsonStr 储存头像信息的json
 @param outOriginalURL 输出原图URL
 @param outCompressionURL 输出压缩图URL
 @param outThumbnailURL 输出缩略图URL
 */
+ (void)parseAvatarURLJsonStr:(NSString *)jsonStr outOriginalURL:(NSString **)outOriginalURL outCompressionURL:(NSString **)outCompressionURL outThumbnailURL:(NSString **)outThumbnailURL;


/**
 SHA1 hash

 @param key 加密参数
 @param baseString 加密参数
 */
+ (NSString *)hashSha1StringWithKey:(NSString *)key baseString:(NSString *)data;

/**
 将token转换成字符串

 @param deviceToken token
 @return token字符串
 */
+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken;

- (NSUInteger)byteLength;

+ (NSDictionary *)dictionaryWithJsonStr:(NSString *)jsonString;

//检测密码是否符合规则
+ (EEOCheckPasswordErrorType)checkPasswordIsLegal:(NSString *)password;

//AES-128-ECB 加密
+(NSString *) aesEncryptString:(NSString *)content key:(NSString *)key;

//AES-128-ECB 解密
+(NSString *) aesDecryptString:(NSString *)content key:(NSString *)key;

//十进制转二进制
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSString *)decimal;

//二进制转十进制
+ (NSString *)convertDecimalSystemFromBinarySystem:(NSString *)binary;

// 过滤左边指定的内容
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;

// 过滤右边指定的内容
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

// 安全的截取字符串
- (NSString *)eeo_safeSubstringToIndex:(NSUInteger)index;

NS_ASSUME_NONNULL_END
@end

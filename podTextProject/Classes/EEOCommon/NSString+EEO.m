//
//  NSString+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/4/13.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSString+EEO.h"
#import "NSObject+EEO.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonCryptor.h>

#import "EEOEnums.h"
#import "NSDictionary+EEO.h"
#import "EEOConstants.h"

@implementation NSString (EEO)

- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

- (NSString *)sha1sumString {
    const char *cstr = self.UTF8String;
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}

+ (NSString *)hashSha1StringWithKey:(NSString *)key baseString:(NSString *)data {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *hmac = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSMutableString* hash = [[NSMutableString alloc]init];
    const char* bytes = [hmac bytes];
    NSInteger length = MIN(CC_SHA1_DIGEST_LENGTH, [hmac length]);
    for (int i = 0; i < length; i++) {
        [hash appendFormat:@"%02.2hhx", bytes[i]];
    }
    
    return [hash lowercaseString];
}

+ (BOOL)checkIfVaildPhoneNumber:(NSString*)string
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|7[0-9])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:string] == YES)
        || ([regextestcm evaluateWithObject:string] == YES)
        || ([regextestct evaluateWithObject:string] == YES)
        || ([regextestcu evaluateWithObject:string] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (BOOL)checkEmailAddress:(NSString *)string{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [predicate evaluateWithObject:string];
}

+ (NSString *)UUID
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)
    {
        return  [[NSUUID UUID] UUIDString];
    }
    else
    {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        return (__bridge_transfer NSString *)uuid;
    }
}

+ (NSString *)base64String:(NSString *)source {
    NSString *result = [NSString stringWithString:source];
    NSData *sourceData = [source dataUsingEncoding:NSUTF8StringEncoding];
    if(sourceData && sourceData.length > 0){
        result = [sourceData base64EncodedStringWithOptions:0];
    }
    return result;
}

+ (NSString*)stringWithSeconds:(NSTimeInterval)tiSeconds {
    NSString *result = @"";

    NSUInteger time = (NSUInteger)tiSeconds;
    NSUInteger hours = time / 3600;
    NSUInteger minutes = (time / 60) % 60;
    NSUInteger seconds = time % 60;

    NSString *format = nil;
    if(hours > 0){
        format = @"%02i:%02i:%02i";
        result = [self stringWithFormat:format,hours,minutes,seconds];
    }else{
        format = @"%02i:%02i";
        result = [self stringWithFormat:format,minutes,seconds];
    }

    return result;
}
+ (NSString *)HHMMSSStringWithSeconds:(NSTimeInterval)tiSeconds {
    NSString *result = @"";

    NSUInteger time = (NSUInteger)tiSeconds;
    NSUInteger hours = time / 3600;
    NSUInteger minutes = (time / 60) % 60;
    NSUInteger seconds = time % 60;

    NSString *format = @"%02i:%02i:%02i";
    result = [self stringWithFormat:format,hours,minutes,seconds];

    return result;
}

+ (NSString*)ipaddressWithUInt32:(NSUInteger)ipaddressNum {
    NSString *result = @"";
    char *ipaddr = NULL;
    char addr[20];
    struct in_addr inaddr;
    ipaddressNum = CFSwapInt32HostToBig((unsigned int)ipaddressNum);
    inaddr.s_addr = (unsigned int)ipaddressNum;
    ipaddr = inet_ntoa(inaddr);
    strcpy(addr,ipaddr);
    
    result = [NSString stringWithUTF8String:ipaddr];
    
    return result;
}

- (NSUInteger)ipaddressNum {
    NSUInteger result = 0;
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_len = sizeof(struct sockaddr_in);
    inet_aton([self UTF8String], &addr.sin_addr);
    result = addr.sin_addr.s_addr;
    result = CFSwapInt32BigToHost((unsigned int)result);
    
    return result;
}


+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}
+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"%s error: %@",__func__, error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+(NSString *) jsonStringWithDictionaryNonRedundantCharacters:(NSDictionary *)dictionary {
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"%s error: %@",__func__, error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = jsonString.length <= 0 ? @"" : jsonString;
    }
    return jsonString;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

+ (NSString *)phoneNumToAsterisk:(NSString *)phoneNum{

    NSString *newPhoneNum;
    if (phoneNum.length > 6 && phoneNum.length <= 8 ) {

        newPhoneNum = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 3) withString:@"***"];

    }else if(phoneNum.length > 8){

        newPhoneNum = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

    }

    return  newPhoneNum;
}

+ (BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~ ￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

+(NSUInteger)getFileTypeWithPathExtension:(NSString *)pathExtension{
    NSString * extensionLower =  [pathExtension lowercaseString];
    if ([@[@"edb",@"edp",@"edt",@"edu",@"eda"] containsObject:extensionLower]) {
        return FileExtensionType_EEO;
    }else if ([@[@"sgf"] containsObject:extensionLower]) {
        return FileExtensionType_go;
    }else if ([@[@"pgn",@"fen"] containsObject:extensionLower]) {
        return FileExtensionType_chess;
    }else if ([@[@"pptx",@"ppt",@"pptm"] containsObject:extensionLower]){
        return FileExtensionType_ppt;
    }else if ([@[@"xlsx",@"xls",@"csv"] containsObject:extensionLower]){
        return FileExtensionType_excel;
    }else if ( [@[@"docx",@"doc"] containsObject:extensionLower]){
        return FileExtensionType_word;
    }else if ( [@[@"pdf"] containsObject:extensionLower]){
        return FileExtensionType_pdf;
    }else if ( [@[@"jpeg",@"jpg",@"png",@"bmp"] containsObject:extensionLower]){
        return FileExtensionType_jpg;
    }else if ( [@[@"mp3",@"wav",@"wma",@"aac",@"flac",@"m4a",@"oga",@"opus"] containsObject:extensionLower]){
        return FileExtensionType_mp3;
    }else if ( [@[@"mp4",@"3gp",@"mpg",@"mpeg",@"3g2",@"avi",@"flv",@"wmv",@"h264",@"m4v",@"mj2",@"mov",@"ogg",@"ogv",@"rm",@"qt",@"vob",@"webm",] containsObject:extensionLower]){
        return FileExtensionType_video;
    }else if ( [@[@"txt",@"html",@"htm",@"css",@"js",@"as",@"cpp",@"c",@"cc",@"cxx",@"h",@"java",@"md",@"matlab",@"pascal",@"pl",@"php",@"py",@"r",@"rb",@"ru",@"sql",@"swift",@"rbx",@"rs",@"go"] containsObject:extensionLower]){
        return FileExtensionType_txt;
    }else{
        return FileExtensionType_unKnow;
    }
}

+ (NSUInteger)preViewFileTypeWithPathExtension:(NSString *)pathExtension{
    FileExtensionType type = [NSString getFileTypeWithPathExtension:pathExtension];
    switch (type) {
        case FileExtensionType_word:
        case FileExtensionType_pdf:
            return FileSupportPreViewType_pdf_word;
        case FileExtensionType_ppt:
            return FileSupportPreViewType_ppt;
//        case FileExtensionType_excel:
//            return FileSupportPreViewType_execl;
        case FileExtensionType_txt:
            return FileSupportPreViewType_txt;
        case FileExtensionType_jpg:
            return FileSupportPreViewType_jpg;
        case FileExtensionType_mp3:
            return FileSupportPreViewType_mp3;
        case FileExtensionType_video:
            return FileSupportPreViewType_video;
        case FileExtensionType_EEO:
            if ([pathExtension isEqualToString:@"edb"]) {
                return FileSupportPreViewType_edb;
            }
        case FileExtensionType_chess:
        case FileExtensionType_go:
        case FileExtensionType_excel:
        default:
            return FileSupportPreViewType_unKnow;
    }
}

//表情符号的判断
+ (NSString *)filterEmoji:(NSString *)text
{
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
//                                                               options:0
//                                                                 range:NSMakeRange(0, [text length])
//                                                          withTemplate:@""];
//    return modifiedString;

    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[text length]];

    [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring stringContainsEmoji])? @"": substring];
                          }];

    return buffer;
}

- (BOOL)stringContainsEmoji{
    
    BOOL isEomji = NO;
    
    const unichar hs = [self characterAtIndex:0];
    //NSLog(@"hs++++++++%04x",hs);
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f7ef){
                isEomji = YES;
            }else if (0x1f900 <= uc && uc <= 0x1f9ff) {
                isEomji = YES;
            }else if (0x1fa70 <= uc && uc <= 0x1fa95){
                isEomji = YES;
            }
            //NSLog(@"uc++++++++%04x",uc);
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3|| ls ==0xfe0f || ls == 0xd83c) {
            isEomji = YES;
        }
        //NSLog(@"ls++++++++%04x",ls);
    } else {
        if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
            isEomji = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            isEomji = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            isEomji = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            isEomji = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
            isEomji = YES;
        }
    }
    
    return isEomji;
}

+(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr ClassName:(Class)aClassName PropertyName:(NSString *)propertyName{
    SEL getPro = NSSelectorFromString(propertyName);
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    //将每个名字分到某个section下
    for (id filesModel in arr) {
        NSInteger sectionNumber = [collation sectionForObject:filesModel collationStringSelector:getPro];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:filesModel];
    }
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:getPro];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //数字和符号排在字母前面
    NSMutableArray * numberSymbolArr = [[NSMutableArray alloc] init];
    [numberSymbolArr addObjectsFromArray:newSectionsArray[26]];
    if (numberSymbolArr.count > 0) {
        [numberSymbolArr sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
//            return [[obj1 valueForKey:propertyName] localizedCompare:[obj2 valueForKey:propertyName]];
              return [[obj1 safeValuePerformSelector:getPro] localizedCompare: [obj2 safeValuePerformSelector:getPro]];
        }];
//        numberSymbolArr = [numberSymbolArr sortedArrayUsingFunction:nickNameSort context:NULL];
    }
    [resultArr addObjectsFromArray:numberSymbolArr];
    
    //A-Z
    for (NSInteger index = 0; index < newSectionsArray.count-1; index++) {
        NSArray *indexArr = newSectionsArray[index];
        if (indexArr.count > 0) {
            [resultArr addObjectsFromArray:indexArr];
        }
    }
    return resultArr;
}

+ (BOOL)checkUrlValidation:(NSString *)url{
    NSError *error;
    NSString *regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:url options:0 range:NSMakeRange(0, [url length])];

    if (arrayOfAllMatches.count == 1) {
        return YES;
    }

    return NO;
}

+ (BOOL)isNum:(NSString *)checkedNumString {
    if (checkedNumString == nil) {
        return NO;
    }

    if (checkedNumString.length == 0) {
        return NO;
    }
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isHasNumberAndWord:(NSString *)string
{
    if (string == nil) {
        return NO;
    }

    if (string.length == 0) {
        return NO;
    }

    NSString *regex = @"^[0-9a-zA-Z_]*$";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    if ([predicate evaluateWithObject:string] == YES)
    {
        return YES;
    }
    return NO;
}


+ (BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)hasEnglish:(NSString *)str {

    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];

    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];

    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字

    if (count > 0) {

        return YES;

    }
    return NO;
}

+ (NSString *)filterWhitespaceAndNewlineCharacter:(NSString *)string{
    NSString *filterStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    filterStr = [filterStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    filterStr = [filterStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return filterStr;
}

+ (NSString *)networkStatusDescribeWithNetStatus:(NSInteger)netStatus {
    NSString *result = @"";
    switch (netStatus) {
        case NetworkStatusType_NotReachable:
            result = @"NotReachable";
            break;
        case NetworkStatusType_ReachableViaWiFi:
            result = @"ReachableViaWiFi";
            break;
        case NetworkStatusType_ReachableViaWWAN:
            result = @"ReachableViaWWAN";
            break;
        default:
            result = @"Unknown";
            break;
    }
    return result;
}

+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }

    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }

    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }

    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最少的，进行循环比较
    NSInteger smallCount = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count;

    for (int i = 0; i < smallCount; i++) {
        NSInteger value1 = [[v1Array objectAtIndex:i] integerValue];
        NSInteger value2 = [[v2Array objectAtIndex:i] integerValue];
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }

        // 版本相等，继续循环。
    }

    // 版本可比较字段相等，则字段多的版本高于字段少的版本。
    if (v1Array.count > v2Array.count) {
        return 1;
    } else if (v1Array.count < v2Array.count) {
        return -1;
    } else {
        return 0;
    }

    return 0;
}

+ (nullable NSString *)stringWithDataByMultiCoding:(NSData *)data {
    NSString *reuslt = nil;
    if(data){
        reuslt = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(reuslt == nil){
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            reuslt = [[NSString alloc] initWithData:data encoding:gbkEncoding];
            if(reuslt == nil){
                reuslt = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            }
        }
    }
    return reuslt;
}

/*
 转为拼音
 */
+ (NSArray *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);

    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];

    return pinyinArray;

}

+ (NSDictionary *)pinyinSearchWithString:(NSString *)displayName searchName:(NSString *)name textColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:displayName];
    [attrStr addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, displayName.length)];

    NSArray *pinyinArr = [self transformToPinyin:displayName];

    NSInteger searchResultLocation = -1;
    //原文搜索
    NSRange displayNameRange = [displayName rangeOfString:name options:NSCaseInsensitiveSearch];
    if (displayNameRange.length > 0) {
        searchResultLocation = displayNameRange.location;
        [attrStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(searchResultLocation, name.length)];
    }

    NSMutableString *initialStr = [NSMutableString stringWithString:@""];
    NSMutableArray *locationArr = [NSMutableArray array];
    NSInteger location = 0;
    //拼音搜索
    for (NSString *pinyin in pinyinArr)
    {
        if (pinyin.length > 0)
        {
            //标记首字母及所在原字符串中的位置
            [initialStr appendString:[pinyin eeo_safeSubstringToIndex:1]];
            [locationArr addObject:@(location)];

            BOOL isPinyin = ![displayName containsString:pinyin];

            if ([pinyin rangeOfString:name options:NSCaseInsensitiveSearch].length > 0) {
                [attrStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(location, isPinyin ? 1 : name.length)];
                //标记拼音搜索结果的位置
                if (searchResultLocation < 0) {
                    searchResultLocation = location;
                }else{
                    searchResultLocation = MIN(searchResultLocation, location);
                }
            }

            //区分中文拼音与英文单词所占长度
            if (!isPinyin) {
                location = location + pinyin.length;
            }else{
                location += 1;
            }
        }
    }

    //首字母搜索
    NSRange initialRange = [initialStr rangeOfString:name options:NSCaseInsensitiveSearch];
    if (initialRange.length > 0) {

        for (int i = 0; i < initialRange.length; i++) {
            //在原字符串中的位置
            NSInteger initialLocation = [locationArr[initialRange.location] integerValue];

            NSString *pinyin = pinyinArr[initialRange.location];
            BOOL isPinyin = ![displayName containsString:pinyin];
            [attrStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(initialLocation, isPinyin ? 1 : name.length)];

            if (searchResultLocation < 0) {
                searchResultLocation = initialLocation;
            }else{
                searchResultLocation = MIN(searchResultLocation, initialLocation);
            }
        }
    }

    return @{
             @"result":attrStr.length ? attrStr: @"",
             @"location":@(searchResultLocation),
             };
}

+ (NSInteger)pinyinSearchWithString:(NSString *)displayName searchName:(NSString *)name{
    NSArray *pinyinArr = [NSString transformToPinyin:displayName];

    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    NSMutableString *initialStr = [NSMutableString stringWithString:@""];
    for (NSString *tempStr in pinyinArr)
    {
        if (tempStr.length > 0)
        {
            [pinyin appendString:tempStr];
            [initialStr appendString:[tempStr eeo_safeSubstringToIndex:1]];
        }
    }

    NSRange displayNameRange = [displayName rangeOfString:name options:NSCaseInsensitiveSearch];
    NSRange pinyinRange = [pinyin rangeOfString:name options:NSCaseInsensitiveSearch];
    NSRange initialRange = [initialStr rangeOfString:name options:NSCaseInsensitiveSearch];

    NSInteger searchResultLocation = -1;
    if (displayNameRange.length > 0) {
        searchResultLocation = displayNameRange.location;
    }
    if (pinyinRange.length > 0) {
        if (searchResultLocation < 0) {
            searchResultLocation = pinyinRange.location;
        }else{
            searchResultLocation = MIN(searchResultLocation, pinyinRange.location);
        }
    }
    if (initialRange.length > 0) {
        if (searchResultLocation < 0) {
            searchResultLocation = initialRange.location;
        }else{
            searchResultLocation = MIN(searchResultLocation, initialRange.location);
        }
    }

    return searchResultLocation;
}

+ (NSRange)fuzzySearchWithSearchString:(NSString *)searchKeyWord
                                            originString:(NSString *)originString{
//    NSLog(@"搜索关键字  ======= %@",searchKeyWord);
//    NSLog(@"原句========= %@",originString);
    NSMutableArray *completeSpellingArray = [[NSMutableArray alloc] init];
    NSMutableArray *pinyinFirstLetterLocationMutableArray = [[NSMutableArray alloc] init];
    NSMutableArray *pinyinFirstLetterLocationArray = [[NSMutableArray alloc] init];

    NSArray *completeSpellingMutableArray = [NSString transformToPinyin:originString];

    NSMutableString *completeSpelling = [[NSMutableString alloc] init];
    NSString *initialString = @"";
    for (NSInteger i =0;i<completeSpellingMutableArray.count;i++)
    {
        NSString *pinyin = [completeSpellingMutableArray objectAtIndex:i];
        NSString *firstLetter = [pinyin eeo_safeSubstringToIndex:1];
        BOOL isPinyin = ![originString containsString:pinyin];
        if (pinyin.length > 0)
        {
            NSInteger number = 0;
            if (completeSpellingArray.count > 0) {
                number = [[completeSpellingArray lastObject] integerValue];
                number ++;
            }
            if (isPinyin) {
                [pinyinFirstLetterLocationArray addObject:@(number)];
            }

            for (NSInteger j = 0; j < pinyin.length; j++) {
                if (!isPinyin) {
                    [completeSpellingArray addObject:@(number + j)];
                    [pinyinFirstLetterLocationArray addObject:@(number + j)];
                }else
                {
                    [completeSpellingArray addObject:@(number)];
                }
            }
        }
        if (isPinyin) {
            initialString = [initialString stringByAppendingString:firstLetter];
        }else
        {
            initialString = [initialString stringByAppendingString:pinyin];
        }
        [completeSpelling appendString:pinyin];
        [pinyinFirstLetterLocationMutableArray addObject:firstLetter];
    }


    NSRange originRange = [originString rangeOfString:searchKeyWord options:(NSCaseInsensitiveSearch)];
    NSRange quanpinRange = [completeSpelling rangeOfString:searchKeyWord];
    NSRange initialRange = [initialString rangeOfString:searchKeyWord options:(NSCaseInsensitiveSearch)];
    if (originRange.length!=0) {

        return originRange;
    }

    NSRange highlightedRange = NSMakeRange(0, 0);
    if (quanpinRange.length != 0) {
        if (quanpinRange.location == 0) {
            highlightedRange = NSMakeRange(0, [completeSpellingArray[quanpinRange.length-1] integerValue] +1);
        } else {
            NSInteger currentLocation = [completeSpellingArray[quanpinRange.location] integerValue];
            NSInteger lastLocation = [completeSpellingArray[quanpinRange.location-1] integerValue];
            if (currentLocation != lastLocation) {
                highlightedRange = NSMakeRange(currentLocation, [completeSpellingArray[quanpinRange.length+quanpinRange.location -1] integerValue] - currentLocation +1);
            }
        }
        if (highlightedRange.length!=0) {
            return highlightedRange;
        }
    }

    if (initialRange.length!=0) {
        NSInteger currentLocation = [pinyinFirstLetterLocationArray[initialRange.location] integerValue];
        NSInteger highlightedLength;
        if (initialRange.location ==0) {
            highlightedLength = [pinyinFirstLetterLocationArray[initialRange.length-1] integerValue]-currentLocation +1;
            highlightedRange = NSMakeRange(0, highlightedLength);
        } else {
            highlightedLength = [pinyinFirstLetterLocationArray[initialRange.length+initialRange.location-1] integerValue]-currentLocation +1;
            highlightedRange = NSMakeRange(currentLocation, highlightedLength);
        }
        if (highlightedRange.length!=0) {
            return highlightedRange;
        }
    }
    return NSMakeRange(0, 0);
}

+(NSString *)getPublicKeyWordFromUrl:(NSString *)urlStr
{
    NSString *mark = [NSString stringWithFormat:@"%@=([0-9a-zA-Z]{9})|%@=([0-9a-zA-Z]{9})",kLessonSNFlag,kLessonSNFlagNew];
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:mark options:NSRegularExpressionCaseInsensitive error:&error];//不区分大小写。
    if (!error) {
        NSTextCheckingResult *firstMatch = [reg firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        if (firstMatch) {
            NSString *classSN = [urlStr substringWithRange:firstMatch.range];
            if(classSN.length > 9){
                return [classSN substringFromIndex:classSN.length-9];
            }else{
                return nil;
            }
        }else
        {
            return nil;
        }
    }else
    {
        return nil;
    }
}
+(NSNumber *)getOpenClassIDFromUrl:(NSString *_Nonnull)urlStr {
    NSString *mark = [NSString stringWithFormat:@"%@=([0-9]{0,20})",kOpenClassFlag];
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:mark options:NSRegularExpressionCaseInsensitive error:&error];//不区分大小写。
    if (!error) {
        NSTextCheckingResult *firstMatch = [reg firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        if (firstMatch) {
            NSString *tempStr = [urlStr substringWithRange:firstMatch.range];
            NSArray *strList = [tempStr componentsSeparatedByString:@"="];
            if(strList.count == 2){
                NSString *classIDStr = [strList lastObject];
                return @([classIDStr longLongValue]);
            }else{
                return nil;
            }
        }else
        {
            return nil;
        }
    }else
    {
        return nil;
    }
}

+(BOOL)checkPublicKeyWordFormatWithSN:(NSString *)sn{
    if (sn.length != 9) {
        return NO;
    }
    NSString *mark = [NSString stringWithFormat:@"[0-9|a|c-k|m-n|p-z]{9}"];
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:mark options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    if (!error) {
        NSArray *arrayOfAllMatches = [reg matchesInString:sn options:0 range:NSMakeRange(0, [sn length])];
        if (arrayOfAllMatches.count == 1) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

+ (void)parseAvatarURLJsonStr:(NSString *)jsonStr outOriginalURL:(NSString **)outOriginalURL outCompressionURL:(NSString **)outCompressionURL outThumbnailURL:(NSString **)outThumbnailURL {
    if(jsonStr.length <= 0){
        return;
    }

    NSDictionary *jsonDic = [NSDictionary dictionaryWithJsonString:jsonStr];
    if(jsonDic.count <= 0){
        return;
    }

    if([jsonDic.allKeys containsObject:@"CourseImg"]){
        jsonDic = jsonDic[@"CourseImg"];
    }

    NSString *path = [jsonDic[@"Path"] copy];
    if(path.length <= 0){
        return;
    }

    NSString *tempOriginalURL = [jsonDic[@"Lpic"] copy];
    if(tempOriginalURL){
        *outOriginalURL = [path stringByAppendingPathComponent:tempOriginalURL];
    }
    NSString *tempCompressionURL = [jsonDic[@"Mpic"] copy];
    if(tempCompressionURL){
        *outCompressionURL = [path stringByAppendingPathComponent:tempCompressionURL];
    }
    NSString *tempThumbnailURL = [jsonDic[@"Spic"] copy];
    if(tempThumbnailURL){
        *outThumbnailURL = [path stringByAppendingPathComponent:tempThumbnailURL];
    }
}

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken {
    NSUInteger length = deviceToken.length;
    if (length == 0) {
        return nil;
    }
    const unsigned char *buffer = deviceToken.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(length * 2)];
    for (int i = 0; i < length; ++i) {
        [hexString appendFormat:@"%02x", buffer[i]];
    }
    return [hexString copy];
}

- (NSUInteger)byteLength {
    NSUInteger result = 0;
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    result = stringData.length;
    return result;
}

+ (NSDictionary *)dictionaryWithJsonStr:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

//检测密码是否符合规则
+ (EEOCheckPasswordErrorType)checkPasswordIsLegal:(NSString *)password {
    if (password.length >= 6 && password.length <= 20) {
        //数字条件
        NSRegularExpression *numberRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        //符合数字条件的有几个字节
        NSUInteger numberMatchCount = [numberRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
        //英文字条件
        NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
        //符合英文字条件的有几个字节
        NSUInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];

        if (numberMatchCount == password.length) { //都为数字
            return EEOCheckPasswordErrorTypeOnlyNumbers;
        } else if (letterMatchCount == password.length) { //都为字母
            return EEOCheckPasswordErrorTypeOnlyLetters;
        } else if (numberMatchCount + letterMatchCount == password.length) { //字母加数字长度正好等于字符串长度说明密码是字母加数字组成
            return EEOCheckPasswordErrorTypeNone;
        } else { //其他情况
            if (numberMatchCount == 0 || letterMatchCount == 0) { //可能出现数字加符号或数字加中文这样的组合，提示必须含有数字和字母
                return EEOCheckPasswordErrorTypeNotHasNumbersAndLetters;
            } else if ([self p_checkPasswordHasSymbolWithString:password]) { //除规定符号外含有其他符号
                return EEOCheckPasswordErrorTypeInvalidSymbol;
            } else if ([self hasChinese:password]) { //含有中文
                return EEOCheckPasswordErrorTypeContainsChinese;
            } else if ([password containsString:@" "]) { //含有空格
                return EEOCheckPasswordErrorTypeContainsSpaces;
            } else { //符合
                return EEOCheckPasswordErrorTypeNone;
            }
        }
    } else {
        return EEOCheckPasswordErrorTypeLengthIsNotInRange;
    }
}

+ (BOOL)p_checkPasswordHasSymbolWithString:(NSString *)string {
    NSString *symbol = @"~`!@#$%^&*()-_+={[}]|:;'\"<,>.?/\\ ";
    for (int i = 0; i<[string length]; i++) {
        NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
        if ([self hasChinese:subStr] || [self isHasNumberAndWord:subStr]) {
            continue;
        }
        if([symbol rangeOfString:subStr].location == NSNotFound) {
            return YES;
        }
    }
    return NO;
}

//----------------以下为问题所在----------------
+(NSString *) aesEncryptString:(NSString *)content key:(NSString *)key
{
//    NSCParameterAssert(content);
//    NSCParameterAssert(key);

    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = aesEncryptData(contentData, keyData);

    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
//----------------以上为问题所在----------------

NSData * aesEncryptData(NSData *contentData, NSData *keyData) {
    return cipherOperation(contentData, keyData, kCCEncrypt);
}

NSData * cipherOperation(NSData *contentData, NSData *keyData, CCOperation operation) {
    NSUInteger dataLength = contentData.length;
    NSString * const kInitVector = @"";
    size_t const kKeySize = kCCKeySizeAES128;

    void const *initVectorBytes = [kInitVector dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;

    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;

    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          keyBytes,
                                          kKeySize,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    NSData *operationData = [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    if (cryptStatus == kCCSuccess) {
        free(operationBytes);
        return operationData;
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}

//----------------以下为问题所在----------------
+(NSString *) aesDecryptString:(NSString *)content key:(NSString *)key
{
//    NSCParameterAssert(content);
//    NSCParameterAssert(key);

    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = aesDecryptData(contentData, keyData);
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}
//----------------以上为问题所在----------------

NSData * aesDecryptData(NSData *contentData, NSData *keyData) {
    return cipherOperation(contentData, keyData, kCCDecrypt);
}

+ (NSString *)convertBinarySystemFromDecimalSystem:(NSString *)decimal
{
    NSInteger num = [decimal intValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数

    NSString * prepare = @"";

    while (true){

        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];

        if (divisor == 0){

            break;
        }
    }

    NSString * result = @"";

    for (NSInteger i = prepare.length - 1; i >= 0; i --){

        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }

    return result;
}

+ (NSString *)convertDecimalSystemFromBinarySystem:(NSString *)binary
{
    NSInteger ll = 0 ;
    NSInteger  temp = 0 ;
    for (NSInteger i = 0; i < binary.length; i ++){
        
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%ld",ll];
    
    return result;
}

// 过滤左边指定的内容
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    for (location; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
#pragma clang diagnostic pop
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

// 过滤右边指定的内容
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    for (length; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
#pragma clang diagnostic pop
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

/**
 安全的截取字符串
 */
- (NSString *)eeo_safeSubstringToIndex:(NSUInteger)index {
    if (index < 0 || index > self.length) {
        return nil;
    }
    if (index == self.length) {
        return self;
    }
    NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:index];
    NSString *newString = [self substringToIndex:range.location];
    return newString;
}

@end

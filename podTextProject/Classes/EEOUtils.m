//
//  EEOUtils.m
//  EEOCommon
//
//  Created by HeQian on 16/5/5.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOUtils.h"

#import <SystemConfiguration/CaptiveNetwork.h>

#import <sys/utsname.h>

#import <netdb.h>
#import <netinet/in.h>
#import <sys/socket.h>
#import <arpa/inet.h>

#import <sys/param.h>
#import <sys/mount.h>
#import <UIKit/UIKit.h>

#import "EEOConstants.h"

static NSString * kWebCustomUA = nil;

@implementation EEOUtils

+ (int)randomNumberWithFrom:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (NSUInteger)randomTimeIntervalWithFrom:(NSDate*)from to:(NSDate*)to {
    int fromTime = [from timeIntervalSince1970];
    int toTime = [to timeIntervalSince1970];
    int time = [EEOUtils randomNumberWithFrom:fromTime to:toTime];
    return time;
}

+ (NSString *)fetchMacAddressInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    
    NSString *result = @"";
    if(info && [[info allKeys] indexOfObject:@"BSSID"] != NSNotFound){
         result = info[@"BSSID"];
    }
    
    return result;
}

+ (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max China";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceString isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
    if ([deviceString isEqualToString:@"iPhone13,1"])   return @"iPhone 12 Mini";
    if ([deviceString isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([deviceString isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    if ([deviceString isEqualToString:@"iPod9,1"])      return @"iPod Touch (7 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,5"])     return @"iPad 6 (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,6"])     return @"iPad 6 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,11"])     return @"iPad 7 (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,12"])     return @"iPad 7 (Cellular)";
    if ([deviceString isEqualToString:@"iPad8,1"])     return @"iPad Pro 11 inch (Wifi)";
    if ([deviceString isEqualToString:@"iPad8,2"])     return @"iPad Pro 11 inch (1TB Wifi)";
    if ([deviceString isEqualToString:@"iPad8,3"])     return @"iPad Pro 11 inch (Cellular)";
    if ([deviceString isEqualToString:@"iPad8,4"])     return @"iPad Pro 11 inch (1TB Cellular)";
    if ([deviceString isEqualToString:@"iPad8,5"])     return @"iPad Pro 12.9 inch 3rd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad8,6"])     return @"iPad Pro 12.9 inch 3rd gen (1TB WiFi)";
    if ([deviceString isEqualToString:@"iPad8,7"])     return @"iPad Pro 12.9 inch 3rd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad8,8"])     return @"iPad Pro 12.9 inch 3rd gen (1TB Cellular)";
    if ([deviceString isEqualToString:@"iPad8,9"])     return @"iPad Pro 11 inch 2nd gen (WIFI)";
    if ([deviceString isEqualToString:@"iPad8,10"])     return @"iPad Pro 11 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad8,11"])     return @"iPad Pro 12.9 inch 4th gen (WIFI)";
    if ([deviceString isEqualToString:@"iPad8,12"])     return @"iPad Pro 12.9 inch 4th gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad11,1"])     return @"iPad mini 5";
    if ([deviceString isEqualToString:@"iPad11,2"])     return @"iPad mini 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad11,3"])     return @"iPad Air 3";
    if ([deviceString isEqualToString:@"iPad11,4"])     return @"iPad Air 3 (Cellular)";
    if ([deviceString isEqualToString:@"iPad11,6"])     return @"iPad 8";
    if ([deviceString isEqualToString:@"iPad11,7"])     return @"iPad 8 (Cellular)";
    if ([deviceString isEqualToString:@"iPad13,1"])     return @"iPad Air 4";
    if ([deviceString isEqualToString:@"iPad13,2"])     return @"iPad Air 4 (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    if ([deviceString isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

+ (void)getAppInfoFromAppstoreWithAppId:(NSString *)appId complete:(void (^)(NSDictionary *,NSError *))complete{
    if(appId.length <= 0){
        if (complete) {
            complete(nil,nil);
        }
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *baseUrl = @"https://itunes.apple.com";
        if ([self isInChina]) {
            baseUrl = [NSString stringWithFormat:@"%@/cn",baseUrl];
        }
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/lookup?id=%@",baseUrl,appId]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setTimeoutInterval:10];
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        //禁止使用代理
        sessionConfig.connectionProxyDictionary = @{
            @"HTTPEnable": @NO,
            @"HTTPSEnable": @NO
        };
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error && data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                if (complete) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(dict,error);
                    });
                }
            }else{
                if (complete) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(nil,error);
                    });
                }
            }
        }];
        
        [task resume];
    });
}

+ (struct hostent *)getHostByName:(const char *)hostName {
    __block struct hostent * phost = NULL;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSOperationQueue * queue = [NSOperationQueue new];
    [queue addOperationWithBlock: ^{
        phost = gethostbyname(hostName);
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC));
    [queue cancelAllOperations];
    return phost;
}
+ (NSString *)getIpv4AddressFromHost:(NSString *)host {
    const char * hostName = host.UTF8String;
    struct hostent * phost = [self getHostByName: hostName];
    if ( phost == NULL ) { return nil; }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phost->h_addr_list[0], 4);
    
    char ip[20] = { 0 };
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    return [NSString stringWithUTF8String: ip];
}
+ (NSString *)getIpv6AddressFromHost:(NSString *)host {
    const char * hostName = host.UTF8String;
    struct hostent * phost = [self getHostByName: hostName];
    if ( phost == NULL ) { return nil; }
    
    char ip[32] = { 0 };
    char ** aliases;
    switch (phost->h_addrtype) {
        case AF_INET:
        case AF_INET6: {
            for (aliases = phost->h_addr_list; *aliases != NULL; aliases++) {
                NSString * ipAddress = [NSString stringWithUTF8String: inet_ntop(phost->h_addrtype, *aliases, ip, sizeof(ip))];
                if (ipAddress) { return ipAddress; }
            }
        } break;
        default:
            break;
    }
    return nil;
}
+ (NSString *)getIpAddressFromHostName:(NSString *)host {
    NSString * ipAddress = [self getIpv4AddressFromHost: host];
    if (ipAddress == nil) {
        ipAddress = [self getIpv6AddressFromHost: host];
    }
    return ipAddress;
}

+ (float)fetchFreeDiskSpaceToMB {
    float result = 0.0;
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    result = freeSpace / 1024 / 1024;
    return result;
}

+ (EEODeviceType)getDeviceType {
    NSString *typeName = [UIDevice currentDevice].model;
    if ([typeName isEqualToString:@"iPhone"]) {
        return EEODeviceTypeIPhone;
    } else if ([typeName isEqualToString:@"iPod touch"]) {
        return EEODeviceTypeIPodTouch;
    } else if ([typeName isEqualToString:@"iPad"]) {
        return EEODeviceTypeIPad;
    } else {
        return EEODeviceTypeUnknow;
    }
}

+ (BOOL)isIPhoneXType{
    if (kISiPhone && [self systemVersionIsHigherThan:11.0]) {
        CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if(@available(iOS 11.0,*)){
            if([UIApplication sharedApplication].windows.count > 0){
                safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
            }else if ([UIApplication sharedApplication].keyWindow){
                safeAreaInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
            }
        }
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
        return iPhoneNotchDirectionSafeAreaInsets > 20;
    }else{
        return NO;
    }
}

+ (BOOL)isFullScreenDevice{
    if ([self systemVersionIsHigherThan:11.0]) {
        CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if(@available(iOS 11.0,*)){
            if([UIApplication sharedApplication].windows.count > 0){
                safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
            }else if ([UIApplication sharedApplication].keyWindow){
                safeAreaInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
            }
        }
        if (kISiPhone) {
            switch ([UIApplication sharedApplication].statusBarOrientation) {
                case UIInterfaceOrientationPortrait:{
                    iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:{
                    iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:{
                    iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:{
                    iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
                }
                    break;
                default:
                    iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                    break;
            }
        }else{
            iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
        }
        return iPhoneNotchDirectionSafeAreaInsets > 20;
    }else{
        return NO;
    }
}

+ (BOOL)systemVersionIsLowerThan:(CGFloat)version{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    if ([systemVersion floatValue] < version) {
        return YES;
    }
    return NO;
}

+ (BOOL)systemVersionIsHigherThan:(CGFloat)version{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    if ([systemVersion floatValue] >= version) {
        return YES;
    }
    return NO;
}

+ (BOOL)isInChina {
    BOOL result = NO;
    NSString * localName = [[NSTimeZone localTimeZone] name];
    //所有时区名字中属于中国的有： 重庆、哈尔滨、上海、香港、澳门、台北    @"Asia/Hong_Kong"、@"Asia/Macau"、@"Asia/Taipei"
    if([localName rangeOfString:@"Asia/Chongqing"].location == 0 || [localName rangeOfString:@"Asia/Harbin"].location == 0 || [localName rangeOfString:@"Asia/Shanghai"].location == 0 ){
        result = YES;
    }
    return result;
}

+ (NSString *)webCustomUA {
    if(kWebCustomUA.length <= 0){
        NSString *deviceType = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? @"iPhone" : @"iPad";
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        NSString *appVersion = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
        kWebCustomUA = [NSString stringWithFormat:@"%@/%@ %@/%@",deviceType,systemVersion,kWebReqUAPrefix,appVersion];
    }
    return kWebCustomUA;
}

+ (NSString *)replaceURLDomainWithWebServerAddress:(NSString *)webServerAddress urlString:(NSString *)urlString {
//    NSString *result = [urlString stringByRemovingPercentEncoding];
    NSString *result = urlString;
    NSURL *tempURL = [NSURL URLWithString:urlString];
    NSString *urlRelativePath = tempURL.relativePath;
    if(webServerAddress.length > 0 && urlRelativePath.length > 0){
        if(![urlRelativePath hasPrefix:@"/"]){
            urlRelativePath = [NSString stringWithFormat:@"/%@",urlRelativePath];
        }
        result = [webServerAddress stringByAppendingString:urlRelativePath];
        if(tempURL.query.length > 0){
            result = [NSString stringWithFormat:@"%@?%@",result,tempURL.query];
        }
    }
    return result;
}

@end

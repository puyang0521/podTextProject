//
//  NSBundle+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/4/29.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSBundle+EEO.h"
#import "EEOConstants.h"

@implementation NSBundle (EEO)

+ (NSString*)appBundleVersion {
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    return version;
}

//验证当前app为企业版还是App Store版
+ (BOOL)checkCurrentAppIsFromAppStore{
    NSString* localBundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey];
    if ([localBundleID isEqualToString:kClassInAppBundleID] && USE_LBSERVER_FLAG == 1) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEqualBundleID:(NSString *)bundleID {
    NSString *localBundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey];
    return [localBundleID isEqualToString:bundleID];
}

@end

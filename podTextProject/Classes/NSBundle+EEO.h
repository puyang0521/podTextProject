//
//  NSBundle+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/4/29.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (EEO)

+ (NSString*)appBundleVersion;
/**
 验证当前app为企业版还是App Store版
*/
+ (BOOL)checkCurrentAppIsFromAppStore;

+ (BOOL)isEqualBundleID:(NSString *)bundleID;

@end

//
//  NSFileManager+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/6/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (EEO)

+ (void)copyHtmlToTempDir;

+ (NSString *)getFileMD5WithPath:(NSString *)path;

- (void)moveOrCreateCacheDirWithOldPath1:(NSString *)oldPath1 oldPath2:(NSString *)oldPath2 finalPath:(NSString *)finalPath;

@end

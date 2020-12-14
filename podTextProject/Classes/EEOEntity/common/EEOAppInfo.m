//
//  EEOAppInfo.m
//  EEOEntity
//
//  Created by 蒋敏 on 2018/1/9.
//  Copyright © 2018年 jiangmin. All rights reserved.
//

#import "EEOAppInfo.h"

#import "EEOUtils.h"

#define MIN_FREEDISKSPACE_MB 50.0   //单位:MB

@interface EEOAppInfo (){
    float _freeDiskSpace;
    BOOL _isUploadFreeDiskSpace;
    NSMutableDictionary *_cacheDic;
}
@end

@implementation EEOAppInfo

+ (instancetype)sharedInstance {
    static EEOAppInfo *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _freeDiskSpace = 0.0f;
        _isUploadFreeDiskSpace = NO;
        _cacheDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)isNeedUploadFreeDiskSpace {
    if(!_isUploadFreeDiskSpace && [self p_freeDiskSpace] <= MIN_FREEDISKSPACE_MB){
        _isUploadFreeDiskSpace = YES;
        return YES;
    }
    return NO;
}

- (void)cacheQRCodeWithImageName:(NSString *)imageName qrcode:(NSString *)qrcode{
    if (qrcode == nil) {
        return;
    }
    @synchronized (_cacheDic) {
        if (imageName && imageName.length) {
            [_cacheDic setObject:qrcode forKey:imageName];
        }
    }
}

- (NSString *)getQRCodeWithImageName:(NSString *)imageName{
    if (!_cacheDic || !imageName) {
        return nil;
    }
    @synchronized (_cacheDic) {
        if ([_cacheDic.allKeys containsObject:imageName]) {
            return [_cacheDic objectForKey:imageName];
        }
    }
    return nil;
}

#pragma mark - Private Methods
- (float)p_freeDiskSpace {
    if(_freeDiskSpace == 0.0f){
        _freeDiskSpace = [EEOUtils fetchFreeDiskSpaceToMB];
    }
    return _freeDiskSpace;
}

@end

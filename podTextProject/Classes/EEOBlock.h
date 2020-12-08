//
//  EEOBlock.h
//  EEOCommon
//
//  Created by 蒋敏 on 2018/3/21.
//  Copyright © 2018年 jiangmin. All rights reserved.
//

#ifndef EEOBlock_h
#define EEOBlock_h

#import <Foundation/Foundation.h>

typedef void(^CSSWebRequestPassBlock)(id result);
typedef void(^CSSWebRequestNotPassBlock)(NSArray *result);
typedef void(^CSSWebRequestProgressBlock)(double progress);

typedef void(^CSSOpenWebAPIReqSuccessBlock)(id result);
typedef void(^CSSOpenWebAPIReqFailBlock)(NSUInteger failedCode);

typedef void(^CRExclusiveRightResponseBlock)(NSUInteger severaltyFlag,BOOL isSuccess);

#endif /* EEOBlock_h */

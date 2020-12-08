//
//  NSAttributedString+EEO.h
//  EEOCommon
//
//  Created by guobowen on 2020/9/25.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (EEO)

+ (NSAttributedString *)attStrWithText:(NSString *)text subText:(NSString *)subText subTextColor:(UIColor *)subTextColor;

@end

NS_ASSUME_NONNULL_END

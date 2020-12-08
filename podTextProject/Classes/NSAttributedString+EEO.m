//
//  NSAttributedString+EEO.m
//  EEOCommon
//
//  Created by guobowen on 2020/9/25.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "NSAttributedString+EEO.h"

@implementation NSAttributedString (EEO)

+ (NSAttributedString *)attStrWithText:(NSString *)text subText:(NSString *)subText subTextColor:(UIColor *)subTextColor {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange keyRang = [[text lowercaseString] rangeOfString:subText];
    [attrStr addAttribute:NSForegroundColorAttributeName value:subTextColor range:keyRang];
    return attrStr;
}

@end

//
//  NSURL+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/4/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSURL+EEO.h"

@implementation NSURL (EEO)

- (NSDictionary*)queryFromDictionary {
    NSString *urlQuery = [self query];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [urlQuery componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    return params;
}

@end

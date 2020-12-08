//
//  PYPodText.m
//  podTextProject
//
//  Created by yang.pu on 2020/12/4.
//

#import "PYPodText.h"

@implementation PYPodText
- (instancetype)init{
    if (self = [super init]) {
        NSString *temp = nil;
        if ([temp isEqualToString:@""]) {
            temp = @"123";
        }
        NSLog(@"%@",temp);
    }
    return self;
}
@end

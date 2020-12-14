//
//  EEOMessageInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOMessageInfo : NSObject<NSCopying>

@property (nonatomic,assign) NSUInteger messageId;
@property (nonatomic,assign) NSTimeInterval messageTime;
/// 外部不需要将messageContent转换成NSDictionary，直接访问messageContentDic函数即可
@property (nonatomic,copy) NSString *messageContent;

- (NSDictionary *)messageContentDic;
- (id)contentDic;

@end

//
//  NSDate+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/5/5.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR	3600
#define D_DAY	86400
#define D_WEEK	604800
#define D_YEAR	31556926

@interface NSDate (EEO)

+ (NSTimeInterval)timeIntervalSinceReferenceDateByMilliseconds;

+ (NSUInteger)eeo_yearByNow;
+ (NSUInteger)eeo_monthByNow;
+ (NSUInteger)eeo_dayByNow;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;

/**
 * 获取该月的第一天的日期
 */
+ (NSDate*)begindayOfMonthWithYear:(NSInteger)year month:(NSInteger)month;

/**
 * 获取该月的最后一天的日期
 */
+ (NSDate*)lastdayOfMonthWithYear:(NSInteger)year month:(NSInteger)month;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;
+ (NSInteger)daysInYear:(NSInteger)year month:(NSInteger)month;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)weeksOfMonth;

/**
 * 返回当前月指定周的开始日期(不是周一)
 */
- (NSDate*)dateAtStartInMonthWithWeek:(NSUInteger)week;
/**
 * 返回当前月指定周的结束日期(不是周日)
 */
- (NSDate*)dateAtEndInMonthWithWeek:(NSUInteger)week;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)weekday;
+ (NSInteger)weekdayMapping:(NSInteger)weekday;

//距离这个日期之前几天
- (NSInteger) daysAfterDate: (NSDate *) aDate;
//距离这个日期之后几天
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ymdFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;

/**
 时间戳格式化

 @param time 时间戳
 @return HH:MM:SS
 */
+ (NSString *)stringFormatWithTimeInterval:(NSTimeInterval)time;

+ (NSString *)stringFormatWithHMSTimeInterval:(NSTimeInterval)time;

/// 格式化时间戳
/// @param format 格式
/// @param time 时间戳
+ (NSString *)stringFormat:(NSString *)format withTimeInterval:(NSTimeInterval)time;

/* 是否为今年 */
- (BOOL)isThisYear;

/**
 判断是否为同一天
 */
+(BOOL)compareOneDay:(NSDate *)oneDay WithAnotherDay:(NSDate *)anotherDay;

/**
 判断是否为闰年
 */
//+ (BOOL)isLeapYear:(NSInteger)year;
/**
 上个月的date （暂定日期为15号）
 */
- (NSDate *)previousMonthDate;
/**
 下个月的date （暂定日期为15号）
 */
- (NSDate *)nextMonthDate;
/**
 下个星期的date
 */
- (NSDate *)nextWeekDate;
/**
 上个星期的date
 */
- (NSDate *)lastWeekDate;
/**
 获取该日期所在周的date数组
 */
-(NSArray *)getWeekDaysArray;
/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;
/**
 缓存NSDateFormatter，HH:mm 频繁创建非常消耗CPU
 */
+ (NSDateFormatter *)cachedDateFormatterHS;

/**
 缓存NSDateFormatter，无格式
 */
+ (NSDateFormatter *)cachedDateFormatter;

@end

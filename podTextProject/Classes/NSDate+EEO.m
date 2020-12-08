//
//  NSDate+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/5/5.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSDate+EEO.h"
#import "NSString+EEO.h"

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]

@implementation NSDate (EEO)

+ (NSTimeInterval)timeIntervalSinceReferenceDateByMilliseconds {
    return [[self class] timeIntervalSinceReferenceDate] * 1000;
}

+ (NSUInteger)eeo_yearByNow {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return [components year];
}
+ (NSUInteger)eeo_monthByNow {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    return [components month];
}
+ (NSUInteger)eeo_dayByNow {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitDay fromDate:[NSDate date]];
    return [components day];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

+ (NSDate*)begindayOfMonthWithYear:(NSInteger)year month:(NSInteger)month {
    NSDate *date = [NSDate dateWithYear:year month:month day:1];
    return [date dateAtStartOfDay];
}

+ (NSDate*)lastdayOfMonthWithYear:(NSInteger)year month:(NSInteger)month {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *beginday = [NSDate dateWithYear:year month:month day:1];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:beginday];
    NSDate *date = [NSDate dateWithYear:year month:month day:range.length];
    return [date dateAtEndOfDay];
}

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

// Date extremes
- (NSDate *) dateAtStartOfDay {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}
- (NSDate *) dateAtEndOfDay {
    NSDateComponents *components = [[NSDate currentCalendar] components:DATE_COMPONENTS fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSDate *)offsetDays:(int)numDays {
    return [NSDate offsetDays:numDays fromDate:self];
}

+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (BOOL)isLeapYear {
    return [NSDate isLeapYear:[self year]];
}

+ (BOOL)isLeapYear:(NSInteger)year {
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSUInteger)daysInMonth:(NSUInteger)month {
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

+ (NSInteger)daysInYear:(NSInteger)year month:(NSInteger)month{
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [NSDate isLeapYear:year] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [self daysInMonth:date month:[date month]];
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    return [NSDate dateAfterDate:self day:day];
}

+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)dateAfterMonth:(NSUInteger)month {
    return [NSDate dateAfterDate:self month:month];
}

+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)begindayOfMonth {
    return [NSDate begindayOfMonth:self];
}

+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[date day] + 1];
}

- (NSDate *)lastdayOfMonth {
    return [NSDate lastdayOfMonth:self];
}

+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self begindayOfMonth:date];
    return [[lastDate dateAfterMonth:1] dateAfterDay:-1];
}

- (NSUInteger)weeksOfMonth {
    return [NSDate weeksOfMonth:self];
}

- (NSDate*)dateAtStartInMonthWithWeek:(NSUInteger)week {
    NSDate *result = nil;
    NSUInteger weekNum = [self weeksOfMonth];
    if(week == 1){//取当月第一天的起始时间
        result = [[self begindayOfMonth] dateAtStartOfDay];
    }else if(week == weekNum){
        result = [[[NSDate lastdayOfMonth:self] beginningOfWeek] dateAtStartOfDay];
    }else{
        NSDate *firstWeekEndDate = [self dateAtEndInMonthWithWeek:1];
        if(week == 2){
            result = [firstWeekEndDate dateByAddingTimeInterval:1];//相差1秒
        }else{
            result = [firstWeekEndDate dateByAddingTimeInterval:1+(week-1)*D_WEEK];
        }
    }
    return result;
}
- (NSDate*)dateAtEndInMonthWithWeek:(NSUInteger)week {
    NSDate *result = nil;
    NSUInteger weekNum = [self weeksOfMonth];
    if(week == 1){
        result = [[[NSDate begindayOfMonth:self] endOfWeek] dateAtEndOfDay];
    }else if(week == weekNum){//取当月最后一天的结束时间
        result = [[self lastdayOfMonth] dateAtEndOfDay];
    }else{
        result = [[self dateAtStartInMonthWithWeek:week] dateByAddingTimeInterval:D_WEEK-1];
    }
    return result;
}

- (NSDate *)beginningOfWeek {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];
    
    return [calendar dateFromComponents:components];
}
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self beginningOfWeek] options:0] dateByAddingTimeInterval:-1];
}

- (NSInteger)weekday {
    return [NSDate weekday:self];
}

+ (NSInteger)weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
//    return [NSDate weekdayMapping:weekday];
}

+ (NSInteger)weekdayMapping:(NSInteger)weekday {
    NSDictionary *mapping = @{@"1":@(7),
                              @"2":@(1),
                              @"3":@(2),
                              @"4":@(3),
                              @"5":@(4),
                              @"6":@(5),
                              @"7":@(6)};
    return [mapping[@(weekday).stringValue] integerValue];
}

+ (NSUInteger)weeksOfMonth:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    [calendar setFirstWeekday:2];//星期一
    NSUInteger weekNum = [calendar ordinalityOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return weekNum;
}

- (NSInteger) daysAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ceil(ti / D_DAY));
}
- (NSInteger) daysBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ceil(ti / D_DAY));
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [NSDate cachedDateFormatter];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

- (NSString *)ymdFormat {
    return [NSDate ymdFormat];
}
- (NSString *)hmsFormat {
    return [NSDate hmsFormat];
}
- (NSString *)ymdHmsFormat {
    return [NSDate ymdHmsFormat];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}
+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}
+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

+ (NSString *)stringFormatWithTimeInterval:(NSTimeInterval)time{
    
    NSUInteger hours = ((int)time)/3600;
    
    NSUInteger minutes = ((int)time)%(3600*24)%3600/60;
    
    NSUInteger seconds = ((int)time)%(3600*24)%3600%60;
    
    NSString *day = @"";
    
    if (hours > 0 && hours < 10) {
        day = [NSString stringWithFormat:@"0%lu:",hours];
    }
    
    if (hours >= 10) {
        day = [NSString stringWithFormat:@"%lu:",hours];
    }
    
    if (minutes < 10) {
        day = [day stringByAppendingFormat:@"0%lu:",minutes];
    }else{
        day = [day stringByAppendingFormat:@"%lu:",minutes];
    }
    
    if (seconds < 10) {
        day = [day stringByAppendingFormat:@"0%lu",seconds];
    }else{
        day = [day stringByAppendingFormat:@"%lu",seconds];
    }
    
    return day;
}

+ (NSString *)stringFormatWithHMSTimeInterval:(NSTimeInterval)time{
    
    NSUInteger hours = ((int)time)/3600;
    
    NSUInteger minutes = ((int)time)%(3600*24)%3600/60;
    
    NSUInteger seconds = ((int)time)%(3600*24)%3600%60;
    
    NSString *day = @"";
    
    if (hours < 10) {
        day = [NSString stringWithFormat:@"0%lu:",hours];
    }
    
    if (hours >= 10) {
        day = [NSString stringWithFormat:@"%lu:",hours];
    }
    
    if (minutes < 10) {
        day = [day stringByAppendingFormat:@"0%lu:",minutes];
    }else{
        day = [day stringByAppendingFormat:@"%lu:",minutes];
    }
    
    if (seconds < 10) {
        day = [day stringByAppendingFormat:@"0%lu",seconds];
    }else{
        day = [day stringByAppendingFormat:@"%lu",seconds];
    }
    
    return day;
}

+ (NSString *)stringFormat:(NSString *)format withTimeInterval:(NSTimeInterval)time{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    NSString *string = [dateFormat stringFromDate:confromTimesp];
    return string;
}

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

+(BOOL)compareOneDay:(NSDate *)oneDay WithAnotherDay:(NSDate *)anotherDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    
    NSDateComponents *oneDaycoms = [calendar components :unit fromDate :oneDay];
    NSDateComponents *anotherDaycoms = [calendar components :unit fromDate :anotherDay];
    return (oneDaycoms.year == anotherDaycoms.year)&&(oneDaycoms.month == anotherDaycoms.month)&&(oneDaycoms.day == anotherDaycoms.day);
}

- (NSDate *)previousMonthDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
    } else {
        components.month -= 1;
    }
    
    NSDate *previousDate = [calendar dateFromComponents:components];
    
    return previousDate;
}

- (NSDate *)nextMonthDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
    } else {
        components.month += 1;
    }
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    return nextDate;
}

-(NSDate *)nextWeekDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day += 7;
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    return nextDate;
}

-(NSDate *)lastWeekDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day -= 7;
    
    NSDate *lastDate = [calendar dateFromComponents:components];
    return lastDate;
}

-(NSArray *)getWeekDaysArray{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:self];
    NSInteger weekday = [components weekday];//周几   0 表示周日
    NSMutableArray *weekdays = [[NSMutableArray alloc] init];
    //本周的起始日期周日
    for (NSInteger i = weekday-1 ; i > 0; i--) {
        NSDateComponents *componentsCopy = [components copy];
        componentsCopy.day -= i;
        [weekdays addObject:[calendar dateFromComponents:componentsCopy]];
    }
    [weekdays addObject:[calendar dateFromComponents:components]];
    for (int i = 1; i < 7 - (weekday-1); i ++) {
        NSDateComponents *componentsCopy = [components copy];
        componentsCopy.day += i;
        [weekdays addObject:[calendar dateFromComponents:componentsCopy]];
    }
    return weekdays;
}
- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}

+ (NSDateFormatter *)cachedDateFormatterHS{
    static NSDateFormatter *cachedDateFormatterHS = nil;
    
    if (!cachedDateFormatterHS) {
        cachedDateFormatterHS = [[NSDateFormatter alloc] init];
        [cachedDateFormatterHS setDateFormat:@"HH:mm"];
    }
    
    return cachedDateFormatterHS;
    
}

+ (NSDateFormatter *)cachedDateFormatter{
    static NSDateFormatter *cachedDateFormatter = nil;
    if (!cachedDateFormatter) {
        cachedDateFormatter = [[NSDateFormatter alloc] init];
    }
    return cachedDateFormatter;
}

@end

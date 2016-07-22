//
//  NSDate+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "NSDate+ShortCut.h"

@implementation NSDate (ShortCut)
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self] year];
}
- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self] month];
}
- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self] day];
}
- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self] hour];
}
- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self] minute];
}
- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self] second];
}
- (NSInteger)week
{
    return [[[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self] week];
}
- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self] weekday];
}
- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayOrdinalCalendarUnit fromDate:self] weekdayOrdinal];
}
- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSWeekOfMonthCalendarUnit fromDate:self] weekOfMonth];
}
- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSWeekOfYearCalendarUnit fromDate:self] weekOfYear];
}
- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSYearForWeekOfYearCalendarUnit fromDate:self] yearForWeekOfYear];
}
- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSQuarterCalendarUnit fromDate:self] quarter];
}

- (NSString *)ShortCutStringWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString * str = nil;
    if (!dateFormatter)
    {
        NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
        [dateFormatterDefault setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatterDefault stringFromDate:self];
        str = [dateFormatter stringFromDate:self];
    }
    return str;
}

-(NSString *)ShortCutStringWithStrFormatter:(NSString *)strFormatter
{
    NSString * str = nil;
    if (!strFormatter)
    {
        strFormatter =@"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
    [dateFormatterDefault setDateFormat:strFormatter];
    str = [dateFormatterDefault stringFromDate:self];
    return str;
}

-(NSString *)ShortCutStringWithDateStyle:(NSDateFormatterStyle)dateStyle TimeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}


+(NSDate *)ShortCutDateWithString:(NSString *)dateStr DateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length)
    {
        return nil;
    }
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    date = [dateFormatter dateFromString:dateStr];
    return date;
}

+(NSDate *)ShortCutDateWithString:(NSString *)dateStr StrFormatter:(NSString *)strFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length) {
        return nil;
    }
    
    if (!strFormatter.length ||!strFormatter)
    {
        strFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:strFormatter];
    date = [[self class] ShortCutDateWithString:dateStr DateFormatter:dateFormatter];
    return date;
}

+(NSDate *)ShortCutDateWithSince1970TimeMS:(long long)timeMSForSince1970
{
    return [NSDate dateWithTimeIntervalSince1970:timeMSForSince1970/1000];
}


+(NSString *)formatDateFromString:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}



+(NSString *)currentDateFromString
{
    NSDate *date=[NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"ddHHmm"];
    NSString *str = [outputFormatter stringFromDate:date];
    return str;
}

@end

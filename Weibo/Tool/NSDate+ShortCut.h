//
//  NSDate+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ShortCut)
@property (nonatomic,readonly) NSInteger year;//年
@property (nonatomic,readonly) NSInteger month;//月
@property (nonatomic,readonly) NSInteger day;//日
@property (nonatomic,readonly) NSInteger hour;//时
@property (nonatomic,readonly) NSInteger minute;//分
@property (nonatomic,readonly) NSInteger second;//秒
@property (nonatomic,readonly) NSInteger week;//周
@property (nonatomic,readonly) NSInteger weekday;//工作日
@property (nonatomic,readonly) NSInteger weekdayOrdinal;//工作日序数
@property (nonatomic,readonly) NSInteger weekOfMonth;//月的周数
@property (nonatomic,readonly) NSInteger weekOfYear;//年的周数
@property (nonatomic,readonly) NSInteger yearForWeekOfYear;
@property (nonatomic,readonly) NSInteger quarter;//季度


/**
 *  根据dateFormatter得到时间字符串
 *
 *  @param dateFormatter dateFormatter
 *
 *  @return
 */
- (NSString *)ShortCutStringWithDateFormatter:(NSDateFormatter *)dateFormatter;


/**
 *  根据strFormatter得到时间字符串
 *
 *  @param strFormatter strFormatter
 *
 *  @return
 */
- (NSString *)ShortCutStringWithStrFormatter:(NSString *)strFormatter;



/**
 *  根据日期和时间格式,返回时间字符串
 *
 *  @param dateStyle dateStyle
 *  @param timeStyle timeStyle
 *
 *  @return
 */
- (NSString *)ShortCutStringWithDateStyle:(NSDateFormatterStyle)dateStyle TimeStyle:(NSDateFormatterStyle)timeStyle;


/**
 *  生成时间
 *
 *  @param dateStr       dateStr
 *  @param dateFormatter dateFormatter
 *
 *  @return
 */
+ (NSDate *)ShortCutDateWithString:(NSString *)dateStr DateFormatter:(NSDateFormatter *)dateFormatter;


/**
 *  生成时间
 *
 *  @param dateStr      dateStr
 *  @param strFormatter strFormatter
 *
 *  @return
 */
+ (NSDate *)ShortCutDateWithString:(NSString *)dateStr StrFormatter:(NSString *)strFormatter;



/**
 *  根据毫秒级时间戳得到时间
 *
 *  @param timeMSForSince1970 timeMSForSince1970
 *
 *  @return
 */
+ (NSDate *)ShortCutDateWithSince1970TimeMS:(long long int)timeMSForSince1970;




/**
 *  字符串专程NSdate（特殊处理）
 *
 *  @param string 字符串
 *
 *  @return
 */
+(NSString *)formatDateFromString:(NSString *)string;


/**
 *  返回当前时间的字符串(ddhhmm)
 *
 *  @return
 */
+(NSString *)currentDateFromString;
@end

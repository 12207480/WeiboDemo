//
//  WBParser.h
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBParser : NSObject



/**
 *  处理字符串中关键字@
 *
 *  @param string 内容
 *
 *  @return   所有的@某人的range数组
 */
+ (NSArray *)keywordRangesOfAtPersonInString:(NSString *)string;




/**
 *  处理字符串中的表情格式
 *
 *  @param string 内容
 *
 *  @return   表情的range以及去除表情之后的字符串
 */
+ (NSArray *)keywordRangesOfEmotionInString:(NSString *)string;




/**
 *  处理字符串中的网址
 *
 *  @param string 内容
 *
 *  @return 网址替换以及网址替换后的字符串
 */
+ (NSArray *)keywordRangesOfURLInString:(NSString *)string;



/**
 *  处理字符串中话题的格式
 *
 *  @param string 内容
 *
 *  @return   所有#话题的range数组
 */
+ (NSArray *)keywordRangesOfSharpTrendInString:(NSString *)string;

@end

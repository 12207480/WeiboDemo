//
//  WBParser.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBParser.h"


static NSString *atRegular = @"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}";//at的正则表达式
static NSString *sharpRegular = @"#[^#]+#";//话题的正则表达式
static NSString *iconRegular =  @"(\\[\\w+\\])";//图片的正则表达式
static NSString *urlRegular=@"(http|https)://(t.cn/|weibo.com/|m.weibo.cn/)+(([a-zA-Z0-9/])*)";//网址的正则表达式


@implementation WBParser


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSArray *)keywordRangesOfAtPersonInString:(NSString *)string
{
    NSArray* matches = [self matcheInString:string regularExpressionWithPattern:atRegular];
    NSMutableArray *array = [NSMutableArray array];
    for(NSTextCheckingResult* match in matches)
    {
        WBKeywordModel *keywordModel=[[WBKeywordModel alloc]init];
        keywordModel.keyword=[self replacementStringForResult:match inString:string regularExpressionWithPattern:atRegular];
        keywordModel.range=[match range];
        keywordModel.url=[NSString stringWithFormat:@"%@%@",PROTOCOL_AT_SOMEONE,keywordModel.keyword];
        [array addObject:keywordModel];
    }
    return array;
}

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSArray *)keywordRangesOfEmotionInString:(NSString *)string
{
    NSArray* matches = [self matcheInString:string regularExpressionWithPattern:iconRegular];
    NSMutableArray *array = [NSMutableArray array];
    for(NSTextCheckingResult* match in matches)
    {
        WBKeywordModel *keywordModel=[[WBKeywordModel alloc]init];
        NSString *keyword = [self replacementStringForResult:match inString:string regularExpressionWithPattern:iconRegular];
        keywordModel.type = 1;
        keywordModel.keyword=keyword;
        keywordModel.range=[match range];
        keywordModel.url = [WBEmotionManage pathForEmotionCode:keyword];
        if (keywordModel.url!=nil)
        {
            [array addObject:keywordModel];
        }
    }
    return array;
}


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSArray *)keywordRangesOfURLInString:(NSString *)string
{
    NSArray* matches = [self matcheInString:string regularExpressionWithPattern:urlRegular];
    NSMutableArray *array = [NSMutableArray array];
    for(NSTextCheckingResult* match in matches)
    {
        WBKeywordModel *keywordModel=[[WBKeywordModel alloc]init];
        NSString *keyword =[self replacementStringForResult:match inString:string regularExpressionWithPattern:urlRegular];
        keywordModel.type = 2;
        keywordModel.keyword=keyword;
        keywordModel.range=[match range];
        keywordModel.url =keyword;//@"网页";
        [array addObject:keywordModel];
    }
    return array;
}


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+ (NSArray *)keywordRangesOfSharpTrendInString:(NSString *)string
{
    NSArray* matches = [self matcheInString:string regularExpressionWithPattern:sharpRegular];
    NSMutableArray *array = [NSMutableArray array];
    for(NSTextCheckingResult* match in matches)
    {
        WBKeywordModel *keywordModel=[[WBKeywordModel alloc]init];
        NSString *keyword =[self replacementStringForResult:match inString:string regularExpressionWithPattern:sharpRegular];
        keywordModel.keyword=keyword;
        keywordModel.range=[match range];
        keywordModel.url =[NSString stringWithFormat:@"%@%@",PROTOCOL_SHARP_TREND,keywordModel.keyword];
        [array addObject:keywordModel];
    }
    return array;
}


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSArray *)matcheInString:(NSString *)string regularExpressionWithPattern:(NSString *)regularExpressionWithPattern
{
    NSError *error;
    NSRange range = NSMakeRange(0,[string length]);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpressionWithPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray* matches = [regex matchesInString:string options:0 range:range];
    return matches;
}


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSString *)replacementStringForResult:(NSTextCheckingResult *)result inString:(NSString *)string regularExpressionWithPattern:(NSString *)regularExpressionWithPattern
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpressionWithPattern options:NSRegularExpressionCaseInsensitive error:&error];
    return   [regex replacementStringForResult:result inString:string offset:0 template:@"$0"];
}
@end

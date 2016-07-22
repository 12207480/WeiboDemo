//
//  WBEmotionManage.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBEmotionManage.h"

/**
 *  emotion(静态存放以免每次都去计算pilist)
 */
static NSArray* emotionsArray = nil;

@implementation WBEmotionManage

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSArray *)emotionsArray
{
    if (!emotionsArray)
    {
        //到plist里面遍历表情,添加到数组
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
        NSMutableArray *emoticons = [NSMutableArray arrayWithCapacity:array.count];
        WBEmotionsModel  *emotionsModel;
        for (NSDictionary *dic in array)
        {
            emotionsModel = [[WBEmotionsModel alloc]initWithDictionary:dic];
            emotionsModel.emoticon_group_emotionsArray=[WBEmotionManage emotionsArray:emotionsModel];
            [emoticons addObject:emotionsModel];
        }
        emotionsArray=emoticons;
    }
    return emotionsArray;
}


#pragma Emoji数组
+(NSArray *)emotionsArray:(WBEmotionsModel *)emotionsModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:emotionsModel.emoticon_group_path ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *array= [dictionary objectForKey:@"emoticons"];
    NSMutableArray *muarray = [NSMutableArray arrayWithCapacity:array.count];
    
    
    for (NSDictionary *dic in array)
    {
        WBLocalEmotionModel*localEmotionEntity=[[WBLocalEmotionModel alloc]initWithDictionary:dic];
        [muarray addObject:localEmotionEntity];
    }
    return muarray;
}


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
+(NSString *)pathForEmotionCode:(NSString *)code
{
    //比对传入字符是否是在表情中,传出表情的名称
    for (WBEmotionsModel *emotionsModel in [WBEmotionManage emotionsArray])
    {
        for (WBLocalEmotionModel* e in emotionsModel.emoticon_group_emotionsArray)
        {
            if ([e.chs isEqualToString:code]||[e.cht isEqualToString:code])
            {
                return e.urlPath;
            }
        }
    }
    return nil;
}
@end

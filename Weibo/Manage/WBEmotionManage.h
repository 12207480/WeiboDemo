//
//  WBEmotionManage.h
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotionManage : NSObject


/**
 *  表情数组
 *
 *  @return  表情数组
 */
+ (NSArray* )emotionsArray;



/**
 *  检索是否是表情
 *
 *  @param code 编码
 *
 *  @return  图片的URL 或者nil
 */
+ (NSString*)pathForEmotionCode:(NSString*)code;

@end

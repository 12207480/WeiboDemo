//
//  WBUrlShortModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  短链（url_short）
 */
@interface WBUrlShortModel : NSObject
@property(copy,nonatomic)NSString *url_short;//短链接
@property(copy,nonatomic)NSString *url_long;//原始长链接
@property(assign,nonatomic)NSInteger type;//链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
@property(assign,nonatomic)BOOL  result;//短链的可用状态，true：可用、false：不可用
-(instancetype)initWithJsonDictionary:(NSDictionary *)dic;
@end

//
//  WBDataModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBDataModel :NSObject

@property(strong,nonatomic)NSMutableArray *statuses;//微博内容信息
@property(strong,nonatomic)NSMutableArray *ad;//微博流内的推广微博ID
@property(assign,nonatomic)NSInteger total_number;//总的条数
-(instancetype)initWithJsonDictionary:(NSDictionary *)dic;
@end



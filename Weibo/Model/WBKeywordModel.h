//
//  WBKeywordModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBKeywordModel : NSObject
@property (nonatomic,assign) NSInteger type;//1图片 2链接
@property (nonatomic,copy)NSString  *keyword;//名称
@property(nonatomic,copy)NSString    *url;//地址
@property (nonatomic,assign)NSRange range;//位置
@end

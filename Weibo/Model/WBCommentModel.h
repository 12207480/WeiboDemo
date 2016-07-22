//
//  WBCommentModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  评论（comment）
 */
@interface WBCommentModel: NSObject
@property(copy,nonatomic)NSString *created_at;//评论创建时间
@property(copy,nonatomic)NSString * text;//评论的内容
@property(copy,nonatomic)NSString *source;//评论的来源
@property(strong,nonatomic)id user;//评论作者的用户信息字段
@property(copy,nonatomic)NSString *mid;//评论的MID
@property(copy,nonatomic)NSString *idstr;//字符串型的评论ID
@property(strong,nonatomic)id status;//评论的微博信息字段
@property(strong,nonatomic)id reply_comment;//评论来源评论，当本评论属于对另一评论的回复时返回此字段
-(instancetype)initWithJsonDictionary:(NSDictionary *)dic;
@end

//
//  WBEmotionsModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotionsModel : NSObject
@property (copy,nonatomic  ) NSString *emoticon_group_name;//表情分组名称
@property (copy,nonatomic  ) NSString *emoticon_group_identifier;//表情分组ID
@property (copy,nonatomic  ) NSString *emoticon_group_type;//表情分组类型
@property (copy,nonatomic  ) NSString *emoticon_group_path;//表情分组路径
@property (strong,nonatomic) NSArray  *emoticon_group_emotionsArray;//具体表情数组(自定义)
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

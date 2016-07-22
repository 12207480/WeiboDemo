//
//  WBLocalEmotionModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBLocalEmotionModel.h"

@implementation WBLocalEmotionModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_String_Key(dic,self.chs,@"chs");
        WSet_Dic_String_Key(dic,self.cht,@"cht");
        WSet_Dic_String_Key(dic,self.urlPath,@"png");
    }
    return self;
}
@end

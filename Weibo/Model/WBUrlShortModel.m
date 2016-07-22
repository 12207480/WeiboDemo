//
//  WBUrlShortModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBUrlShortModel.h"

@implementation WBUrlShortModel

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_String_Key(dic,self.url_short,@"url_short");
        WSet_Dic_String_Key(dic,self.url_long,@"url_long");
        WSet_Dic_Int_Key(dic,self.type,@"type");
        WSet_Dic_Bool_Key(dic,self.result,@"result");
    }
    return self;
}
@end

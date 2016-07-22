//
//  WBGeoModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBGeoModel.h"

@implementation WBGeoModel
-(instancetype)initWithJsonDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_String_Key(dic,self.longitude,@"longitude");
        WSet_Dic_String_Key(dic,self.latitude,@"latitude");
        WSet_Dic_String_Key(dic,self.city,@"city");
        WSet_Dic_String_Key(dic,self.province,@"province");
        WSet_Dic_String_Key(dic,self.city_name,@"city_name");
        WSet_Dic_String_Key(dic,self.province_name,@"province_name");
        WSet_Dic_String_Key(dic,self.address,@"address");
        WSet_Dic_String_Key(dic,self.pinyin,@"pinyin");
        WSet_Dic_String_Key(dic,self.more,@"more");
    }
    return self;
}
@end

//
//  WBDataModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBDataModel.h"

@implementation WBDataModel

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_Obj_Key(dic,self.statuses,@"statuses");
        WSet_Dic_Obj_Key(dic,self.ad,@"ad");
        WSet_Dic_Int_Key(dic,self.total_number,@"total_number");
    }
    return self;
}

@end

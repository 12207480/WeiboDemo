//
//  WBEmotionsModel
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBEmotionsModel.h"

@implementation WBEmotionsModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {

        WSet_Dic_String_Key(dic,self.emoticon_group_name,@"emoticon_group_name");
        WSet_Dic_String_Key(dic,self.emoticon_group_identifier,@"emoticon_group_identifier");
        WSet_Dic_String_Key(dic,self.emoticon_group_type,@"emoticon_group_type");
        WSet_Dic_String_Key(dic,self.emoticon_group_path,@"emoticon_group_path");
    }
    return self;
}
@end

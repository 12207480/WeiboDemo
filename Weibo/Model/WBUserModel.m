//
//  WBUserModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBUserModel.h"
#import "NSString+Size.h"

@implementation WBUserModel

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_String_Key(dic,self.idstr,@"idstr");
        WSet_Dic_String_Key(dic,self.name,@"name");
        WSet_Dic_Int_Key(dic,self.province,@"province");
        WSet_Dic_Int_Key(dic,self.city,@"city");
        WSet_Dic_String_Key(dic,self.location,@"location");
        WSet_Dic_String_Key(dic,self.descriptionn,@"description");
        WSet_Dic_String_Key(dic,self.url,@"url");
        WSet_Dic_String_Key(dic,self.profile_image_url,@"profile_image_url");
        WSet_Dic_String_Key(dic,self.profile_url,@"profile_url");
        WSet_Dic_String_Key(dic,self.domain,@"domain");
        WSet_Dic_String_Key(dic,self.weihao,@"weihao");
        WSet_Dic_String_Key(dic,self.gender,@"gender");
        WSet_Dic_Int_Key(dic,self.followers_count,@"followers_count");
        WSet_Dic_Int_Key(dic,self.friends_count,@"friends_count");
        WSet_Dic_Int_Key(dic,self.statuses_count,@"statuses_count");
        WSet_Dic_Int_Key(dic,self.favourites_count,@"favourites_count");
        WSet_Dic_String_Key(dic,self.created_at,@"created_at");
        WSet_Dic_Bool_Key(dic,self.allow_all_act_msg,@"allow_all_act_msg");
        WSet_Dic_Bool_Key(dic,self.geo_enabled,@"geo_enabled");
        WSet_Dic_Bool_Key(dic,self.verified,@"verified");
        WSet_Dic_Int_Key(dic,self.verified_type,@"verified_type");
        WSet_Dic_String_Key(dic,self.remark,@"remark");
        WSet_Dic_Obj_Key(dic,self.status,@"status");
        WSet_Dic_Bool_Key(dic,self.allow_all_comment,@"allow_all_comment");
        WSet_Dic_String_Key(dic,self.avatar_large,@"avatar_large");
        WSet_Dic_String_Key(dic,self.avatar_hd,@"avatar_hd");
        WSet_Dic_String_Key(dic,self.verified_reason,@"verified_reason");
        WSet_Dic_Bool_Key(dic,self.follow_me,@"follow_me");
        WSet_Dic_Int_Key(dic,self.online_status,@"online_status");
        WSet_Dic_Int_Key(dic,self.bi_followers_count,@"bi_followers_count");
        WSet_Dic_String_Key(dic,self.lang,@"lang");
        _nameWidth = [_name textSizeWithFont:TITLE_FONT_SIZE constrainedToSize:CGSizeMake(200, TITLE_FONT_SIZE.lineHeight)].width;
    }
    return self;
}

-(void)setVerified_type:(NSInteger)verified_type
{
    switch (verified_type)
    {
        case -1:
        {
            self.verifiedImageUrl=@"";
        }
        break;
        case 0:
        {
            self.verifiedImageUrl=@"avatar_vip";
        }
        break;
            case 10:
        {
            self.verifiedImageUrl=@"avatar_vgirl";
        }
            break;
        case 200:
        {
            self.verifiedImageUrl=@"avatar_grassroot";
        }
        break;
            default:
        {
            self.verifiedImageUrl=@"avatar_enterprise_vip";
        }
        break;
    }
    _verifiedImage = [UIImage imageNamed:self.verifiedImageUrl];
    _verified_type=verified_type;
}
@end

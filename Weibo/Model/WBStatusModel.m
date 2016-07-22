//
//  WBStatusModel.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBStatusModel.h"
#import "NSString+Size.h"

@implementation WBStatusModel

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic
{
    self=[super init];
    if (self)
    {
        WSet_Dic_String_Key(dic,self.created_at,@"created_at");
        WSet_Dic_Int_Key(dic,self.mid,@"mid");
        WSet_Dic_String_Key(dic,self.idstr,@"idstr");
        WSet_Dic_String_Key(dic,self.text,@"text");
        WSet_Dic_String_Key(dic,self.source,@"source");
        WSet_Dic_Bool_Key(dic,self.favorited,@"favorited");
        WSet_Dic_Bool_Key(dic,self.truncated,@"truncated");
        WSet_Dic_String_Key(dic,self.thumbnail_pic,@"thumbnail_pic");
        WSet_Dic_String_Key(dic,self.bmiddle_pic,@"bmiddle_pic");
        WSet_Dic_String_Key(dic,self.original_pic,@"original_pic");
        WSet_Dic_Obj_Key(dic,self.geo,@"geo");
        WSet_Dic_Obj_Key(dic,self.user,@"user");
        WSet_Dic_Obj_Key(dic,self.retweeted_status,@"retweeted_status");
        WSet_Dic_Int_Key(dic,self.reposts_count,@"reposts_count");
        WSet_Dic_Int_Key(dic,self.comments_count,@"comments_count");
        WSet_Dic_Int_Key(dic,self.attitudes_count,@"attitudes_count");
        WSet_Dic_Int_Key(dic,self.mlevel,@"mlevel");
        WSet_Dic_Obj_Key(dic,self.visible,@"visible");
        WSet_Dic_Obj_Key(dic,self.pic_urls,@"pic_urls");
        _sourceWidth = [_source textSizeWithFont:SUBTITLE_FONT_SIZE constrainedToSize:CGSizeMake(200, SUBTITLE_FONT_SIZE.lineHeight)].width;
        [self formatProcessing];
    }
    return self;
}

-(void)formatProcessing
{
    [self parsingPic_urls];
}

-(void)parsingPic_urls
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    
    if (self.pic_urls.count<=0)
    {
        if (self.bmiddle_pic.length>0)
        {
            [array addObject:self.bmiddle_pic];
        }
    }
    else
    {
        for (NSInteger i=0;i<self.pic_urls.count;++i)
        {
            NSString *urlStr=[[self.pic_urls objectAtIndex:i] objectForKey:@"thumbnail_pic"];
            [array addObject:urlStr];
        }
    }
    self.pic_urls=array;
}

@end

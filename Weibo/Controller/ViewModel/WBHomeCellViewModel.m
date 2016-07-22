//
//  WBHomeCellViewModel.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBHomeCellViewModel.h"
#import "WBContentImageView.h"
#import "WBButton.h"
#import "TYTextContainer.h"
#import "UIImage+ShortCut.h"
#import "NSString+Size.h"

@implementation WBHomeCellViewModel

-(void)setStatusModel:(WBStatusModel *)statusModel
{
    _statusModel=statusModel;
    [self handle];
}


#pragma 处理
-(void)handle
{
    [self setMlevelImageUrl];
    [self setCreated_at];
    [self setSource];
    [self parseAllKeywords];
    [self calculateContentImageViewHegiht];
    [self calculateHegihtAndAttributedString];
}


#pragma 默认全部未VIP,官方VIP等级还未开放
-(void)setMlevelImageUrl
{
    switch (6)
    {
        case 0:
        {
            self.mlevelImageUrl=@"";
        }
            break;
        case 1:
        {
            self.mlevelImageUrl=@"common_icon_membership_level1";
        }
            break;
        case 2:
        {
            self.mlevelImageUrl=@"common_icon_membership_level2";
        }
            break;
        case 3:
        {
            self.mlevelImageUrl=@"common_icon_membership_level3";
        }
            break;
        case 4:
        {
            self.mlevelImageUrl=@"common_icon_membership_level4";
        }
            break;
        case 5:
        {
            self.mlevelImageUrl=@"common_icon_membership_level5";
        }
            break;
        case 6:
        {
            self.mlevelImageUrl=@"common_icon_membership";
        }
            break;
        default:
        {
            self.mlevelImageUrl=@"";
        }
            break;
    }
}


#pragma 按照Sina微博的时间方式展示
-(void)setCreated_at
{
    NSString *createdDate=[NSDate formatDateFromString:self.statusModel.created_at];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:createdDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        if ([timeString isEqualToString:@"0"])
        {
            timeString = @"刚刚";
        }
        else
        {
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    if (cha/3600>1&&cha/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    _timestamp=timeString;
    _timestampWidth = [timeString textSizeWithFont:SUBTITLE_FONT_SIZE constrainedToSize:CGSizeMake(200, SUBTITLE_FONT_SIZE.lineHeight)].width;
}


#pragma <a href="http://app.weibo.com/t/feed/40zIsF" rel="nofollow">谈微博</a>
-(void)setSource
{
    if (![self.statusModel.source isEqualToString:@""])
    {
        NSRange range1 = [self.statusModel.source rangeOfString:@"\">"];
        NSRange range2 = [self.statusModel.source rangeOfString:@"/a>"];
        NSRange sourceRange = NSMakeRange(range1.location + range1.length,
                                          range2.location - (range1.location + range1.length) - 1);
        self.statusModel.source = [self.statusModel.source substringWithRange:sourceRange];
    }
}

#pragma 解析关键词
- (void)parseAllKeywords
{
    if (self.statusModel.text.length>0)
    {
        self.atPersonArray=[WBParser keywordRangesOfAtPersonInString:self.statusModel.text];
        self.emotionArray=[WBParser keywordRangesOfEmotionInString:self.statusModel.text];
        self.urlArray=[WBParser keywordRangesOfURLInString:self.statusModel.text];
        self.topicArray=[WBParser keywordRangesOfSharpTrendInString:self.statusModel.text];
    }
}


#pragma 计算高度
-(void)calculateHegihtAndAttributedString
{
    TYTextContainer * textContainer=[[TYTextContainer alloc]init];
    textContainer.characterSpacing = 0;
    textContainer.linesSpacing=2;
    textContainer.lineBreakMode = kCTLineBreakByWordWrapping;
    textContainer.font = [UIFont systemFontOfSize:17];
    textContainer.text=self.statusModel.text;
    
    //表情
    for (NSInteger i=0;i<self.emotionArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.emotionArray objectAtIndex:i];
        
        TYImageStorage *imageStorage=[[TYImageStorage alloc]init];
        //imageStorage.imageName = keywordModel.url;
        //谨慎缓存image，会增长内存
        imageStorage.image=[[UIImage imageNamed:keywordModel.url] imageScaledToSize:CGSizeMake(19,19)];
        imageStorage.range=keywordModel.range;
        imageStorage.size=CGSizeMake(19,19);
        
        [textContainer addTextStorage:imageStorage];
    }
    
    
    //url链接
    for (NSInteger i=0;i<self.urlArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.urlArray objectAtIndex:i];
        
        TYLinkTextStorage *linkTextStorage=[[TYLinkTextStorage alloc]init];
        linkTextStorage.range=keywordModel.range;
        linkTextStorage.text=nil;
        linkTextStorage.linkData=keywordModel.url;
        linkTextStorage.underLineStyle=kCTUnderlineStyleNone;
        [textContainer addTextStorage:linkTextStorage];

//        WBButton *btnUrl=[WBButton buttonWithType:UIButtonTypeCustom];
//        btnUrl.backgroundColor=[UIColor redColor];
//        [btnUrl setTitle:keywordModel.url forState:UIControlStateNormal];
//        [btnUrl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnUrl setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
//        btnUrl.titleLabel.font=[UIFont systemFontOfSize:14.0];
//        btnUrl.frame=CGRectMake(0,0,44,18);
//        btnUrl.userInteractionEnabled=NO;
//        btnUrl.content=keywordModel.keyword;
//        
//        TYViewStorage *viewStorage=[[TYViewStorage alloc]init];
//        viewStorage.view=btnUrl;
//        viewStorage.range=keywordModel.range;
//        [textContainer addTextStorage:viewStorage];
        
    }
    
    //at
    for (NSInteger i=0;i<self.atPersonArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.atPersonArray objectAtIndex:i];
        
        TYLinkTextStorage *linkTextStorage=[[TYLinkTextStorage alloc]init];
        linkTextStorage.range=keywordModel.range;
        linkTextStorage.text=nil;
        linkTextStorage.linkData=keywordModel.url;
        linkTextStorage.underLineStyle=kCTUnderlineStyleNone;
        [textContainer addTextStorage:linkTextStorage];
    }
    
    //话题
    for (NSInteger i=0; i<self.topicArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.topicArray objectAtIndex:i];
        
        TYLinkTextStorage *linkTextStorage=[[TYLinkTextStorage alloc]init];
        linkTextStorage.range=keywordModel.range;
        linkTextStorage.text=nil;
        linkTextStorage.linkData=keywordModel.url;
        linkTextStorage.underLineStyle=kCTUnderlineStyleNone;
        [textContainer addTextStorage:linkTextStorage];
    }
    
    
    _textContainer = [textContainer createTextContainerWithTextWidth:Getwidth-CELL_SIDEMARGIN*2];
    _contentHeight = textContainer.textHeight;
    
    self.atPersonArray=nil;
    self.emotionArray=nil;
    self.urlArray=nil;
    self.topicArray=nil;
}

#pragma 暂时这样子处理图片
-(void)calculateContentImageViewHegiht
{
    self.contengImageHeight=[WBContentImageView getContentImageViewHeight:self.statusModel.pic_urls.count];
}
@end

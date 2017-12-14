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
#import "TYTextRender.h"
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
    self.mlevelImage = [UIImage imageNamed:self.mlevelImageUrl];
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
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:self.statusModel.text];
    text.ty_color = _isRetweeted?RGBCOLOR(93, 93, 93) : RGBCOLOR(51, 51, 51);
    
    //at
    for (NSInteger i=0;i<self.atPersonArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.atPersonArray objectAtIndex:i];
        TYTextAttribute *textAttribute = [[TYTextAttribute alloc]init];
        textAttribute.color = RGBCOLOR(82, 126, 173);;
        TYTextHighlight *linkTextStorage=[[TYTextHighlight alloc]init];
        linkTextStorage.backgroundColor = RGBCOLOR(191, 223, 254);
        linkTextStorage.userInfo=@{@"url":keywordModel.url};
        linkTextStorage.backgroudInset = UIEdgeInsetsMake(1, 0, 1, 1);
        [text addTextAttribute:textAttribute range:keywordModel.range];
        [text addTextHighlightAttribute:linkTextStorage range:keywordModel.range];
    }
    
    //话题
    for (NSInteger i=0; i<self.topicArray.count;++i)
    {
        WBKeywordModel *keywordModel=[self.topicArray objectAtIndex:i];
        TYTextAttribute *textAttribute = [[TYTextAttribute alloc]init];
        textAttribute.color = RGBCOLOR(82, 126, 173);;
        TYTextHighlight *linkTextStorage=[[TYTextHighlight alloc]init];
        linkTextStorage.backgroundColor = RGBCOLOR(191, 223, 254);
        linkTextStorage.userInfo=@{@"url":keywordModel.url};
        linkTextStorage.backgroudInset = UIEdgeInsetsMake(1, 0, 1, 1);
        [text addTextAttribute:textAttribute range:keywordModel.range];
        [text addTextHighlightAttribute:linkTextStorage range:keywordModel.range];
    }
    
    //表情
    for (NSInteger i=self.emotionArray.count-1;i<self.emotionArray.count;--i)
    {
        WBKeywordModel *keywordModel=[self.emotionArray objectAtIndex:i];
        
        TYTextAttachment *imageStorage=[[TYTextAttachment alloc]init];
        imageStorage.image=[[UIImage imageNamed:keywordModel.url] imageScaledToSize:CGSizeMake(20,20)];
        imageStorage.baseline = -4;
        [text replaceCharactersInRange:keywordModel.range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageStorage]];
    }
    //url链接
    for (NSInteger i=self.urlArray.count-1;i>=0;--i)
    {
        WBKeywordModel *keywordModel=[self.urlArray objectAtIndex:i];
        NSRange range = [text.string rangeOfString:keywordModel.keyword];
        if (range.length == 0) {
            continue;
        }
        NSMutableAttributedString *att;
        if (keywordModel.type==1) {
            att=[[NSMutableAttributedString alloc]initWithString:@"查看图片"];
            TYTextAttachment *attachment = [[TYTextAttachment alloc]init];
            attachment.image = [UIImage imageNamed:@"timeline_card_small_photo_default"];
            attachment.size = CGSizeMake(15, 15);
            attachment.verticalAlignment = TYTextVerticalAlignmentCenter;
            [att insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        }else if (keywordModel.type==2) {
            att=[[NSMutableAttributedString alloc]initWithString:@"网页链接"];
            TYTextAttachment *attachment = [[TYTextAttachment alloc]init];
            attachment.image = [UIImage imageNamed:@"timeline_card_small_web_default"];
            attachment.size = CGSizeMake(16, 16);
            attachment.baseline = -2;
            [att insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        }
        TYTextAttribute *textAttribute = [[TYTextAttribute alloc]init];
        textAttribute.color = RGBCOLOR(82, 126, 173);
        TYTextHighlight *linkTextStorage=[[TYTextHighlight alloc]init];
        linkTextStorage.backgroundColor = RGBCOLOR(191, 223, 254);
        linkTextStorage.userInfo=@{@"url":keywordModel.url};
        [text replaceCharactersInRange:range withAttributedString:att];
        [text addTextAttribute:textAttribute range:NSMakeRange(range.location, att.length)];
        [text addTextHighlightAttribute:linkTextStorage range:NSMakeRange(range.location, att.length)];
    }
    text.ty_characterSpacing =0;
    text.ty_lineSpacing = 2;
    text.ty_font = _isRetweeted ? [UIFont systemFontOfSize:16]:[UIFont systemFontOfSize:17];
    _textRender = [[TYTextRender alloc]initWithAttributedText:text];
    _textRender.lineBreakMode = NSLineBreakByCharWrapping;
    _textRender.highlightBackgroudRadius = 5;
    _textRender.highlightBackgroudInset = UIEdgeInsetsMake(2, 0, 2, 1);
    CGFloat width = [UIScreen mainScreen].bounds.size.width-CELL_SIDEMARGIN*2;
    _textRender.size = CGSizeMake(width, [_textRender textSizeWithRenderWidth:width].height+2);
    _contentHeight =_textRender.size.height;
    
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

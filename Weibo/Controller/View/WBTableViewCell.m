//
//  TableViewCell.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBTableViewCell.h"
#import "WBHeadView.h"
#import "TYLabel.h"
#import "WBContentImageView.h"
#import "WBBottomView.h"
#import "WBButton.h"

#define CELL_HEADVIEW_HEIGHT 54.0    //头部高度
#define CELL_BOTTOM_HEIGHT   50.0    //底部固定高度

@interface WBTableViewCell()<TYLabelDelegate>
{
    WBHeadView *_headView;//头部view
    TYLabel *_contentAttributedLabel;//自身内容
    
    UIView *_retweetedView;//被转发的view
    TYLabel *_retweetedAttributedLabel;//被转发的内容view
    
    
    WBContentImageView *_contentImageView;//图片view
    
    
    WBBottomView *_bottomView;//底部view
}
@end


@implementation WBTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self configurationContentView];
        [self configurationLocation];
    }
    return self;
}

#pragma 配置view
-(void)configurationContentView
{
    _headView=[[WBHeadView alloc]init];
    _headView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_headView];
    
    _contentAttributedLabel=[[TYLabel alloc]init];
    //_contentAttributedLabel.displaysAsynchronously = NO;
    _contentAttributedLabel.delegate=self;
    [self.contentView addSubview:_contentAttributedLabel];
    
    _retweetedView=[[UIView alloc]init];
    _retweetedView.backgroundColor=RGBCOLOR(248,248,248);
    [self.contentView addSubview:_retweetedView];
    
    _retweetedAttributedLabel=[[TYLabel alloc]init];
    _retweetedAttributedLabel.backgroundColor=RGBCOLOR(248,248,248);
    //_retweetedAttributedLabel.displaysAsynchronously = NO;
    _retweetedAttributedLabel.delegate=self;
    [self.contentView addSubview:_retweetedAttributedLabel];
    
    
    
    _contentImageView=[[WBContentImageView alloc]init];
    [self.contentView addSubview:_contentImageView];
    
    
    _bottomView=[[WBBottomView alloc]init];
    [self.contentView addSubview:_bottomView];
}


#pragma mark － 配置位置
-(void)configurationLocation
{
    _headView.frame=CGRectMake(0,0,Getwidth,CELL_HEADVIEW_HEIGHT);
    _contentAttributedLabel.frame=CGRectMake(CELL_SIDEMARGIN,CELL_HEADVIEW_HEIGHT+CELL_PADDING_6,Getwidth-CELL_SIDEMARGIN*2,0);
    _contentImageView.frame=CGRectMake(0,0,Getwidth,0);
    _retweetedAttributedLabel.frame=CGRectMake(CELL_SIDEMARGIN,0,Getwidth-CELL_SIDEMARGIN*2,0);
}


-(void)setHomeCellViewModel:(WBHomeCellViewModel *)homeCellViewModel
{
    _homeCellViewModel=homeCellViewModel;
    _headView.homeCellViewModel=homeCellViewModel;
    _contentAttributedLabel.height=homeCellViewModel.contentHeight;
    
    
    if (homeCellViewModel.statusModel.retweeted_status!=nil)
    {
        _retweetedAttributedLabel.hidden=NO;
        _retweetedView.hidden=NO;
        
        
        WBHomeCellViewModel *retweetedViewModel=homeCellViewModel.statusModel.retweeted_status;
        

        _retweetedAttributedLabel.frame=CGRectMake(CELL_SIDEMARGIN,CELL_PADDING_6*2+_contentAttributedLabel.bottom,Getwidth-CELL_SIDEMARGIN*2,retweetedViewModel.contentHeight);
        
        //判断是否有图片
        if (retweetedViewModel.contengImageHeight>0)
        {
            _contentImageView.hidden=NO;
        }
        else
        {
            _contentImageView.hidden=YES;
        }
        _contentImageView.backgroundColor=RGBCOLOR(248,248,248);
        _contentImageView.frame=CGRectMake(0,_retweetedAttributedLabel.bottom, Getwidth,retweetedViewModel.contengImageHeight);
        
        
        if (retweetedViewModel.contengImageHeight>0)
        {
            _retweetedView.frame=CGRectMake(0,CELL_PADDING_6+_contentAttributedLabel.bottom,Getwidth,retweetedViewModel.contentHeight+retweetedViewModel.contengImageHeight+CELL_PADDING_6);
        }
        else
        {
            _retweetedView.frame=CGRectMake(0,CELL_PADDING_6+_contentAttributedLabel.bottom,Getwidth,retweetedViewModel.contentHeight+retweetedViewModel.contengImageHeight+CELL_PADDING_6*2);
        }
        
        _bottomView.frame=CGRectMake(0,_retweetedView.bottom,Getwidth, CELL_BOTTOM_HEIGHT);
    }
    else
    {
        _retweetedAttributedLabel.hidden=YES;
        _retweetedView.hidden=YES;
        
        
        //判断是否有图片
        if (homeCellViewModel.contengImageHeight>0)
        {
            _contentImageView.hidden=NO;
        }
        else
        {
            _contentImageView.hidden=YES;
        }
        _contentImageView.backgroundColor=[UIColor whiteColor];
        _contentImageView.frame=CGRectMake(0,_contentAttributedLabel.bottom, Getwidth,homeCellViewModel.contengImageHeight);
        
        _retweetedView.frame=CGRectMake(0,CELL_PADDING_6+_contentAttributedLabel.bottom,Getwidth,0);
        
        
        if (homeCellViewModel.contengImageHeight>0)
        {
            _bottomView.frame=CGRectMake(0,_contentImageView.bottom,Getwidth, CELL_BOTTOM_HEIGHT);
        }
        else
        {
            _bottomView.frame=CGRectMake(0,_contentImageView.bottom+CELL_PADDING_6,Getwidth, CELL_BOTTOM_HEIGHT);
        }
    }
    
    _bottomView.homeCellViewModel=homeCellViewModel;
}


////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
-(void)drawCell
{
    WBHomeCellViewModel *retweetedViewModel=_homeCellViewModel.statusModel.retweeted_status;
    
    [_contentAttributedLabel  setTextRender:_homeCellViewModel.textRender];
    [_retweetedAttributedLabel setTextRender:retweetedViewModel.textRender];
    
    if(retweetedViewModel!=nil)
    {
        _contentImageView.urlArray=retweetedViewModel.statusModel.pic_urls;
    }
    else
    {
       _contentImageView.urlArray=self.homeCellViewModel.statusModel.pic_urls;
    }
}


////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
-(void)drawClear
{
    [_retweetedAttributedLabel setTextRender:nil];
    [_contentAttributedLabel setTextRender:nil];
    _contentImageView.urlArray=nil;
}



////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
+(float)getHeight:(WBHomeCellViewModel *)homeCellViewModel
{
    float height=0;
    
    //头部固定高度
    height=CELL_HEADVIEW_HEIGHT;
    
    //头部跟内容的间隙
    height+=CELL_PADDING_6;
    
    
    //内容区域
    height+=homeCellViewModel.contentHeight;
    
    
    //被转发的内容
    if (homeCellViewModel.statusModel.retweeted_status!=nil)
    {
        WBHomeCellViewModel *retweetedViewModel=homeCellViewModel.statusModel.retweeted_status;
        
        height+=retweetedViewModel.contentHeight+CELL_PADDING_6*2;
        
        
        //被转发的有图片
        height+=retweetedViewModel.contengImageHeight;
    }
    else
    {
        //原文图片
        height+=homeCellViewModel.contengImageHeight;
        
        
        if (homeCellViewModel.contengImageHeight<=0)
        {
            //中间跟底部的间距
            height+=CELL_PADDING_6;
        }
    }
    
    
    //底部
    height+=CELL_BOTTOM_HEIGHT;
    
    return height;
}

//-(void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point
//{
//    if ([textStorage isKindOfClass:[TYLinkTextStorage class]])
//    {
//        NSString *linkStr = ((TYLinkTextStorage*)textStorage).linkData;
//
//        if ([linkStr hasPrefix:PROTOCOL_AT_SOMEONE])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }
//        else if([linkStr hasPrefix:PROTOCOL_SHARP_TREND])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }else if ([linkStr hasPrefix:PROTOCOL_HTTP_URL])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }
//    }
//    else if ([textStorage isKindOfClass:[TYViewStorage class]])
//    {
//        TYViewStorage *viewStorage=(TYViewStorage *)textStorage;
//        WBButton*button=(WBButton *)viewStorage.view;
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:button.content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }
//}

//-(void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
//{
//    
//}


//-(void)awakeFromNib
//{
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

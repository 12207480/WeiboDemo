//
//  WBBottomView.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBBottomView.h"

@interface  WBBottomView()
{
    UIImageView *_topBG;//没找到图片自己画一条线.....
    UIImageView *_imageBG;//背景
    UIButton *_btnForwarding;
    UIImageView *_oneLine;
    UIButton *_btnComments;
    UIImageView *_twoLine;
    UIButton *_btnPraise;
}
@end


@implementation WBBottomView

-(instancetype)init
{
    self=[super init];
    if (self)
    {
        self.backgroundColor=RGBCOLOR(242,242,242);
        [self configurationContentView];
        [self configurationLocation];
    }
    return self;
}


#pragma 配置view
-(void)configurationContentView
{
    _topBG=[[UIImageView alloc]init];
    _topBG.backgroundColor=RGBCOLOR(216, 216, 216);
    [self addSubview:_topBG];
    
    
    _imageBG=[[UIImageView alloc]init];
    _imageBG.backgroundColor=[UIColor whiteColor];
    _imageBG.image=[[UIImage imageNamed:@"common_card_bottom_background"]ImageWithLeftCapWidth];
    [self addSubview:_imageBG];
    
    
    //转发
    _btnForwarding=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnForwarding.backgroundColor=[UIColor whiteColor];
    [_btnForwarding setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [_btnForwarding setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btnForwarding.titleLabel.font=[UIFont systemFontOfSize:13.0];
    _btnForwarding.imageEdgeInsets=UIEdgeInsetsMake(0,0,0,10);
    _btnForwarding.titleEdgeInsets=UIEdgeInsetsMake(0,10,0,0);
    [self addSubview:_btnForwarding];
    
    
    //第一个线
    _oneLine=[[UIImageView alloc]init];
    _oneLine.backgroundColor=[UIColor whiteColor];
    _oneLine.image=[UIImage imageNamed:@"timeline_card_bottom_line_os7"];
    [self addSubview:_oneLine];
    
    
    //评论
    _btnComments=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnComments.backgroundColor=[UIColor whiteColor];
    [_btnComments setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [_btnComments setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btnComments.titleLabel.font=[UIFont systemFontOfSize:13.0];
    _btnComments.imageEdgeInsets=UIEdgeInsetsMake(-1,0,0,10);
    _btnComments.titleEdgeInsets=UIEdgeInsetsMake(0,10,0,0);
    [self addSubview:_btnComments];
    
    
    //第二个线
    _twoLine=[[UIImageView alloc]init];
    _twoLine.backgroundColor=[UIColor whiteColor];
    _twoLine.image=[UIImage imageNamed:@"timeline_card_bottom_line_os7"];
    [self addSubview:_twoLine];
    
    
    //赞
    _btnPraise=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnPraise.backgroundColor=[UIColor whiteColor];
    [_btnPraise setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    [_btnPraise setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btnPraise.titleLabel.font=[UIFont systemFontOfSize:13.0];
    _btnPraise.imageEdgeInsets=UIEdgeInsetsMake(0,0,0,10);
    _btnPraise.titleEdgeInsets=UIEdgeInsetsMake(0,10,0,0);
    [self addSubview:_btnPraise];
}

#pragma mark － 配置位置
-(void)configurationLocation
{
    _topBG.frame=CGRectMake(0,0,Getwidth,1.0f/[UIScreen mainScreen].scale);
    _imageBG.frame=CGRectMake(0,1.0f/[UIScreen mainScreen].scale,Getwidth,36);
    _btnForwarding.frame=CGRectMake(0,1,Getwidth/3,33);
    _oneLine.frame=CGRectMake(Getwidth/3,0,1,36);
    _btnComments.frame=CGRectMake(Getwidth/3+1,1,102,33);
    _twoLine.frame=CGRectMake((Getwidth/3)*2,0,1,36);
    _btnPraise.frame=CGRectMake((Getwidth/3)*2+1,1,102,33);
}


#pragma 设置值
-(void)setHomeCellViewModel:(WBHomeCellViewModel *)homeCellViewModel
{
    _homeCellViewModel=homeCellViewModel;
    
    //底部
    [_btnForwarding setTitle:_homeCellViewModel.statusModel.reposts_count==0?@"转发":[NSString stringWithFormat:@"%ld",(long)_homeCellViewModel.statusModel.reposts_count] forState:UIControlStateNormal];
    [_btnComments setTitle:_homeCellViewModel.statusModel.comments_count==0?@"评论":[NSString stringWithFormat:@"%ld",(long)_homeCellViewModel.statusModel.comments_count] forState:UIControlStateNormal];
    [_btnPraise setTitle:_homeCellViewModel.statusModel.attitudes_count==0?@"赞":[NSString stringWithFormat:@"%ld",(long)_homeCellViewModel.statusModel.attitudes_count] forState:UIControlStateNormal];
}
@end

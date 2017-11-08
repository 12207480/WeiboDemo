//
//  WBHeadView.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBHeadView.h"


@interface WBHeadView()
{
    UIButton *_contactAvatarView;//头像大view
    UIImageView *_imgAvatarView;//头像
    UIImageView *_imgAvatarType;//企业View,微博达人
    UIButton *_btnUserScreenName;//昵称vip
    UILabel *_labUserName;//用户昵称
    UIImageView *_imgVip;//Vip
    UILabel *_labReleaseTime;//发布时间
    UILabel *_labReleaseTerminal;//发布终端
}
@end


@implementation WBHeadView

-(instancetype)init
{
    self=[super init];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        [self configurationContentView];
        [self configurationLocation];
    }
    return self;
}

#pragma 配置view
-(void)configurationContentView
{
    //头像View
    _contactAvatarView=[UIButton buttonWithType:UIButtonTypeCustom];
    _contactAvatarView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_contactAvatarView];
    
    
    //头像
    _imgAvatarView=[[UIImageView alloc]init];
    _imgAvatarView.backgroundColor=[UIColor whiteColor];
    [_contactAvatarView addSubview:_imgAvatarView];
    
    
    //用户类型
    _imgAvatarType=[[UIImageView alloc]init];
    //_imgAvatarType.backgroundColor=[UIColor whiteColor];
    [_contactAvatarView addSubview:_imgAvatarType];
    
    
    //名称View
    _btnUserScreenName=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnUserScreenName.backgroundColor=[UIColor whiteColor];
    [self addSubview:_btnUserScreenName];
    
    
    //用户昵称
    _labUserName=[[UILabel alloc]init];
    _labUserName.opaque = YES;
    _labUserName.backgroundColor=[UIColor whiteColor];
    _labUserName.font=TITLE_FONT_SIZE;
    _labUserName.textColor=RGBCOLOR(231,123,59);
    [_btnUserScreenName addSubview:_labUserName];
    
    
    //VIp
    _imgVip=[[UIImageView alloc]init];
    _imgVip.backgroundColor=[UIColor whiteColor];
    _imgVip.image=[UIImage imageNamed:@"common_icon_membership"];
    [_btnUserScreenName addSubview:_imgVip];
    
    
    //发布时间
    _labReleaseTime=[[UILabel alloc]init];
    _labReleaseTime.opaque = YES;
    _labReleaseTime.backgroundColor=[UIColor whiteColor];
    _labReleaseTime.font=SUBTITLE_FONT_SIZE;
    _labReleaseTime.textAlignment=NSTextAlignmentLeft;
    _labReleaseTime.textColor=RGBCOLOR(148,148,148);
    [self addSubview:_labReleaseTime];
    
    
    //发布终端
    _labReleaseTerminal=[[UILabel alloc]init];
    _labReleaseTerminal.opaque = YES;
    _labReleaseTerminal.backgroundColor=[UIColor whiteColor];
    _labReleaseTerminal.font=SUBTITLE_FONT_SIZE;
    _labReleaseTerminal.textAlignment=NSTextAlignmentLeft;
    _labReleaseTerminal.textColor=RGBCOLOR(148,148,148);
    [self addSubview:_labReleaseTerminal];
}

#pragma mark － 配置位置
-(void)configurationLocation
{
    _contactAvatarView.frame=CGRectMake(CELL_SIDEMARGIN,CELL_SIDEMARGIN,HEAD_CONTACTAVATARVIEW_HEIGHT,HEAD_CONTACTAVATARVIEW_HEIGHT);
    _imgAvatarView.frame=CGRectMake(0,0,HEAD_IAMGE_HEIGHT,HEAD_IAMGE_HEIGHT);
    _imgAvatarType.frame=CGRectMake(22,22,18,18);
    _btnUserScreenName.frame=CGRectMake(63,12,114,19);
    _labUserName.frame=CGRectMake(0,0,106,19);
    _imgVip.frame=CGRectMake(108,2,14,14);
    _labReleaseTime.frame=CGRectMake(63,CELL_SIDEMARGIN+23,43,12.0);
    _labReleaseTerminal.frame=CGRectMake(111,CELL_SIDEMARGIN+23,80,12.0);
}

-(void)setHomeCellViewModel:(WBHomeCellViewModel *)homeCellViewModel
{
    _homeCellViewModel=homeCellViewModel;
    
    WBUserModel *userModel=_homeCellViewModel.statusModel.user;
    
    
    [_imgAvatarView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:nil options:SDWebImageLowPriority];
    
    _imgAvatarType.image=userModel.verifiedImage;
    _labUserName.text=userModel.name;
    _labUserName.width = userModel.nameWidth;
    _imgVip.left=_labUserName.right+3;
    _imgVip.image=_homeCellViewModel.mlevelImage;
    
    _btnUserScreenName.width=_labUserName.width+_imgVip.width;
    _labReleaseTime.text=_homeCellViewModel.timestamp;
    _labReleaseTime.width = _homeCellViewModel.timestampWidth;
    _labReleaseTerminal.left=_labReleaseTime.right+5;
    _labReleaseTerminal.text=_homeCellViewModel.statusModel.source;
    _labReleaseTerminal.width =_homeCellViewModel.statusModel.sourceWidth;
}
@end

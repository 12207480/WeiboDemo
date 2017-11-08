//
//  WBUserModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  用户（user）
 */
@interface WBUserModel : NSObject

@property(copy,nonatomic)NSString *idstr;//字符串型的用户UID
@property(copy,nonatomic)NSString *screen_name;//用户昵称
@property(copy,nonatomic)NSString *name;//友好显示名称
@property(assign,nonatomic)NSInteger province;//用户所在省级ID
@property(assign,nonatomic)NSInteger city;//用户所在城市ID
@property(copy,nonatomic)NSString *location;//用户所在地
@property(copy,nonatomic)NSString *descriptionn;//用户个人描述
@property(copy,nonatomic)NSString *url;//用户博客地址
@property(copy,nonatomic)NSString *profile_image_url;//用户头像地址（中图），50×50像素
@property(copy,nonatomic)NSString *profile_url;//用户的微博统一URL地址
@property(copy,nonatomic)NSString *domain;//用户的个性化域名
@property(copy,nonatomic)NSString *weihao;//用户的微号
@property(copy,nonatomic)NSString *gender;//性别，m：男、f：女、n：未知
@property(assign,nonatomic)NSInteger followers_count;//粉丝数
@property(assign,nonatomic)NSInteger friends_count;//关注数
@property(assign,nonatomic)NSInteger statuses_count;//微博数
@property(assign,nonatomic)NSInteger favourites_count;//收藏数
@property(copy,nonatomic)NSString *created_at;//用户创建（注册）时间
@property(assign,nonatomic)BOOL allow_all_act_msg;//是否允许所有人给我发私信，true：是，false：否
@property(assign,nonatomic)BOOL geo_enabled;//是否允许标识用户的地理位置，true：是，false：否
@property(assign,nonatomic)BOOL verified;//是否是微博认证用户，即加V用户，true：是，false：否
@property(assign,nonatomic)NSInteger verified_type;//-1普通用户;0名人,1政府,2企业,3媒体,4校园,5网站,6应用,7团体（机构）,8待审企业,10微博女郎,200初级达人,220中高级达人,400已故V用户。-1为普通用户，200和220为达人用户，0为黄V用户，其它即为蓝V用户
@property(copy,nonatomic)NSString *remark;//用户备注信息，只有在查询用户关系时才返回此字段
@property(strong,nonatomic)id status;//用户的最近一条微博信息字段
@property(assign,nonatomic)BOOL allow_all_comment;//是否允许所有人对我的微博进行评论，true：是，false：否
@property(copy,nonatomic)NSString *avatar_large;//用户头像地址（大图），180×180像素
@property(copy,nonatomic)NSString *avatar_hd;//用户头像地址（高清），高清头像原图
@property(copy,nonatomic)NSString *verified_reason;//认证原因
@property(assign,nonatomic)BOOL follow_me;//该用户是否关注当前登录用户，true：是，false：否
@property(assign,nonatomic)NSInteger online_status;//用户的在线状态，0：不在线、1：在线
@property(assign,nonatomic)NSInteger bi_followers_count;//用户的互粉数
@property(copy,nonatomic)NSString *lang;//用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语


//额外自己加的属性
@property(copy,nonatomic)NSString *verifiedImageUrl;//认证用户的图片的URl
@property(strong,nonatomic) UIImage *verifiedImage;
@property (assign, nonatomic) CGFloat nameWidth;

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic;
@end

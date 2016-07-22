//
//  WBSession.h
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBSession : NSObject


-(void)setCurrentSession:(id)session;

@property(readonly, nonatomic, getter=isValid) BOOL valid;//是否有效
@property(readonly) BOOL hasUser;//是否已登陆
@property(readonly) NSString *userWBID;//微博id
@property(readonly) NSString *accessToken;//微博认证口令


@end

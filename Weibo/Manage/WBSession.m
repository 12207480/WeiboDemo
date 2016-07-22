//
//  WBSession.m
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBSession.h"
#import "NSDate+ShortCut.h"

static NSString * const  kHasUser = @"hasUser";
static NSString * const  kUserWBID=@"userWBID";
static NSString * const  kAccessToken=@"accessToken";
static NSString * const  kExpirationDate=@"expirationDate";

@implementation WBSession


/////////////////////////////////////////
/////////////////////////////////////////
-(void)setCurrentSession:(id)session
{
    if ([session isKindOfClass:[WBAuthorizeResponse class]])
    {
        WBAuthorizeResponse *authorizeResponse=session;
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:kHasUser];
        [userDefaults setObject:authorizeResponse.userID forKey:kUserWBID];
        [userDefaults setObject:authorizeResponse.accessToken forKey:kAccessToken];
        [userDefaults setObject:authorizeResponse.expirationDate forKey:kExpirationDate];
        [userDefaults synchronize];
    }
}


/////////////////////////////////////////
/////////////////////////////////////////
-(NSString *)userWBID
{    
    if ([self hasUser])
    {
        return [[NSUserDefaults standardUserDefaults]objectForKey:kUserWBID];
    }
    else
    {
        return nil;
    }
}


/////////////////////////////////////////
/////////////////////////////////////////
-(NSString *)accessToken
{
    if ([self hasUser])
    {
        return [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
    }
    else
    {
        return nil;
    }
}



/////////////////////////////////////////
/////////////////////////////////////////
-(BOOL)hasUser
{
    BOOL hasUser=[[NSUserDefaults standardUserDefaults]boolForKey:kHasUser];
    if (hasUser)
    {
        if ([self isValid])
        {
            hasUser=YES;
        }
        else
        {
            hasUser=NO;
        }
    }
    return hasUser;
}


/////////////////////////////////////////
/////////////////////////////////////////
-(BOOL)isValid
{
    BOOL valid=NO;
    
    //当前日期
    NSDate *today=[NSDate date];
    
    //过期日期
    NSDate *expirationDate=[[NSUserDefaults standardUserDefaults]objectForKey:kExpirationDate];
    
    if (expirationDate)
    {
        if ([today ShortCutStringWithStrFormatter:@"yyyyMMddHHmmss"].integerValue>[expirationDate ShortCutStringWithStrFormatter:@"yyyyMMddHHmmss"].integerValue)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        valid=NO;
    }
    return valid;
}
@end

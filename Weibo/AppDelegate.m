//
//  AppDelegate.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDate+ShortCut.h"
//#import "KMCGeigerCounter.h"
#import "JPFPSStatus.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:kAppKey];
    [WBEmotionManage emotionsArray];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //[KMCGeigerCounter sharedGeigerCounter].enabled = YES;
    
    WBHomeViewController *homeViewController=[[WBHomeViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:homeViewController];
    self.window.rootViewController=navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [[JPFPSStatus sharedInstance] open];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma Weibo Delegate
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        //do thing
    }
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        WBSession *session=[[WBSession alloc]init];
        [session setCurrentSession:(WBAuthorizeResponse *)response];
        [[NSNotificationCenter defaultCenter]postNotificationName:KLoginNotification object:self];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

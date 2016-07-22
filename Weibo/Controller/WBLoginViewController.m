//
//  WBLoginViewController.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBLoginViewController.h"

@interface WBLoginViewController ()

@end

@implementation WBLoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginNotification) name:KLoginNotification object:nil];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame=CGRectMake(0,0,80,40);
    btnLogin.center=self.view.center;
    [btnLogin setBackgroundColor:[UIColor redColor]];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(eventForLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}


#pragma 通知
-(void)loginNotification
{
    [self dismissViewControllerAnimated:YES completion:self.dismissViewBlock];
}



#pragma 登录
-(void)eventForLogin:(UIButton *)sender
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

-(void)dealloc
{
    debugLog(@"释放");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

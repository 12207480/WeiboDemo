//
//  WBLoginViewController.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KLoginNotification @"KLoginNotification"

@interface WBLoginViewController : UIViewController

@property (nonatomic, copy) void(^dismissViewBlock)(void);

@end

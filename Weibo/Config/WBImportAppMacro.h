//
//  WBImportAppMacro.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//


#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define WeakSelf(toName,instance)   __weak typeof(&*instance)toName = instance
#define StrongSelf(toName,instance)   __strong typeof(&*instance)toName = instance

//获取机子的高度
#define GetHeight [UIScreen mainScreen].bounds.size.height

//获取机子的宽度
#define Getwidth  [UIScreen mainScreen].bounds.size.width

//获取机子系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取软件版本号
#define  IOS_SoftWare [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

//当前语言文件
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//是否是3.5寸
#define IS_SCREEN_35_INCH ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
//是否是4寸

#define IS_SCREEN_4_INCH ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//获取机子路径的图片
#define GetImageURLWith(path) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",path] ofType:@"png"]]

//是否是IPAD
#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]





//布局字体
#define TITLE_FONT_SIZE [UIFont systemFontOfSize:15.f]
#define SUBTITLE_FONT_SIZE [UIFont systemFontOfSize:12.f]
#define BUTTON_FONT_SIZE [UIFont systemFontOfSize:13.f]


// Cell布局相关
#define CELL_PADDING_8 8    //距离上面
#define CELL_PADDING_6 6    //距离左边
#define CELL_SIDEMARGIN 12  //侧边缘


//头部固定高度
#define HEAD_HEIGHT  55.0f
#define HEAD_CONTACTAVATARVIEW_HEIGHT 40.0f
#define HEAD_IAMGE_HEIGHT  34.0f

//自定义链接协议
#define PROTOCOL_AT_SOMEONE @"at://"
#define PROTOCOL_SHARP_TREND @"sharptrend://"
#define PROTOCOL_HTTP_URL @"http://"



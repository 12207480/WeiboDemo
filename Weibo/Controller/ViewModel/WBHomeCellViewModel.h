//
//  WBHomeCellViewModel.h
//  Weibo
//
//  Created by SKY on 15/5/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYTextContainer.h"

@interface WBHomeCellViewModel : NSObject

@property(strong,nonatomic)WBStatusModel *statusModel;
//@property(strong,nonatomic)NSAttributedString *attributedString;
@property (nonatomic, strong) TYTextContainer *textContainer;

@property(strong,nonatomic)NSArray *emotionArray;//表情数组
@property(strong,nonatomic)NSArray *atPersonArray;//at
@property(strong,nonatomic)NSArray *urlArray;//网址数组
@property(strong,nonatomic)NSArray *topicArray;//话题
@property(copy,nonatomic)NSString *mlevelImageUrl;//微博等级URl
@property(copy,nonatomic)NSString *timestamp;//时间显示出来的

@property(assign,nonatomic)CGFloat timestampWidth;
@property(assign,nonatomic)float  contentHeight;//本身内容高度
@property(assign,nonatomic)float  contengImageHeight;//图片高度

@end

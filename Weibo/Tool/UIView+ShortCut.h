//
//  UIView+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShortCut)
/**
 *  给该视图或其子视图添加一个快照
 *
 *  @return 快照图片
 */
- (UIImage *)snapshotImage;
/**
 *   创建一个快照并添加1 px透明边缘(反锯齿)
 *
 *  @return 快照图片
 */
- (UIImage *)snapshotImageAntialiasing;
/**
 *  视图坐标x的快捷键
 */
@property (nonatomic) CGFloat left;
/**
 *   视图坐标y的快捷键
 */
@property (nonatomic) CGFloat top;
/**
 *  视图坐标x+宽度的值frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;
/**
 *  视图坐标加上高度的值frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * 视图的宽度 frame.size.width
 */
@property (nonatomic) CGFloat width;

/**
 * 视图的高度 frame.size.height
 */
@property (nonatomic) CGFloat height;

/**
 * 视图中心点的坐标x center.x
 */
@property (nonatomic) CGFloat centerX;

/**
 * 视图中心点的坐标y center.y
 */
@property (nonatomic) CGFloat centerY;

/**
 *返回屏幕的x坐标
 */
@property (nonatomic, readonly) CGFloat screenX;

/**
 *返回屏幕的y坐标
 */
@property (nonatomic, readonly) CGFloat screenY;

/**
 *返回屏幕的X坐标,考虑滚动视图
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 *返回屏幕的y坐标,考虑滚动视图
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 *返回屏幕的视图Frame,考虑滚动视图
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 *frame的坐标快捷键 frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 *frame的大小快捷键  frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;
/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 *找到第一个子视图(包括这个视图),是一个成员的特殊类???
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 *找到第一个父视图(包括这个视图,是一个成员的特殊类???
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 *   移除所有的子视图
 */
- (void)removeAllSubviews;


/**
 *   返回视图的视图控制器
 */
@property (nonatomic, strong, readonly) UIViewController *viewController;



/**
 *  连接到单击事件的接收器,并给它一个block;
 *
 *  @param block 要执行的block
 */
- (void)setTapActionWithBlock:(void (^)(void))block;


/**
 *  连接到长按事件的接收器,并给它一个block;
 *
 *  @param block 要执行的block
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;
@end

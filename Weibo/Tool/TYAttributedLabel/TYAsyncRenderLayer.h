//
//  TYAsyncLayer.h
//  Weibo
//
//  Created by tany on 16/7/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class TYAsyncLayerRenderTask;
@protocol TYAsyncLayerDelegate <NSObject>

- (TYAsyncLayerRenderTask *)newAsyncLayerRenderTask;

@end

@interface TYAsyncRenderLayer : CALayer

@property (nonatomic, assign) BOOL asynchronousRendering;

@end

@interface TYAsyncLayerRenderTask : NSObject

@property (nonatomic, copy) void (^willRendering)(TYAsyncRenderLayer *layer);

@property (nonatomic, copy) void (^rendering)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));

@property (nonatomic, copy) void (^didRendering)(TYAsyncRenderLayer *layer, BOOL finished);

@end
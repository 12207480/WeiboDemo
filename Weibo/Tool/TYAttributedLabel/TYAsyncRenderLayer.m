//
//  TYAsyncLayer.m
//  Weibo
//
//  Created by tany on 16/7/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYAsyncRenderLayer.h"
#import <libkern/OSAtomic.h>

// 这个类参考了YYAsyncLayer
static dispatch_queue_t TYAsyncLayerGetRenderQueue() {
#define MAX_QUEUE_COUNT 5
    static int queueCount;
    static dispatch_queue_t queues[MAX_QUEUE_COUNT];
    static dispatch_once_t onceToken;
    static int32_t counter = 0;
    dispatch_once(&onceToken, ^{
        queueCount = (int)[NSProcessInfo processInfo].activeProcessorCount;
        queueCount = queueCount < 1 ? 1 : queueCount > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : queueCount;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            for (NSUInteger i = 0; i < queueCount; i++) {
                dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
                queues[i] = dispatch_queue_create("com.TYAsyncLayer.renderQueue", attr);
            }
        } else {
            for (NSUInteger i = 0; i < queueCount; i++) {
                queues[i] = dispatch_queue_create("com.TYAsyncLayer.renderQueue", DISPATCH_QUEUE_SERIAL);
                dispatch_set_target_queue(queues[i], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
            }
        }
    });
    int32_t cur = OSAtomicIncrement32(&counter);
    if (cur < 0) cur = -cur;
    return queues[(cur) % queueCount];
#undef MAX_QUEUE_COUNT
}

static dispatch_queue_t TYAsyncLayerGetReleaseQueue() {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}

@implementation TYAsyncLayerRenderTask

@end

@interface TYAsyncRenderLayer () {
    int32_t _value;
}

@end

@implementation TYAsyncRenderLayer

+ (id)defaultValueForKey:(NSString *)key {
    if ([key isEqualToString:@"asynchronousRendering"]) {
        return @(YES);
    } else {
        return [super defaultValueForKey:key];
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.opaque = YES;
        _asynchronousRendering = YES;
    }
    return self;
}

- (void)setNeedsDisplay {
    [self _cancelAsyncDisplay];
    [super setNeedsDisplay];
}

- (void)display {
    super.contents = super.contents;
    [self _displayAsync:_asynchronousRendering];
}

- (void)_cancelAsyncDisplay {
    OSAtomicIncrement32(&_value);
}

#pragma mark - Private

- (void)_displayAsync:(BOOL)async {
    __strong id<TYAsyncLayerDelegate> delegate = self.delegate;
    TYAsyncLayerRenderTask *task = [delegate newAsyncLayerRenderTask];
    if (!task.rendering) {
        if (task.willRendering) task.willRendering(self);
        self.contents = nil;
        if (task.didRendering) task.didRendering(self, YES);
        return;
    }
    
    if (async) {
        if (task.willRendering) task.willRendering(self);
        int32_t value = _value;
        BOOL (^isCancelled)() = ^BOOL() {
            return value != _value;
        };
        CGSize size = self.bounds.size;
        BOOL opaque = self.opaque;
        CGFloat scale = self.contentsScale;
        CGColorRef backgroundColor = (opaque && self.backgroundColor) ? CGColorRetain(self.backgroundColor) : NULL;
        if (size.width < 1 || size.height < 1) {
            CGImageRef image = (__bridge_retained CGImageRef)(self.contents);
            self.contents = nil;
            if (image) {
                dispatch_async(TYAsyncLayerGetReleaseQueue(), ^{
                    CFRelease(image);
                });
            }
            if (task.didRendering) task.didRendering(self, YES);
             CGColorRelease(backgroundColor);
            return;
        }
        
        dispatch_async(TYAsyncLayerGetRenderQueue(), ^{
            if (isCancelled()) {
                CGColorRelease(backgroundColor);
                return;
            }
            UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            if (opaque) {
                CGContextSaveGState(context); {
                    if (!backgroundColor || CGColorGetAlpha(backgroundColor) < 1) {
                        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                        CGContextAddRect(context, CGRectMake(0, 0, size.width * scale, size.height * scale));
                        CGContextFillPath(context);
                    }
                    if (backgroundColor) {
                        CGContextSetFillColorWithColor(context, backgroundColor);
                        CGContextAddRect(context, CGRectMake(0, 0, size.width * scale, size.height * scale));
                        CGContextFillPath(context);
                    }
                } CGContextRestoreGState(context);
                CGColorRelease(backgroundColor);
            }
            task.rendering(context, size, isCancelled);
            if (isCancelled()) {
                UIGraphicsEndImageContext();
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (task.didRendering) task.didRendering(self, NO);
                });
                return;
            }
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (isCancelled()) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (task.didRendering) task.didRendering(self, NO);
                });
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isCancelled()) {
                    if (task.didRendering) task.didRendering(self, NO);
                } else {
                    self.contents = (__bridge id)(image.CGImage);
                    if (task.didRendering) task.didRendering(self, YES);
                }
            });
        });
    } else {
        OSAtomicIncrement32(&_value);
        if (task.willRendering) task.willRendering(self);
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, self.contentsScale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        task.rendering(context, self.bounds.size, ^{return NO;});
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.contents = (__bridge id)(image.CGImage);
        if (task.didRendering) task.didRendering(self, YES);
    }
}

- (void)dealloc {
    OSAtomicIncrement32(&_value);;
}

@end

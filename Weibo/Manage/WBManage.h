//
//  WBManage.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBManage : NSObject<WBHttpRequestDelegate>


+(WBManage *)shardWBManage;

/**
 *  获取数据
 *
 *  @param tag           页码
 *  @param requestResult 回调
 */
-(void)requestWeiBo:(NSInteger)tag requestResult:(void(^)(BOOL result, NSMutableArray *array))requestResult;
@end

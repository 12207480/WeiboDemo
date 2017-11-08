//
//  WBManage.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBManage.h"
#import "WBHomeCellViewModel.h"

@interface WBManage()
@property(copy,nonatomic)void(^resultHandler)(BOOL result,NSMutableArray *array);
@end


@implementation WBManage


///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
+(WBManage *)shardWBManage
{
    static id shardInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shardInstance=[[self alloc]init];
    });
    return shardInstance;
}


///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
-(void)requestWeiBo:(NSInteger)tag requestResult:(void (^)(BOOL, NSMutableArray *))requestResult
{
    WBSession *session=[[WBSession alloc]init];
//    NSDictionary *dic=@{@"source":kAppKey,@"access_token":session.accessToken,@"since_id":@"0",@"max_id":@"0",@"count":@"200",@"page":[NSString stringWithFormat:@"%zd",tag],@"base_app":@"0",@"feature":@"0",@"trim_user":@"0"};
//    [WBHttpRequest requestWithAccessToken:session.accessToken url:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:dic delegate:self withTag:@"1"];
    
    self.resultHandler=requestResult;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        self.resultHandler=requestResult;
        NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                         pathForResource:@"weiboData" ofType:@"txt"] encoding:NSUTF8StringEncoding error: nil];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [self request:nil didFinishLoadingWithResult:textFileContents];
        }); 
        
    });
}



#pragma 成功
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSDictionary *dictionary=[WBManage sosoDictionary:result];
    WBDataModel *dataModel=[[WBDataModel alloc]initWithJsonDictionary:dictionary];
    
    if (dataModel.statuses.count<=0)
    {
        self.resultHandler(NO,nil);
    }
    else
    {
        NSMutableArray *statusArray=[[NSMutableArray alloc]init];
        for (int i=0;i<dataModel.statuses.count;++i)
        {
            WBStatusModel *statusModel=[self parsingStatus:[dataModel.statuses objectAtIndex:i]];
            
            
            if (statusModel.retweeted_status!=nil)
            {
                statusModel.retweeted_status=[self parsingStatus:statusModel.retweeted_status];
                WBStatusModel *retweetedModel=statusModel.retweeted_status;
                WBUserModel *userModel=retweetedModel.user;
                
                retweetedModel.text=[NSString stringWithFormat:@"@%@:%@",userModel.name,retweetedModel.text];
            }
            [statusArray addObject:statusModel];
        }
        
        
        //在这边直接转换成viewModel
        NSMutableArray *array=[[NSMutableArray alloc]init];
        for (NSInteger i=0;i<statusArray.count;++i)
        {
            WBStatusModel *model=[statusArray objectAtIndex:i];
            
            if (model.retweeted_status!=nil)
            {
                WBHomeCellViewModel *retweetedViewModel=[[WBHomeCellViewModel alloc]init];
                retweetedViewModel.isRetweeted = YES;
                retweetedViewModel.statusModel=model.retweeted_status;
                model.retweeted_status=retweetedViewModel;
            }
            
            
            WBHomeCellViewModel *homeCellViewModel=[[WBHomeCellViewModel alloc]init];
            homeCellViewModel.statusModel=model;
            [array addObject:homeCellViewModel];
        }
        self.resultHandler(YES,array);
    }
}


#pragma 失败
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    self.resultHandler(NO,nil);
}



#pragma 解析
-(WBStatusModel *)parsingStatus:(NSDictionary *)dic
{
    //解析微博（status）
    WBStatusModel *statusModel=[[WBStatusModel alloc]initWithJsonDictionary:dic];
    
    //解析地理geo
    if (statusModel.geo!=nil)
    {
        statusModel.geo=[[WBGeoModel alloc]initWithJsonDictionary:statusModel.geo];
    }
    
    //解析用户
    if (statusModel.user!=nil)
    {
        statusModel.user=[[WBUserModel alloc]initWithJsonDictionary:statusModel.user];
    }
    
    //解析图片集合
    return statusModel;
}


#pragma mark － 解析
+(NSDictionary *)sosoDictionary:(NSString *)Data
{
    NSError *error = nil;
    NSData *result=[Data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *items=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        debugLog(@"数据解析错误了%@",error);
        return nil;
    }
    return items;
}
@end

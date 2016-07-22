//
//  WBHomeViewController.m
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBTableView.h"


@interface WBHomeViewController ()

@property(strong,nonatomic)WBTableView *tableView;
@property(assign,nonatomic)NSInteger page;
@end

@implementation WBHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"微博首页";
    self.page=1;
    
    
    
    self.tableView=[[WBTableView alloc]init];
    self.tableView.backgroundColor=RGBCOLOR(242,242,242);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
    
    
    WeakSelf(weakSelf,self);
    [self.tableView addLegendHeaderWithRefreshingBlock:^
    {
        weakSelf.page=1;
        weakSelf.tableView.footer.hidden=YES;
        [weakSelf loadData:YES];
    }];
    
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
    
    
    WBSession *session=[[WBSession alloc]init];
    if ([session hasUser])
    {
        [self.tableView.header beginRefreshing];
    }
    else
    {
//        WBLoginViewController *loginViewController=[[WBLoginViewController alloc]init];
//        __typeof (self) __weak weakSelf = self;
//        [loginViewController setDismissViewBlock:^{
//            [weakSelf.tableView.header beginRefreshing];
//        }];
//        [self presentViewController:loginViewController animated:YES completion:nil];
        // 读取本地json
        [self loadData:YES];
    }

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma 加载数据
-(void)loadData:(BOOL)isHeader
{
    [[WBManage shardWBManage] requestWeiBo:self.page requestResult:^(BOOL result, NSMutableArray *array)
     {
         if (result)
         {
             if (isHeader)
             {
                 self.tableView.weiboArray=array;
             }
             else
             {
                 [self.tableView.weiboArray addObjectsFromArray:array];
             }
             self.page++;
             
             if (array.count>=1000)
             {
                 self.tableView.footer.hidden=NO;
             }
             else
             {
                 self.tableView.footer.hidden=YES;
             }
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:@"失败"];
         }
         
         if (isHeader)
         {
             [self.tableView.header endRefreshing];
         }
         else
         {
             [self.tableView.footer endRefreshing];
         }
         [self.tableView reloadData];
     }];
}

-(void)dealloc
{
    debugLog(@"释放");
}


-(void)didReceiveMemoryWarning
{
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

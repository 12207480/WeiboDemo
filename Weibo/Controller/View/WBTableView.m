//
//  WBTableView.m
//  Weibo
//
//  Created by SKY on 15/5/29.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "WBTableView.h"
#import "WBTableViewCell.h"

static NSString *kidentifier=@"WBTableViewCell";

@interface WBTableView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL scrollToToping;
    NSMutableArray *needLoadArr;
}
@end


@implementation WBTableView

-(instancetype)init
{
    self=[super init];
    if (self)
    {
        needLoadArr=[[NSMutableArray alloc]init];
        self.delaysContentTouches = NO;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight=0;
        self.estimatedSectionHeaderHeight=0;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[WBTableViewCell class] forCellReuseIdentifier:kidentifier];
    }
    return self;
}

#pragma UITableView - dataSource

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kidentifier forIndexPath:indexPath];
    [self drawCell:cell withIndexPath:indexPath];
    return cell;
}



#pragma  UITableView －delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBHomeCellViewModel *homeCellViewModel=[self.weiboArray objectAtIndex:indexPath.row];
    return [WBTableViewCell getHeight:homeCellViewModel];
}


- (void)drawCell:(WBTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    WBHomeCellViewModel *homeCellViewModel=[self.weiboArray objectAtIndex:indexPath.row];
    cell.homeCellViewModel=homeCellViewModel;
    [cell drawCell];
}



//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [needLoadArr removeAllObjects];
//}

//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    NSIndexPath *ip = [self indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
//    NSIndexPath *cip = [[self indexPathsForVisibleRows] firstObject];
//    NSInteger skipCount = 8;
//    if (labs(cip.row-ip.row)>skipCount)
//    {
//        NSArray *temp = [self indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.width, self.height)];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
//        if (velocity.y<0)
//        {
//            NSIndexPath *indexPath = [temp lastObject];
//            if (indexPath.row+3<self.weiboArray.count)
//            {
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
//            }
//        }
//        else
//        {
//            NSIndexPath *indexPath = [temp firstObject];
//            if (indexPath.row>3)
//            {
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
//            }
//        }
//        [needLoadArr addObjectsFromArray:arr];
//    }
//}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    scrollToToping = YES;
//    return YES;
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    scrollToToping = NO;
//    [self loadContent];
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
//{
//    scrollToToping = NO;
//    [self loadContent];
//}
//
////用户触摸时第一时间加载内容
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!scrollToToping)
//    {
//        [needLoadArr removeAllObjects];
//        [self loadContent];
//    }
//    return [super hitTest:point withEvent:event];
//}
//
//- (void)loadContent
//{
//    if (scrollToToping)
//    {
//        return;
//    }
//    if (self.indexPathsForVisibleRows.count<=0)
//    {
//        return;
//    }
//    if (self.visibleCells&&self.visibleCells.count>0)
//    {
//        for (id temp in [self.visibleCells copy])
//        {
//            WBTableViewCell *cell = (WBTableViewCell *)temp;
//            [cell drawCell];
//        }
//    }
//}
@end

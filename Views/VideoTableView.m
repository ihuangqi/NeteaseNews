//
//  VideoTableView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "VideoTableView.h"
#import "Network.h"
#import "MediaModel.h"
#import "MediaCell.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

#define kMediaCellIdentifier @"MediaCell"

#define API @"http://c.3g.163.com/nc/video/list/V9LG4B3A0/n/%d-%d.html"

@interface VideoTableView()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    NSMutableArray *dataArray;
    int pageStart;
    int pageCount;
    BOOL isRequesting;

    MJRefreshHeaderView *headView;
}
@end
@implementation VideoTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"MediaCell" bundle:nil] forCellReuseIdentifier:kMediaCellIdentifier];
        self.delegate = self;
        self.dataSource = self;
        dataArray = [NSMutableArray new];
        pageStart = 0;
        pageCount = 20;
        headView = [[MJRefreshHeaderView alloc] initWithScrollView:self];
        headView.delegate = self;
        
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 200;

        [self getDataSource];
    }
    return self;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    pageStart = 0;
    [self getDataSource];
}
-(void)getDataSource{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSString *url = [NSString stringWithFormat:API,pageStart,pageCount];
    isRequesting = YES;
    [Network GetDataFromAFNetworkingWithURL:url CallBack:^(id responseObject) {
        NSArray *array = [MediaModel getMediaModelFromResponse:responseObject];
        if (pageStart == 0) {
            [dataArray removeAllObjects];
        }
        if (array.count > 0) {
            [dataArray addObjectsFromArray:array];
            [self reloadData];
            isRequesting = NO;
        }
        [headView endRefreshing];
        [MBProgressHUD hideHUDForView:self animated:YES];
    }];
}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MediaCell *cell = [tableView dequeueReusableCellWithIdentifier:kMediaCellIdentifier];
    [cell setModel:dataArray[indexPath.row]];
    cell.rootViewController = self.rootViewController;
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 10) {
            if (isRequesting == NO) {
                isRequesting = YES;
                pageStart += 20;
                [self getDataSource];
            }
        }
    }
}
@end

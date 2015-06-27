//
//  RecommendView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RecommendTableView.h"
#import "RecommendCell.h"
#import "Network.h"
#import "MJRefresh.h"

#define kRecommendCellIdentifier @"RecommendCell"

#define RecommendAPI @"http://c.3g.163.com/recommend/getSubDocNews?passport=&devId=359876052121654&size=%d&from=yuedu"


@interface RecommendTableView()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    NSMutableArray *recommendDataArray;
    int pageStart;
    int pageCount;
    BOOL isRequesting;

    MJRefreshHeaderView *headerView;
}
@end

@implementation RecommendTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame RootViewControler:(UIViewController *)rootViewController{
    self = [super initWithFrame:frame];
    if (self) {
        _rootViewController = rootViewController;
        recommendDataArray = [NSMutableArray new];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellReuseIdentifier:kRecommendCellIdentifier];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;



        headerView = [[MJRefreshHeaderView alloc] initWithScrollView:self];
        headerView.delegate = self;


        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 150;

        [self getDataSource];
    }
    return self;
}
-(void)getDataSource{
    NSString *url = [NSString stringWithFormat:RecommendAPI,40];
    [Network GetDataFromAFNetworkingWithURL:url CallBack:^(id responseObject) {
        recommendDataArray = [RecommendModel getRecommendModelFromResponse:responseObject];
        [self reloadData];
        [headerView endRefreshing];

    }];
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    [self getDataSource];
}

#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return recommendDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecommendCellIdentifier];
    [cell setModel:recommendDataArray[indexPath.row]];
    cell.rootViewController = self.rootViewController;
    return cell;
}

//-(void)willMoveToWindow:(UIWindow *)newWindow{
//    [self reloadData];
//}
@end

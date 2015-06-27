//
//  MySubscribeTableView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define kRecommendSubscribeCellIdentifier @"RecommendSubscribeCell"
#define kMySubscribeCellIdnetifier @"MySubscribeCell"


#define MySubscribeAPI @"http://c.3g.163.com/nc/topicset/subscribe/recommend.html"

#define kPassportkey @"passport"
#define kSignKey @"sign"

#import "MySubscribeTableView.h"
#import "Network.h"
#import "SubscribeModel.h"
#import "RecommendListModel.h"
#import "RecommendSubscribeCell.h"
#import "ColumnModel.h"
#import "MySubscribeCell.h"
#import "MJRefresh.h"

@interface MySubscribeTableView()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{    NSArray *mySubscribeDataArray;
    MJRefreshHeaderView *headerView;
}
@end

@implementation MySubscribeTableView
- (instancetype)initWithFrame:(CGRect)frame RootViewControler:(UIViewController *)rootViewController{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        mySubscribeDataArray =@[[NSMutableArray new],[NSMutableArray new]];

        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"RecommendSubscribeCell" bundle:nil] forCellReuseIdentifier:kRecommendSubscribeCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"MySubscribeCell" bundle:nil] forCellReuseIdentifier:kMySubscribeCellIdnetifier];
        _rootViewController = rootViewController;

        self.sectionFooterHeight = 0;
        self.sectionHeaderHeight = 0;

        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.tintColor = [UIColor clearColor];
        self.sectionIndexColor = [UIColor clearColor];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;


        headerView = [[MJRefreshHeaderView alloc] initWithScrollView:self];
        headerView.delegate = self;

        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;

        [self getDataSoure];


    }
    return self;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    [self getDataSoure];
}
-(void)getDataSoure{
     NSString *urlString = @"http://c.3g.163.com/uc/api/visitor/v5/subs";
    //passport=359876052121654&sign=ded13969b96f8aa0e9fdfd4a0fca3a93
    [Network PostDataFromAFNetworkingWithURL:urlString parameters:@{kPassportkey:@"359876052121654",kSignKey:@"ded13969b96f8aa0e9fdfd4a0fca3a93"} CallBack:^(id responseObject) {
        NSMutableArray *columnList = [ColumnModel getColumnModelArrayFromResponse:responseObject];
        if (columnList.count > 0) {
            [mySubscribeDataArray[0] removeAllObjects];
            [mySubscribeDataArray[0] addObjectsFromArray:columnList];
        }
        NSString *urlString = MySubscribeAPI;
        [Network GetDataFromAFNetworkingWithURL:urlString CallBack:^(id responseObject) {
            NSMutableArray* array = [SubscribeModel getSubscribeModelFromResponse:responseObject].recommendlist;
            if (array == nil) {
                array = [NSMutableArray new];
            }
            [mySubscribeDataArray[1] removeAllObjects];
            [mySubscribeDataArray[1] addObjectsFromArray:array];
            [self reloadData];
            [headerView endRefreshing];
        }];
    }];
}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return mySubscribeDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    if (mySubscribeDataArray.count == section) {
//        return 0;
//    }
    return ((NSMutableArray *)mySubscribeDataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section == 1){
        RecommendSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecommendSubscribeCellIdentifier];
        [cell setModel:mySubscribeDataArray[section][row]];
        cell.rootViewController = self.rootViewController;
        return cell;
    }else if (section == 0){
        MySubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:kMySubscribeCellIdnetifier];
        [cell setModel:mySubscribeDataArray[section][row]];
        cell.rootViewController = self.rootViewController;
        return cell;
    }
    return nil;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  @"我的订阅";
    }else if (section == 1){
        return @"精选订阅";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    view.backgroundColor = [UIColor clearColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, view.frame.size.width - 20, 20)];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.000 green:0.200 blue:0.000 alpha:1.000];
//    UIView *separate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, view.frame.size.height)];
    UIView *separate = [[UIView alloc] init];
    separate.backgroundColor = [UIColor colorWithRed:1.000 green:0.200 blue:0.000 alpha:1.000];
    if (section == 0) {
        label.text = @"我的订阅";
    }else if (section == 1){
        label.text = @"精选订阅";
    }
    [view addSubview:label];
    [view addSubview:separate];

    label.translatesAutoresizingMaskIntoConstraints = NO;
    separate.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(label,separate);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[separate(3)]-10-[label]|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[separate]-3-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:views]];

    return view;
}



//-(void)willMoveToWindow:(UIWindow *)newWindow{
//    [self reloadData];
//}
@end

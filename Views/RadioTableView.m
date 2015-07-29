//
//  RadioTableView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define API @"http://c.3g.163.com/nc/topicset/android/radio/index.html"

#import "RadioTableView.h"
#import "AllRadioModel.h"
#import "Network.h"
#import "MBProgressHUD.h"
#import "RadioclassifyModel.h"
#import "RadioTopCell.h"
#import "RadioGeneralCell.h"
#import "MJRefresh.h"


#define kRadioTopCellKey @"RadioTopCell"
#define kRadioGeneralCellKey @"RadioGeneralCell"


@interface RadioTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation RadioTableView
{
    AllRadioModel *allRadioModel;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self registerNib:[UINib nibWithNibName:@"RadioTopCell" bundle:nil] forCellReuseIdentifier:kRadioTopCellKey];
        [self registerNib:[UINib nibWithNibName:@"RadioGeneralCell" bundle:nil] forCellReuseIdentifier:kRadioGeneralCellKey];

        self.dataSource = self;
        self.delegate = self;

        __weak typeof(self) weakSelf = self;
        self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf getDataSource];
        }];
        
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 20;

        [self getDataSource];
    }
    return self;
}

-(void)getDataSource{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSString *url = [NSString stringWithFormat:API];
    [Network GetDataFromAFNetworkingWithURL:url CallBack:^(id responseObject) {
        allRadioModel = [[AllRadioModel alloc] initWithDictionary:responseObject];
        if (allRadioModel) {
            [self reloadData];
        }
        [self.header endRefreshing];
        [MBProgressHUD hideHUDForView:self animated:YES];
    }];

}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (allRadioModel && (allRadioModel.top || allRadioModel.cList.count)) {
        return 1+allRadioModel.cList.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        if (allRadioModel.top) {
            return 1;
        }else{
            return 0;
        }
    }
    if (allRadioModel.cList.count > 0) {
        return 1;
    }
    return 0;
//    return ((RadioclassifyModel *)allRadioModel.cList[section - 1]).tList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        RadioTopCell *cell = [tableView dequeueReusableCellWithIdentifier:kRadioTopCellKey];
        [cell setModel:allRadioModel.top];
        cell.rootViewController = self.rootViewController;
        return cell;
    }
    section = section - 1;
    RadioGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:kRadioGeneralCellKey];
    [cell setModel:allRadioModel.cList[section]];
    cell.rootViewController = self.rootViewController;
    return cell;

}

@end

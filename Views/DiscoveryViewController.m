//
//  DiscoveryViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define kUtilityCellKey @"UtilityCell"
#define kAdvertiseCellKey @"AdvertiseCell"

#import "DiscoveryViewController.h"
#import "Network.h"
#import "DiscoveryModel.h"
#import "UtilityCell.h"
#import "AdvertiseCell.h"
@interface DiscoveryViewController()<UITableViewDelegate,UITableViewDataSource>
{
    DiscoveryModel* discoveryModel;
    __weak IBOutlet UITableView *_tableVIew;

}


@end
@implementation DiscoveryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [_tableVIew registerNib:[UINib nibWithNibName:@"UtilityCell" bundle:nil] forCellReuseIdentifier:kUtilityCellKey];
    [_tableVIew registerNib:[UINib nibWithNibName:@"AdvertiseCell" bundle:nil] forCellReuseIdentifier:kAdvertiseCellKey];

    _tableVIew.rowHeight = UITableViewAutomaticDimension;
    _tableVIew.estimatedRowHeight = 200;

#define API @"http://c.m.163.com/nc/topicset/uc/api/discovery/index"
    [Network GetDataFromAFNetworkingWithURL:API CallBack:^(id responseObject) {
        discoveryModel = [[DiscoveryModel alloc] initWithDictionary:responseObject];
        [_tableVIew reloadData];
    }];
}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if (discoveryModel.recommendAndBannerDic) {
                return 1;
            }else{
                return 0;
            }
            break;
        case 1:
            if (discoveryModel.template.subTemplate.count) {
                return 1;
            }
            return 0;
            break;
        case 2:
            if (discoveryModel.activity.subActivity.count) {
                return 1;
            }
            return 0;
            break;
        default:
            return 0;
            break ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;

    switch (section) {
        case 0:
        {
            UtilityCell *cell = [tableView dequeueReusableCellWithIdentifier:kUtilityCellKey];
            [cell setDictionary:discoveryModel.recommendAndBannerDic];
            cell.rootViewController = self;
            return cell;
        }
            break;
        case 1:
        {
            AdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdvertiseCellKey];
            [cell setModel:discoveryModel.template];
            cell.rootViewController = self;
            return cell;
        }
            break;
        case 2:
        {
            AdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdvertiseCellKey];
            [cell setModel:discoveryModel.activity];
            cell.rootViewController = self;
            return cell;
        }
            break;
    }
    return nil;

}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0;
//    }else{
//        return 30;
//    }
//
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    if (section == 0) {
//        return nil;
//    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.frame.size.width - 30, view.frame.size.height)];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 0, 20, 20)];
//    imageView.image = [UIImage imageNamed:@"app_recommend_arrow"];
//    [view addSubview:imageView];
//    [view addSubview:label];
//    if (section == 1) {
//        label.text = discoveryModel.template.title;
//    }else{
//        label.text = discoveryModel.activity.title;
//    }
//    return view;
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [_tableVIew reloadData];
//}
@end

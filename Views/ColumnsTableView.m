//
//  ColumnsTableView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define API @"http://c.3g.163.com/nc/article/%@/%@/%d-%d.html"
#import "ColumnsTableView.h"
#import "Network.h"
#import "NewsModel.h"
#import "UIImageView+SetWebPImage.h"
#import "ColumnsTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#define kColumnsTableViewCellKey @"ColumnsTableViewCell"
@interface ColumnsTableView()<UIScrollViewDelegate,UITableViewDelegate>

@end
@implementation ColumnsTableView
{
    int initConstraintHeight;

    __weak IBOutlet UIView *titleView;
    __weak IBOutlet NSLayoutConstraint *iconViewToHeaderViewHeight;
    float lastOffsetY;
    __weak IBOutlet UIImageView *headerView;
    __weak IBOutlet UITableView *_tableView;



    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *aliasLabel;

    NSMutableArray *dataArray;

    NSString *categoryPath;
    NSString *categoryValue;
    int pageStart;
    int pageCount;

    BOOL isRequesting;

}
-(void)awakeFromNib{
    [_tableView registerNib:[UINib nibWithNibName:@"ColumnsTableViewCell" bundle:nil] forCellReuseIdentifier:kColumnsTableViewCellKey];
    initConstraintHeight = 40;
    iconView.layer.cornerRadius = 10;
    iconView.clipsToBounds = YES;

    __weak typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        pageStart = 0;
        [strongSelf getDataSource];
    }];
    

    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
}
//-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
//    pageStart = 0;
//    [self getDataSource];
//}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetY = scrollView.contentOffset.y;
    float deltaY = offsetY - lastOffsetY;
    lastOffsetY = offsetY;
    if (offsetY > 0 && iconViewToHeaderViewHeight.constant < headerView.frame.size.height ) {
        //NSLog(@"上 = %f",iconViewToHeaderViewHeight.constant);
        iconViewToHeaderViewHeight.constant += deltaY;

        if (iconViewToHeaderViewHeight.constant > headerView.frame.size.height) {
            iconViewToHeaderViewHeight.constant = headerView.frame.size.height;
        }
        scrollView.contentOffset = CGPointMake(0, 0);
    }else if(offsetY < 0 && iconViewToHeaderViewHeight.constant > initConstraintHeight){
        //NSLog(@"下 = %f",iconViewToHeaderViewHeight.constant);
        iconViewToHeaderViewHeight.constant += deltaY;

        if (iconViewToHeaderViewHeight.constant < initConstraintHeight) {
            iconViewToHeaderViewHeight.constant = initConstraintHeight;
        }
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    titleView.backgroundColor = [UIColor colorWithRed:1 green:0.000 blue:0.000 alpha:(CGFloat)(iconViewToHeaderViewHeight.constant - initConstraintHeight)/(headerView.frame.size.height - initConstraintHeight)];

    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 10) {
            if (isRequesting == NO) {
                isRequesting = YES;
                pageStart += 20;
                [self getDataSource];
            }
        }
    }

}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ColumnsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kColumnsTableViewCellKey];

    [cell setModel:dataArray[indexPath.row]];
    cell.rootViewController = self.rootViewController;
    return cell;
}
- (IBAction)gotoBackButtonClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}
-(void)setParameterDictionary:(NSDictionary *)parameterDictionary{
    categoryValue = parameterDictionary[kCategoryValueKey];
    categoryPath = parameterDictionary[kCategoryPathKey];
    pageStart = [parameterDictionary[kPageStartKey] intValue];
    pageCount = [parameterDictionary[kPageEndKey] intValue];
    dataArray = [NSMutableArray new];
    [self getDataSource];
}

-(void)getDataSource{
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    NSString *urlString = [NSString stringWithFormat:API,categoryPath,categoryValue,pageStart,pageCount];
    isRequesting = YES;
    [Network GetDataFromAFNetworkingWithURL:urlString CallBack:^(id responseObject) {
        if (pageStart == 0) {
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:[NewsModel getNewsModelArrayFromResponse:responseObject]];
        if (dataArray.count > 0) {

            NewsModel *newsmodel = dataArray[0];
            if (newsmodel.cid) {
                [headerView setWebPImageFromURLString:[NSString stringWithFormat:@"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/reading/cover1/%@.jpg.720x2147483647.75.auto.webp",newsmodel.cid]];
            }
            if (newsmodel.ename) {
                [iconView setWebPImageFromURLString:[NSString stringWithFormat:@"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.80x2147483647.75.auto.webp",newsmodel.ename]];
            }
            if (newsmodel.alias) {
                aliasLabel.text = newsmodel.alias;
            }
            [_tableView reloadData];
        }
        isRequesting = NO;
        [_tableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
    }];
}
//-(void)willMoveToWindow:(UIWindow *)newWindow{
//    [_tableView reloadData];
//}


- (IBAction)searchButtonClick:(UIButton *)sender
{

}

-(void)dealloc{
//    [_tableView removeObserver:mjHeaderView forKeyPath:@"contentOffset"];
//    mjHeaderView.delegate = nil;
//    mjHeaderView = nil;

}

@end

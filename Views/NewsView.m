//
//  NewsView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NewsView.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "NewsCell.h"
#import "ImgextraNewsCell.h"
#import "CategoryModel.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "SportsModel.h"
#import "SportsCustomCell.h"
#import "BoBoModel.h"
#import "MuiscModel.h"
#import "EntertainmentCell.h"
#import "LocalCellTableViewCell.h"
#import "Network.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UIView+ToastView.h"
#import "UIImageView+ImageLoading.h"



@interface NewsView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MJRefreshBaseViewDelegate>
{

    NSMutableArray *_dataArray;
    UIScrollView *topicNewScrollView;
    NSMutableArray *customCellDataArray;
    CategoryModel *categoryModel;
    UIViewController *viewController;
    int pageStart;
    int pageCount;
    BOOL isRequesting;

    MJRefreshHeaderView *headerView;

    BOOL isBeginReflash;
    BOOL isReflashing;

    float lastOffsetY;
}
@end


@implementation NewsView

- (instancetype)initWithFrame:(CGRect)frame WithParameterDictionary:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = HQNewViewTag;
        _dataArray = [NSMutableArray new];
        customCellDataArray = [[NSMutableArray alloc] initWithCapacity:3];
        categoryModel = dic[kCategoryModelKey];
        viewController = dic[kRootControllerKey];

        pageStart = 0;
        pageCount = 20;

        if ([categoryModel.name isEqualToString:@"体育"]) {
            [self sendRequestWithAFNetworkingWithURL:[SportsModel getURLString] Select:@selector(updateSportModel:)];
        }else if ([categoryModel.name isEqualToString:@"娱乐"]){
            [self sendRequestWithAFNetworkingWithURL:[BoBoModel getURLString] Select:@selector(updateBoBoModel:)];
            [self sendRequestWithAFNetworkingWithURL:[MuiscModel getURLString] Select:@selector(updateMuiscModel:)];
        }else if([categoryModel.name isEqualToString:@"本地"]){
            [customCellDataArray addObject:@(1)];
        }
        [self initNewsTableView:self.bounds];

        headerView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
        headerView.delegate = self;

        isRequesting = NO;

        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;

        [self addDataSource];
    }
    return self;
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    pageStart = 0;
    [self addDataSource];
}

-(void)initNewsTableView:(CGRect)tableViewRect{

    UIView *view=[[UIView alloc] initWithFrame:tableViewRect];
    view.tag = 2;
    _tableView = [[UITableView alloc] initWithFrame:view.bounds];
    _tableView.backgroundColor = kDefanltBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;

    int topicNewTitleLabelHeight = 20;
    int topicNewPicPageControllerWidth = 70;

    topicNewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.width * 480 / 720.0f) ];
    topicNewScrollView.tag = view.tag*10 + 1;
    UILabel *topNewTitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, topicNewScrollView.frame.size.height, _tableView.frame.size.width - topicNewPicPageControllerWidth, topicNewTitleLabelHeight)];
    topNewTitleView.tag = view.tag*10 + 2;
    topNewTitleView.backgroundColor = kDefanltBackgroundColor;
    UIPageControl *topNewsPageController = [[UIPageControl alloc] initWithFrame:CGRectMake(_tableView.frame.size.width - topicNewPicPageControllerWidth, topNewTitleView.frame.origin.y, topicNewPicPageControllerWidth, topNewTitleView.frame.size.height)];
    topNewsPageController.tag = view.tag *10 + 3;
    UIView *topicNewsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, topicNewScrollView.frame.size.height + topicNewTitleLabelHeight)];

    [topicNewsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoDetialView)]];

    topNewsPageController.backgroundColor = kDefanltBackgroundColor;

    [topicNewsView addSubview:topicNewScrollView];
    [topicNewsView addSubview:topNewsPageController];
    [topicNewsView addSubview:topNewTitleView];


    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:kNormalCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"ImgextraNewsCell" bundle:nil] forCellReuseIdentifier:kImgextraNewsCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"SportsCustomCell" bundle:nil] forCellReuseIdentifier:kSportsCustomCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"EntertainmentCell" bundle:nil] forCellReuseIdentifier:kEntertainmentCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"LocalCellTableViewCell" bundle:nil] forCellReuseIdentifier:kLocalCellIdentifier];
    [view addSubview:_tableView];
    _tableView.hidden = YES;
    [self addSubview:view];
    _tableView.tableHeaderView = topicNewsView;
}

-(void)reloadTopNewsView{
    if (_dataArray.count < 1) {
        return ;
    }
    UIView *view = [self viewWithTag:2];
    NewsModel *model = _dataArray[0];
    CGRect rect = topicNewScrollView.frame;
    if (model.imgextra.count > 0) {
        for (int i= 0; i < model.imgextra.count; i ++) {
            if (i == 0) {
                rect.origin.x +=rect.size.width;
                UIImageView *imageVIew = [[UIImageView alloc] initWithFrame:rect];
                [imageVIew loadImageWithUrlString:model.imgsrc];
//                [imageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil];
                [topicNewScrollView addSubview:imageVIew];
                topicNewScrollView.pagingEnabled = YES;
                rect.origin.x +=rect.size.width;
            }
            UIImageView *imageVIew = [[UIImageView alloc] initWithFrame:rect];
            [imageVIew loadImageWithUrlString:model.imgextra[i]];
//            [imageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgextra[i]] placeholderImage:nil];
            [topicNewScrollView addSubview:imageVIew];
            rect.origin.x +=rect.size.width;
        }
        UIImageView *lastImageVIew = [[UIImageView alloc] initWithFrame:rect];
        [lastImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil];
        [topicNewScrollView addSubview:lastImageVIew];
        rect.origin.x +=rect.size.width;
        UIImageView *fristImageVIew = [[UIImageView alloc] initWithFrame:topicNewScrollView.frame];
        [fristImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgextra[model.imgextra.count - 1]] placeholderImage:nil];
        [topicNewScrollView addSubview:fristImageVIew];
        topicNewScrollView.delegate = self;
    }else{
        UIImageView *imageVIew = [[UIImageView alloc] initWithFrame:topicNewScrollView.frame];
        [imageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil];
        [topicNewScrollView addSubview:imageVIew];
        rect.origin.x +=rect.size.width;
    }
    topicNewScrollView.contentSize = CGSizeMake(rect.origin.x, rect.size.height);
    topicNewScrollView.contentOffset = CGPointMake(rect.size.width, 0);
    topicNewScrollView.alwaysBounceVertical = NO;
    UILabel* topicNewTitleView = (UILabel*)[topicNewScrollView.superview viewWithTag:view.tag *10 + 2];
    UIPageControl* topicNewsPageController = (UIPageControl*)[topicNewScrollView.superview viewWithTag:view.tag *10 + 3];
    topicNewsPageController.userInteractionEnabled = NO;
    topicNewTitleView.text = model.title;


    topicNewsPageController.pageIndicatorTintColor = [UIColor colorWithWhite:0.500 alpha:0.300];
    topicNewsPageController.currentPageIndicatorTintColor = [UIColor redColor];
    topicNewsPageController.numberOfPages = rect.origin.x / rect.size.width - 2;
    topicNewsPageController.currentPage = 0;

}

-(void)sendRequestWithAFNetworkingWithURL:(NSString *)url Select:(SEL)selector{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self respondsToSelector:selector]) {
                [self performSelector:selector withObject:result];
            }
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];

}

#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([categoryModel.name isEqualToString:@"娱乐"]) {
            if (customCellDataArray.count < 3) {
                return 0;
            }
        }
        if ([categoryModel.name isEqualToString:@"体育"]) {
            if (customCellDataArray.count < 2) {
                return 0;
            }
        }
        if (customCellDataArray.count) {
            return 1;
        }
        return 0;
    }
    return _dataArray.count - 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {

        if ([categoryModel.name isEqualToString:@"体育"]) {
            SportsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kSportsCustomCellIdentifier];
            [cell setModel:customCellDataArray];
            return cell;
        }else if([categoryModel.name isEqualToString:@"娱乐"]){
                EntertainmentCell *cell = [tableView dequeueReusableCellWithIdentifier:kEntertainmentCellIdentifier];
                [cell setModel:customCellDataArray];
            return cell;
        }else if([categoryModel.name isEqualToString:@"本地"]){
            LocalCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocalCellIdentifier];
            return cell;
        }
        return nil;
    }
    NewsModel *model = _dataArray[indexPath.row + 1];
    NewsCell *cell;

    if (model.imgextra == nil) {
       cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellIdentifier];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:kImgextraNewsCellIdentifier];
    }
    [cell setModel:model];
    cell.backgroundColor = kDefanltBackgroundColor;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        NewsCell *cell = (NewsCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.rootViewController = self.rootViewController;
        [cell gotoDetialView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == topicNewScrollView) {
        NewsModel *model = _dataArray[0];
        CGPoint offset = scrollView.contentOffset;
        int width = scrollView.frame.size.width;
        int currentPage = offset.x / width;
        int scrollViewPageCount = (int)(model.imgextra.count) + 1;

        if (currentPage == 0) {
            [scrollView setContentOffset:CGPointMake(width * scrollViewPageCount, 0) animated:NO];
            currentPage = scrollViewPageCount;
        }else if(currentPage == scrollViewPageCount + 1){
            [scrollView setContentOffset:CGPointMake(width * 1, 0) animated:NO];
            currentPage = 1;
        }
        UIPageControl* topicNewsPageController = (UIPageControl*)[topicNewScrollView.superview viewWithTag:2*10 + 3];
        topicNewsPageController.currentPage = currentPage - 1;
    }else if (scrollView == _tableView){
        if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 10 && _dataArray.count > 0) {
            [self addDataSource];
        }
    }
}

- (void)updateSportModel:(NSDictionary  *)dic {
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    customCellDataArray = [SportsModel GetSportModel:dic];
    [_tableView reloadData];
}
- (void)updateBoBoModel:(NSArray *)array {
    NSMutableArray *arr= [BoBoModel GetBoBoModel:array];
    if (arr.count < 2) {
        return;
    }
    customCellDataArray[0] = arr[0];
    customCellDataArray[1] = arr[1];

    [self updateCustomCell];
}
- (void)updateMuiscModel:(NSDictionary *)dic {
    NSMutableArray *arr = [MuiscModel GetMuiscModel:dic];
    if (arr.count == 0) {
        return;
    }
    [customCellDataArray addObject:arr[0]];
    [self updateCustomCell];
}
-(void)updateCustomCell{
    if (customCellDataArray.count < 3) {
        return;
    }

    for (int i = 0; i < customCellDataArray.count; i ++) {
        if ([customCellDataArray[i] isKindOfClass:[NSNumber class]]) {
            [customCellDataArray removeObjectAtIndex:i];
            i --;
        }
    }
    if (customCellDataArray.count == 3) {
        [_tableView reloadData];
    }
}


-(void)addDataSource{
    if (isRequesting == YES) {
        return;
    }
    isRequesting = YES;
    categoryModel.pageStart = @(pageStart);
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [Network GetDataFromAFNetworkingWithURL:categoryModel.url CallBack:^(id responseObject) {
        if (responseObject) {
            NSArray *array = [NewsModel getNewsModelArrayFromResponse:responseObject];
            if (array.count > 0) {
                if (pageStart == 0) {
                    [_dataArray removeAllObjects];
                }else
                {
                    [UIView showToaseViewWithText:@"已为你加载20条新闻!" Time:1];
                }
                for (NewsModel *model in array) {
                    model.categoryModel = categoryModel;
                    [_dataArray addObject:model];
                }
                if (pageStart == 0) {
                    [self reloadTopNewsView];
                }
                [_tableView reloadData];
                pageStart += 20;
                _tableView.hidden = NO;
            }
        } else if (responseObject == nil) {
            if (pageStart == 0 && _dataArray.count == 0) {
                [self netWorkConnectFailure];
            }
            [UIView showToaseViewWithText:@"网络不给力哦" Time:3];
        }

        [headerView endRefreshing];
        isRequesting = NO;
        [MBProgressHUD hideHUDForView:self animated:YES];
    }];
}
- (void)gotoDetialView{
    if(_dataArray.count > 0){
        NSDictionary *dic = @{kNewsModelKey : _dataArray[0]};
        if (!_rootViewController)
        {
            return;
        }
        DetailViewController *detailViewController = [[DetailViewController alloc] init];
        detailViewController.parameterDictionary = dic;
        if ([_rootViewController isKindOfClass:[UINavigationController class]])
        {
            [(UINavigationController *)_rootViewController pushViewController:detailViewController animated:YES];
        }
    }
}

-(void)netWorkConnectFailure{
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = kDefanltBackgroundColor;
    view.tag = self.tag + 100;
    UIImage *image = [UIImage imageNamed:@"base_empty_view"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    imageView.image = image;
    imageView.center = view.center;
    [view addSubview:imageView];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadDataSoure)]];
    [self addSubview:view];
    [self bringSubviewToFront:view];
}

- (void)reloadDataSoure {
    UIView *view = [self viewWithTag:self.tag + 100];
    [view removeFromSuperview];
    [self addDataSource];
}

-(void)dealloc{
    [_tableView removeObserver:headerView forKeyPath:@"contentOffset"];
    headerView.delegate = nil;
    headerView = nil;
}

@end

//
//  NewsViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//
//http://c.3g.163.com/nc/article/headline/T1348647909107/0-20.html




#define API @"http://c.3g.163.com/nc/article/%@/%@/%d-%d.html"
#import "PrefixHeader.pch"

#import "NewsViewController.h"

#import "AFNetworking.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "NewsCell.h"
#import "NewsView.h"
#import "MBProgressHUD.h"
#import "CategoryModel.h"
#import "WeatherViewController.h"
#import "AllCategoryViewController.h"
#import "UIView+MaskView.h"


#define kCategoryNameButtonOffsetX 5
#define kCategoryNameButtonSpace 5


@interface NewsViewController()<UIScrollViewDelegate>
{
    UIScrollView *categoryNewsScrollView;
    NSArray *categoryModelArray;
    UIView *categoryNameIndicateView;
    float lastContentXOffset;
    WeatherViewController *weatherVC;

    NSInteger lastSelectButtonIndex;

    AllCategoryViewController *allCategoryVC;

    BOOL isCategoryButtonClilk;
}
@end
@implementation NewsViewController
-(void)viewDidLoad{

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"网易新闻";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.890 green:0.161 blue:0.188 alpha:1.000];


    //导航栏More按钮
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [moreButton setImage:[UIImage imageNamed:@"night_ic_menu_moreoverflow"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    moreButton.clipsToBounds = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];

    categoryModelArray = [CategoryModel GetAllModel];

    [self initCategoryNameView:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [self initCategoryNewsScrollView:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 30 - 48 - 65)];

    isCategoryButtonClilk = NO;
}

-(void)initCategoryNewsScrollView:(CGRect)rect{
    categoryNewsScrollView = [[UIScrollView alloc] initWithFrame:rect];
    categoryNewsScrollView.bounces = NO;
    categoryNewsScrollView.delegate = self;
    rect = categoryNewsScrollView.bounds;
    categoryNewsScrollView.pagingEnabled = YES;
    categoryNewsScrollView.showsVerticalScrollIndicator = NO;
    categoryNewsScrollView.showsHorizontalScrollIndicator = NO;

    UIView *view1 = [[UIView alloc] initWithFrame:rect];
    [categoryNewsScrollView addSubview:view1];
    rect.origin.x += rect.size.width;
    view1.backgroundColor = kDefanltBackgroundColor;
    NSDictionary *parameter = @{kCategoryModelKey:categoryModelArray[0],kRootControllerKey:self.navigationController};

    NewsView *newsView = [[NewsView alloc] initWithFrame:view1.bounds WithParameterDictionary:parameter];
    newsView.rootViewController = self.navigationController;
    [view1 addSubview:newsView];

    //[categoryNewsViewArray addObject:view1];
    view1.tag = HQCategoryNewsViewFirstTag + 0;

    for (int i = 1; i < categoryModelArray.count; i ++) {
        UIView *view2 = [[UIView alloc] initWithFrame:rect];
        view2.backgroundColor = kDefanltBackgroundColor;
        view2.tag = HQCategoryNewsViewFirstTag+i;
        [categoryNewsScrollView addSubview:view2];
        rect.origin.x += rect.size.width;
    }
    [self.view addSubview:categoryNewsScrollView];
    categoryNewsScrollView.contentSize = CGSizeMake(rect.origin.x, rect.size.height);
}

-(void)initCategoryNameView:(CGRect)categoryNameRect{
    int categoryArrowButtonHeight = categoryNameRect.size.height;
    int categoryArrowButtonWidth = categoryArrowButtonHeight;
    UIView *view = [[UIView alloc] initWithFrame:categoryNameRect];
    view.tag = HQCategoryNameViewTag;

    view.backgroundColor = kDefanltBackgroundColor;
    UIScrollView *categoryNameScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width - categoryArrowButtonWidth, categoryArrowButtonHeight)];

    categoryNameScrollView.showsHorizontalScrollIndicator = NO;
    categoryNameScrollView.showsVerticalScrollIndicator = NO;
        categoryNameScrollView.bounces = NO;
    categoryNameScrollView.backgroundColor = [UIColor blueColor];

    categoryNameScrollView.backgroundColor = [UIColor colorWithWhite:0.980 alpha:1.000];
    CGSize size = CGSizeZero;
    size.height = categoryNameScrollView.bounds.size.height;
    for (int i = 0; i < categoryModelArray.count; i ++) {
        CategoryModel *model = categoryModelArray[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * categoryNameScrollView.bounds.size.width / 5 + kCategoryNameButtonOffsetX, 5, (categoryNameScrollView.bounds.size.width)/5.0f - kCategoryNameButtonSpace, categoryNameScrollView.bounds.size.height - 10)];
        button.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        button.tag = HQCategoryButtonFirstTag + i;

        if (i == 0) {
            button.selected = YES;
            lastSelectButtonIndex = 0;
            categoryNameIndicateView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x, categoryNameScrollView.frame.size.height - 3, button.frame.size.width,3)];
            categoryNameIndicateView.backgroundColor = [UIColor colorWithRed:0.890 green:0.161 blue:0.188 alpha:1.000];
            [categoryNameScrollView addSubview:categoryNameIndicateView];
        }
//        [button setTitle:[[NSString stringWithFormat:@"%d",i] stringByAppendingString:model.name] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];


        [button setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.882 green:0.000 blue:0.020 alpha:1.000] forState:UIControlStateSelected];
        [categoryNameScrollView addSubview:button];
        size.width += categoryNameScrollView.bounds.size.width/5;

        [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    [categoryNameScrollView bringSubviewToFront:categoryNameIndicateView];

    UIButton *catrgroyArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - categoryArrowButtonWidth + 5, 0 + 5, categoryArrowButtonWidth - 10 , categoryArrowButtonHeight-10)];
    [catrgroyArrowButton setBackgroundImage:[UIImage imageNamed:@"night_biz_tie_comment_expand_arrow"] forState:UIControlStateNormal];
    [catrgroyArrowButton addTarget:self action:@selector(catrgroyArrowButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:categoryNameScrollView];
    [view addSubview:catrgroyArrowButton];
    [self.view addSubview:view];

    categoryNameScrollView.contentSize = size;
    categoryNameScrollView.contentOffset = CGPointZero;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"&&&&&&&&&已经滚动");
    int pitch = categoryNameIndicateView.frame.size.width + kCategoryNameButtonSpace;
    float contentXOffset = scrollView.contentOffset.x;
    float deltaMoveX = contentXOffset - lastContentXOffset;
    lastContentXOffset = contentXOffset;
    deltaMoveX = deltaMoveX / scrollView.frame.size.width * pitch;
    CGRect frame = categoryNameIndicateView.frame;
    frame.origin.x += deltaMoveX;
    categoryNameIndicateView.frame = frame;

    int page = (contentXOffset + categoryNewsScrollView.frame.size.width/2) / categoryNewsScrollView.frame.size.width;

    if (page <= categoryModelArray.count - 1  && isCategoryButtonClilk == NO) {
        [self addNewsView:page];

        if (page < categoryModelArray.count - 1) {
            [self addNewsView:page + 1];
        }
        if (page > 0) {
            [self addNewsView:page - 1];
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"&&&&&&&&&结束滚动");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

//    NSLog(@"++++++++++++结束减速");
    [self newsScrollViewMove:scrollView.contentOffset.x];
    isCategoryButtonClilk = NO;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"=========结束滚动动画");
    [self newsScrollViewMove:scrollView.contentOffset.x];
    isCategoryButtonClilk = NO;


}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"*********将会结束滚动");

}

- (void)moreButtonClick {
    if(!weatherVC){
        weatherVC = [[WeatherViewController alloc] init];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [view addSubview:weatherVC.view];
        view.clipsToBounds = YES;
        view.center = CGPointMake(view.center.x, view.center.y - 40);
        [self.view addSubview:view];
        view.backgroundColor =  [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.800];
            view.center = CGPointMake(view.center.x, view.center.y + 40);
        } completion:^(BOOL finished) {
        }];
    }else{

        [UIView animateWithDuration:1 animations:^{
            weatherVC.view.superview.transform = CGAffineTransformMakeScale(0.01, 0.01);
            weatherVC.view.superview.opaque = NO;
            weatherVC.view.superview.alpha = 0;
            weatherVC.view.superview.center = CGPointMake(self.view.frame.size.width - 50 + 20, -20);

        } completion:^(BOOL finished) {
            [weatherVC.view.superview removeFromSuperview];
            weatherVC = nil;
        }];
    }
}

- (void)categoryButtonClick:(UIButton *)sender {

    UIButton *button = (UIButton *)[self.view viewWithTag:HQCategoryButtonFirstTag + lastSelectButtonIndex];
    button.selected = NO;



    sender.selected = YES;
    lastSelectButtonIndex = sender.tag - HQCategoryButtonFirstTag;
    NSInteger index = sender.tag - 1000 - 100;
    isCategoryButtonClilk = YES;
    int width = categoryNewsScrollView.frame.size.width;
    [categoryNewsScrollView setContentOffset:CGPointMake(index * width, 0) animated:YES];
    [self addNewsView:index];
}

-(void)setLocationForIndicateView:(NSInteger)index{

    UIButton *categoryButton = (UIButton *)[self.view viewWithTag:HQCategoryButtonFirstTag + lastSelectButtonIndex];
    categoryButton.selected = NO;
    categoryButton = (UIButton *)[self.view viewWithTag:index + HQCategoryButtonFirstTag];
    categoryButton.selected = YES;
    lastSelectButtonIndex = index;

    NSInteger count = categoryModelArray.count;
    UIScrollView *scrollView = (UIScrollView *)categoryNameIndicateView.superview;
    int pitch = (categoryNameIndicateView.frame.size.width + kCategoryNameButtonSpace);
    int orign = kCategoryNameButtonOffsetX;

    NSInteger loctionXForScrollView = 0;
    NSInteger loctionXForIndicateView = 0;
    if(index <= 1 ||(int)(scrollView.contentOffset.x / pitch) == (index+2) || index + 1 >= count - 1){
        if (index <=1) {
            loctionXForScrollView = 0;
        }else if(index + 1 >= count - 1){
            loctionXForScrollView = pitch * (count - 5);
        }
        loctionXForIndicateView = pitch * index + orign;

    }else{
        loctionXForScrollView =  (index-2) * pitch;
        loctionXForIndicateView = (index) * pitch + orign;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [scrollView setContentOffset:CGPointMake(loctionXForScrollView, 0) animated:NO];
        CGRect frame = categoryNameIndicateView.frame;
        frame.origin.x = loctionXForIndicateView;
        categoryNameIndicateView.frame = frame;
    } completion:nil];
}

-(void)newsScrollViewMove:(CGFloat)contentXOffset{
    contentXOffset = categoryNewsScrollView.contentOffset.x;
    int page = contentXOffset/categoryNewsScrollView.frame.size.width;
    [self setLocationForIndicateView:page];
}

-(void)addNewsView:(NSInteger)page{
    UIView *view = [categoryNewsScrollView viewWithTag:HQCategoryNewsViewFirstTag + page];
    if (view.subviews.count == 0) {
        NSDictionary *parameter = @{kCategoryModelKey:categoryModelArray[page],kRootControllerKey:self.navigationController};
        NewsView *newView = [[NewsView alloc] initWithFrame:view.bounds WithParameterDictionary:parameter];
        newView.rootViewController = self.navigationController;
        [view addSubview:newView];
        [UIView showToaseViewWithText:[NSString stringWithFormat:@"第%ld页",page] Time:3];
    }
}

- (void)catrgroyArrowButtonClick:(UIButton *)sender {
    UIView *view = [self.view viewWithTag:HQAllCatrgroyViewTag];
//    UIButton *catrgroyArrowButton = (UIButton *)[self.view viewWithTag:HQCatrgroyArrowButtonTag];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
        [self.view addSubview:view];
        view.backgroundColor = kDefanltBackgroundColor;
        view.tag = HQAllCatrgroyViewTag;


        allCategoryVC = [[AllCategoryViewController alloc] init];
        [CategoryModel setSelectedModel:categoryModelArray[lastSelectButtonIndex]];

        allCategoryVC.newsVC = self;
        allCategoryVC.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 0);
        allCategoryVC.view.contentMode = UIViewContentModeTop;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.autoresizingMask = UIViewAutoresizingNone;
        [view addSubview:allCategoryVC.view];

//        catrgroyArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 30 + 5, 5, 20, 20)];
//        [catrgroyArrowButton setBackgroundImage:[UIImage imageNamed:@"night_biz_tie_comment_expand_arrow"] forState:UIControlStateNormal];
//        [catrgroyArrowButton addTarget:self action:@selector(catrgroyArrowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        catrgroyArrowButton.tag = HQCatrgroyArrowButtonTag;
//        [view addSubview:catrgroyArrowButton];
//        [view bringSubviewToFront:catrgroyArrowButton];
//
//        CGRect frame = view.frame;
//        frame.size.height = 20;
//        view.frame = frame;
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect frame = view.frame;
//            frame.size.height = self.view.frame.size.height;
//            view.frame = frame;
//            catrgroyArrowButton.transform = CGAffineTransformMakeRotation(M_PI);
//        }];
    }else{
//        [CategoryModel writeToFile];
//        [self categoryButtonClick:(UIButton *)[self.view viewWithTag:allCategoryVC.selectedIndex + HQCategoryButtonFirstTag]];
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            CGRect frame = view.frame;
//            frame.size.height = 20;
//            view.frame = frame;
//            catrgroyArrowButton.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [view removeFromSuperview];
//        }];
    }
}

-(void)newsViewMoveToIndex:(NSInteger)toIndex FromIndex:(NSInteger)fromIndex{
    [self viewInsertToTag:HQCategoryNewsViewFirstTag+toIndex FromTag:HQCategoryNewsViewFirstTag+fromIndex];
    [self viewInsertToTag:HQCategoryButtonFirstTag+toIndex FromTag:HQCategoryButtonFirstTag+fromIndex];
}
-(void)viewInsertToTag:(NSInteger)toTag FromTag:(NSInteger)fromTag{
    UIButton *selectedButton = (UIButton *)[self.view viewWithTag:HQCategoryButtonFirstTag+lastSelectButtonIndex];
    if (toTag > fromTag) {
        for (NSInteger i = fromTag; i < toTag; i ++) {
            [self viewExchangeToTag:i FromTag:i+1];
        }
    }else{
        for (NSInteger i = fromTag; i > toTag; i --) {
            [self viewExchangeToTag:i FromTag:i-1];
        }
    }
    lastSelectButtonIndex = selectedButton.tag - HQCategoryButtonFirstTag;
}
-(void)viewExchangeToTag:(NSInteger)toTag FromTag:(NSInteger)fromTag{
    UIView* toView = [self.view viewWithTag:toTag];
    UIView* fromView = [self.view viewWithTag:fromTag];

    CGRect viewRect = [toView frame];
    CGRect nextViewRect = [fromView frame];

    toView.frame = nextViewRect;
    fromView.frame = viewRect;

    toView.tag = fromTag;
    fromView.tag = toTag;
}

-(void)didReceiveMemoryWarning{
    float contentXOffset = categoryNewsScrollView.contentOffset.x;
    int page = (contentXOffset + categoryNewsScrollView.frame.size.width/2) / categoryNewsScrollView.frame.size.width;

    for (int i=0;i < categoryModelArray.count;i ++) {
        if (i==page-1 || i==page || i==page+1) {
            continue;
        }
        UIView *view = [self.view viewWithTag:HQCategoryNewsViewFirstTag+i];
        for (UIView *subView in view.subviews) {
            [subView removeFromSuperview];
        }
    }

}

@end

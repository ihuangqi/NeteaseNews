//
//  MediaViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MediaViewController.h"
#import "Network.h"
#import "MediaModel.h"
#import "MediaCell.h"
#import "VideoTableView.h"
#import "RadioTableView.h"

@interface MediaViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *dataArray;
    VideoTableView *videoTableView;
    RadioTableView *radioTableView;

    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIView *titleView;

    float lastOffsetX;
    __weak IBOutlet UIButton *videoButton;
    __weak IBOutlet UIButton *radioButton;
    __weak IBOutlet NSLayoutConstraint *scrollIndicatorConstraint;
    __weak IBOutlet NSLayoutConstraint *buttonWidth;



}
@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGRect frame = _scrollView.frame;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width;
//    _scrollView.frame = frame;
    
    videoTableView = [[VideoTableView alloc] initWithFrame:_scrollView.bounds];
    videoTableView.rootViewController = self;
    [_scrollView addSubview:videoTableView];

    _scrollView.contentSize = CGSizeMake(2*_scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    [videoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [radioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    
    [videoButton setTitleColor:[UIColor colorWithWhite:0.667 alpha:1.000] forState:UIControlStateNormal];
    [radioButton setTitleColor:[UIColor colorWithWhite:0.667 alpha:1.000] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [videoTableView reloadData];
    [radioTableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != _scrollView) {
        return;
    }
    float offsetX = scrollView.contentOffset.x;
    float deltaX = offsetX - lastOffsetX;
    lastOffsetX = offsetX;
    scrollIndicatorConstraint.constant += deltaX * buttonWidth.constant / scrollView.frame.size.width;
    if ((offsetX + scrollView.frame.size.width / 2) / scrollView.frame.size.width >= 1) {
            if (!radioTableView) {
                NSLock *lock = [[NSLock alloc] init];
                if ([lock tryLock]) {            
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    radioTableView = [[RadioTableView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [scrollView addSubview:radioTableView];
                        radioTableView.rootViewController = self;
                    });
                });
            }
        }
        videoButton.selected = NO;
        radioButton.selected = YES;
        

    }else{
        videoButton.selected = YES;
        radioButton.selected = NO;
    }
}

- (IBAction)videoButtonClick:(UIButton *)sender {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)radioButtonClick:(UIButton *)sender {
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ReadViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ReadViewController.h"
#import "Network.h"
#import "RecommendModel.h"
#import "RecommendCell.h"
#import "SubscribeModel.h"
#import "RecommendTableView.h"
#import "MySubscribeTableView.h"
#import "AllColunmsView.h"

@interface ReadViewController()<UIScrollViewDelegate>
{
    __weak IBOutlet NSLayoutConstraint *scrollIndicator;
    __weak IBOutlet NSLayoutConstraint *buttonWidth;
    __weak IBOutlet UIScrollView *_scrollView;

    MySubscribeTableView *_mySubscribeTableView;

    RecommendTableView *_recommendTableView;

    float lastOffsetX;

    __weak IBOutlet UIButton *recommendButton;
    __weak IBOutlet UIButton *myReadButton;
}
@end
@implementation ReadViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    CGRect frame = _scrollView.frame;
    frame.size.width = self.view.frame.size.width;
    _scrollView.frame = frame;

    CGRect bounds = _scrollView.bounds;
    _recommendTableView = [[RecommendTableView alloc] initWithFrame:bounds RootViewControler:self];
    [_scrollView addSubview:_recommendTableView];
    _recommendTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    bounds.origin.x += bounds.size.width;

    _mySubscribeTableView =[[MySubscribeTableView alloc] initWithFrame:bounds RootViewControler:self];
    [_scrollView addSubview:_mySubscribeTableView];
    _mySubscribeTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    _scrollView.contentSize = CGSizeMake(bounds.origin.x + bounds.size.width,bounds.size.height);
    _scrollView.delegate = self;
    [recommendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [myReadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [recommendButton setTitleColor:[UIColor colorWithWhite:0.667 alpha:1.000] forState:UIControlStateNormal];
    [myReadButton setTitleColor:[UIColor colorWithWhite:0.667 alpha:1.000] forState:UIControlStateNormal];

    recommendButton.selected = YES;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != _scrollView) {
        return;
    }
    float offsetX = scrollView.contentOffset.x;
    float deltaX = offsetX - lastOffsetX;
    lastOffsetX = offsetX;
    scrollIndicator.constant += deltaX * buttonWidth.constant / scrollView.frame.size.width;
    if ((offsetX + scrollView.frame.size.width / 2) / scrollView.frame.size.width >= 1) {
        recommendButton.selected = NO;
        myReadButton.selected = YES;

    }else{
        recommendButton.selected = YES;
        myReadButton.selected = NO;
    }
}

- (IBAction)recomendButtonClick:(UIButton *)sender {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)mySubscrobeButtonClick:(UIButton *)sender {
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}

- (IBAction)allSubscribeButtonClick:(UIButton *)sender {

    UIView  *colunmsView  = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49)];
    NSLog(@"%@",NSStringFromCGRect(colunmsView.frame));
    AllColunmsView *allColunmsView = [[UINib nibWithNibName:@"AllColunmsView" bundle:nil] instantiateWithOwner:self options:nil][0];
    allColunmsView.rootViewController = self;
    [colunmsView addSubview:allColunmsView];
    NSDictionary *views = NSDictionaryOfVariableBindings(allColunmsView);
    allColunmsView.translatesAutoresizingMaskIntoConstraints = NO;
    [colunmsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[allColunmsView]|" options:0 metrics:nil views:views]];
    [colunmsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[allColunmsView]|" options:0 metrics:nil views:views]];
    if ([self isKindOfClass:[UINavigationController class]]) {

    }else{
        [self.view addSubview:colunmsView];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            colunmsView.transform = CGAffineTransformMakeTranslation(-colunmsView.frame.size.width, 0);
        } completion:^(BOOL finished) {
        }];
    }

}


@end

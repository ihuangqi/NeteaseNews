//
//  MediaBaseCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MediaBaseCell.h"
#import "RadioDetialView.h"

@implementation MediaBaseCell


- (void)openRadioDetailView:(NSDictionary *)parameterDictionary FromView:(UIView *)view {
    UIColor *color =  view.backgroundColor;
    view.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:0.5000];

    UIView  *radioView  = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49)];
    NSLog(@"%@",NSStringFromCGRect(radioView.frame));
    RadioDetialView *radioDetialView = [[UINib nibWithNibName:@"RadioDetialView" bundle:nil] instantiateWithOwner:self options:nil][0];
    radioDetialView.rootViewController = self.rootViewController;

    radioDetialView.parameterDictionary = parameterDictionary;
    [radioView addSubview:radioDetialView];
    NSDictionary *views = NSDictionaryOfVariableBindings(radioDetialView);
    radioDetialView.translatesAutoresizingMaskIntoConstraints = NO;
    [radioView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[radioDetialView]|" options:0 metrics:nil views:views]];
    [radioView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[radioDetialView]|" options:0 metrics:nil views:views]];

    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {

    }else{
        [_rootViewController.view addSubview:radioView];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            radioView.transform = CGAffineTransformMakeTranslation(-radioView.frame.size.width, 0);
        } completion:^(BOOL finished) {
            view.backgroundColor = color;
        }];
    }
}

@end

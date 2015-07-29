//
//  BaseCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ReadBaseCell.h"
#import "ColumnsTableView.h"
#import "DetailViewController.h"

@implementation ReadBaseCell
- (void)openNewDetailView:(NSDictionary *)parameterDictionary FromView:(UIView *)view {
    UIColor *color =  view.backgroundColor;
    view.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:0.5000];

    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.modalTransitionStyle = arc4random() % 7;
    detailViewController.parameterDictionary = parameterDictionary;

    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {

    }else{
        [_rootViewController presentViewController:detailViewController animated:YES completion:^{
            view.backgroundColor = color;
        }];
    }

}
- (void)openColunmsView:(NSDictionary *)parameterDictionary FromView:(UIView *)view {
    UIColor *color =  view.backgroundColor;
    view.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:0.5000];
    UIView  *colunmsView  = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49)];
    NSLog(@"%@",NSStringFromCGRect(colunmsView.frame));
    ColumnsTableView *columnsTableView = [[UINib nibWithNibName:@"ColumnsTableView" bundle:nil] instantiateWithOwner:self options:nil][0];
    columnsTableView.rootViewController = self.rootViewController;
    columnsTableView.parameterDictionary = parameterDictionary;
    [colunmsView addSubview:columnsTableView];
    NSDictionary *views = NSDictionaryOfVariableBindings(columnsTableView);
    columnsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [colunmsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[columnsTableView]|" options:0 metrics:nil views:views]];
    [colunmsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[columnsTableView]|" options:0 metrics:nil views:views]];
    
    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {

    }else{
        [_rootViewController.view addSubview:colunmsView];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            colunmsView.transform = CGAffineTransformMakeTranslation(-colunmsView.frame.size.width, 0);
        } completion:^(BOOL finished) {
            view.backgroundColor = color;
        }];
    }
}

@end

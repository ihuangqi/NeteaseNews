//
//  UIView+ToastView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/19.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UIView+ToastView.h"

@implementation UIView (ToastView)

//static UIView *toastView = nil;
//static UILabel *toastLabel = nil;
//static UIFont *toastFont = nil;
+(void)showToaseViewWithText:(NSString *)text Time:(float)time{
    if (text == nil && text.length == 0) {
        return;
    }
    UIView *toastView;
    UILabel *toastLabel;
    UIFont *toastFont;
//    if (toastView) {
//        [toastView removeFromSuperview];
//    }
//    if (toastView == nil) {
        toastView = [[UIView alloc] initWithFrame:CGRectZero];
        toastView.backgroundColor = [UIColor clearColor];
        toastView.clipsToBounds = NO;

        toastLabel = [[UILabel alloc] init];
        toastLabel.textAlignment = NSTextAlignmentCenter;
        toastLabel.layer.cornerRadius = 10;
        toastLabel.layer.borderWidth = 1;
        toastLabel.layer.borderColor = [UIColor colorWithRed:0.200 green:0.800 blue:0.200 alpha:0.500].CGColor;
        toastLabel.textColor = [UIColor whiteColor];
        toastLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
        toastLabel.clipsToBounds = YES;

        [toastView addSubview:toastLabel];

        toastFont = [UIFont systemFontOfSize:15];
        toastLabel.font = toastFont;
//    }

    CGRect rect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 5 / 20.0) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:toastFont} context:nil];
    toastLabel.text = text;
    toastLabel.frame = CGRectMake(0, 0, rect.size.width + 20, rect.size.height + 20);
    toastLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height * 17 / 20.0);

    toastView.opaque = 0;
    toastView.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow] addSubview:toastView];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:toastView];

    [UIView animateWithDuration:0.5 animations:^{
        toastView.alpha = 1;
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideToastView:) userInfo:toastView repeats:NO];
    }];

}

+ (void)hideToastView:(NSTimer *)timer {
    UIView *view = timer.userInfo;

    [UIView animateWithDuration:1 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

@end

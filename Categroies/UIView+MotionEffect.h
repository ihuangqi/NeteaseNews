//
//  UIView+MotionEffect.h
//  NeteaseNews
//
//  Created by 004 on 15/7/1.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (MotionEffect)

@property (nonatomic, strong) UIMotionEffectGroup  *effectGroup;

- (void)addXAxisWithValue:(CGFloat)xValue YAxisWithValue:(CGFloat)yValue;
- (void)removeSelfMotionEffect;

@end

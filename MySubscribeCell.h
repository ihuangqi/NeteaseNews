//
//  MySubscribeCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
#import "ReadBaseCell.h"

#define kNewsModelKey @"NewsModel"

@interface MySubscribeCell : ReadBaseCell
@property (nonatomic, strong) ColumnModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

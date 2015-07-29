//
//  ColumnsTableViewCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "ReadBaseCell.h"

@interface ColumnsTableViewCell : ReadBaseCell
@property (nonatomic, strong) NewsModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

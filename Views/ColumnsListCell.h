//
//  ColumnsListCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnsModel.h"
#import "ReadBaseCell.h"

@interface ColumnsListCell : ReadBaseCell
@property (nonatomic, strong) ColumnsModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

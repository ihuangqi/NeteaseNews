//
//  RecommendSubscribeCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendListModel.h"
#import "ReadBaseCell.h"

@interface RecommendSubscribeCell : ReadBaseCell
@property (nonatomic, strong) RecommendListModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

//
//  RadioTopCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RadioTemplateModel.h"
#import "MediaBaseCell.h"
@interface RadioTopCell : MediaBaseCell
@property (nonatomic, strong) RadioTemplateModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

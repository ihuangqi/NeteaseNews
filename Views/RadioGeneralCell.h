//
//  RadioGeneralCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RadioclassifyModel.h"
#import "MediaBaseCell.h"
@interface RadioGeneralCell : MediaBaseCell
@property (nonatomic, strong) RadioclassifyModel* model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end

//
//  DetailViewController.h
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNewsModel.h"

#define kNewsModelKey @"NewsModel"

@interface DetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary* parameterDictionary;
-(void)setModel:(DetailNewsModel *)model;
@end

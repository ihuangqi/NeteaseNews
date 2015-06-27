//
//  NewsBaseModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/15.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define kNewsModelKey @"NewsModel"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NewsBaseCelll : UITableViewCell
@property (nonatomic, weak) UIViewController* rootViewController;
- (void)gotoDetialView:(NSDictionary *)dic;
@end

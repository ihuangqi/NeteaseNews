//
//  BaseCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kCategoryValueKey @"CategoryValue"
#define kCategoryPathKey @"CategoryPath"
#define kPageStartKey @"PageStart"
#define kPageEndKey @"PageEnd"


@interface ReadBaseCell : UITableViewCell
@property (nonatomic, strong) UIViewController* rootViewController;

- (void)openNewDetailView:(NSDictionary *)parameterDictionary FromView:(UIView *)view;
- (void)openColunmsView:(NSDictionary *)parameterDictionary FromView:(UIView *)view;
@end

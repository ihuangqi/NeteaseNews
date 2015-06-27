//
//  MediaBaseCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MediaBaseCell : UITableViewCell
@property (nonatomic, strong) UIViewController* rootViewController;

- (void)openRadioDetailView:(NSDictionary *)parameterDictionary FromView:(UIView *)view;
@end
